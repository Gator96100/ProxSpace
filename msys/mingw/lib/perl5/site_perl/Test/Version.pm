package Test::Version;
use 5.006;
use strict;
use warnings;
use Carp;

our $VERSION = '2.03'; # VERSION

use parent 'Exporter';
use Test::Builder;
use version 0.86 qw( is_lax is_strict );
use File::Find::Rule::Perl;
use Test::More;
use Module::Metadata;

our @EXPORT = qw( version_all_ok ); ## no critic (Modules::ProhibitAutomaticExportation)
our @EXPORT_OK = qw( version_ok );

my $cfg;

sub import { ## no critic qw( Subroutines::RequireArgUnpacking Subroutines::RequireFinalReturn )
  my @exports;
  foreach my $param ( @_ ) {
    unless ( ref( $param ) eq 'HASH' ) {
      push @exports, $param;
    } else {
      $cfg = $param
    }
  }

  $cfg->{is_strict}
    = defined $cfg->{is_strict}           ? $cfg->{is_strict}
    :                                       0
    ;

  $cfg->{has_version}
    = defined $cfg->{has_version}         ? $cfg->{has_version}
    :                                       1
    ;

  $cfg->{consistent}
    = defined $cfg->{consistent}          ? $cfg->{consistent}
    :                                       0
    ;

  $cfg->{filename_match}
    = defined $cfg->{filename_match}      ? $cfg->{filename_match}
    :                                       []
    ;

  $cfg->{multiple}
    = defined $cfg->{multiple}            ? $cfg->{multiple}
    :                                       0
    ;

  unless(ref($cfg->{filename_match}) eq 'ARRAY') {
          $cfg->{filename_match} = [$cfg->{filename_match}];
  }

  my $mmv = version->parse( $Module::Metadata::VERSION );
  my $rec = version->parse( '1.000020'  );
  if ( $mmv >= $rec && ! defined $cfg->{ignore_unindexable} ) {
    $cfg->{ignore_unindexable} = 1;
  }

  __PACKAGE__->export_to_level( 1, @exports );
}

my $version_counter = 0;
my $version_number;
my $consistent = 1;
my %versions;

my $test = Test::Builder->new;

our $_IN_VERSION_ALL_OK = 0;

sub version_ok {
  my ( $file, $name ) = @_;
  $file ||= '';
  $name ||= "check version in '$file'";

  croak 'No file passed to version_ok().' unless $file;

  croak "'$file' doesn't exist." unless -e $file;

  my $info = Module::Metadata->new_from_file( $file );
  if ( $cfg->{ignore_unindexable} && ! $info->is_indexable) {
    $test->skip( "$file not indexable" );
    return 0;
  }

  if(@{ $cfg->{filename_match} } > 0) {
    my $match = 0;
    foreach my $pattern (@{ $cfg->{filename_match} }) {

      if(ref($pattern) eq 'Regexp') {
        $match = 1 if $file =~ $pattern;
      }

      elsif(ref($pattern) eq 'CODE') {
        $match = 1 if $pattern->($file);
      }

      else {
        $match = 1 if $file eq $pattern;
      }

      last if $match;
    }
    unless ($match) {
      $test->skip( "$file does not match filename_match" );
      return 0;
    }
  }

  my $ok = 1;
  my @diag;
  my @packages = $cfg->{multiple} ? $info->packages_inside : ($info->name);

  unless($_IN_VERSION_ALL_OK) {
    $consistent = 1;
    $version_number  = undef;
  }

  unless($cfg->{has_version}) {
    @packages = grep { $info->version($_) } @packages;
    unless(@packages) {
      $test->skip(qq{No versions were found in "$file" and has_version is false});
      $consistent = 0;
      $versions{$file}->{$info->name} = undef;
      return 1;
    }
  }

  unless(@packages) {
    $ok = 0;
    push @diag, "No packages found in '$file'";
  }

  foreach my $package (@packages) {

    my $version = $info->version($package);

    $versions{$file}->{$package} = $version;

    if (not defined $version) {
      $consistent = 0;
    }

    $version_counter++;

    unless ( $version ) {
      $ok = 0;
      push @diag, "No version was found in '$file' ($package).";
      next;
    }

    unless (defined $version_number) {
      $version_number = $version;
    }
    if ($version ne $version_number) {
      $consistent = 0;
    }

    unless ( is_lax( $version ) ) {
      $ok = 0;
      push @diag, "The version '$version' found in '$file' ($package) is invalid.";
      next;
    }

    if ( $cfg->{is_strict} ) {
      unless ( is_strict( $version ) ) {
        $ok = 0;
        push @diag, "The version '$version' found in '$file' ($package) is not strict.";
        next;
      }
    }
  }

  unless($_IN_VERSION_ALL_OK) {
    if($ok && ! $consistent && $cfg->{consistent}) {
      $ok = 0;
      push @diag, "The versions found in '$file' are inconsistent.";
    }
  }

  $test->ok( $ok, $name );
  $test->diag($_) for @diag;
  return $ok;
}

sub version_all_ok {
  my ( $dir, $name ) = @_;

  $version_counter = 0;
  $version_number  = undef;
  $consistent      = 1;
  %versions        = ();

  $dir
    = defined $dir ? $dir
    : -d 'blib'    ? 'blib'
    :                'lib'
    ;

  croak $dir . ' does not exist, or is not a directory' unless -d $dir;

  # Report failure location correctly - GH #1
  local $Test::Builder::Level = $Test::Builder::Level + 1; ## no critic (Variables::ProhibitPackageVars)

  $name ||= "all modules in $dir have valid versions";

  my @files = File::Find::Rule->perl_module->in( $dir );

  {
    local $_IN_VERSION_ALL_OK = 1;
    foreach my $file ( @files ) {
      version_ok( $file );
    }
  }

  if ($cfg->{consistent} and not $consistent) {
    $test->ok( 0, $name );
    $test->diag('The version numbers in this distribution are not the same');
    foreach my $file (sort keys %versions) {
      foreach my $package (sort keys %{ $versions{$file} }) {
        my $version = $versions{$file}->{$package};
        $test->diag(sprintf "%10s %s (%s)", defined $version ? $version : 'undef', $file, $package);
      }
    }
    return;
  }

  # has at least 1 version in the dist
  if ( not $cfg->{has_version} and $version_counter < 1 ) {
    $test->ok( 0, $name );
    $test->diag(
      'Your dist has no valid versions defined. '
      . 'Must have at least one version'
      );
  }
  else {
    $test->ok( 1, $name );
  }

  return;
}
1;

# ABSTRACT: Check to see that version's in modules are sane

__END__

=pod

=encoding UTF-8

=head1 NAME

Test::Version - Check to see that version's in modules are sane

=head1 VERSION

version 2.03

=head1 SYNOPSIS

  use Test::More;
  use Test::Version 1.001001 qw( version_all_ok ), {
      is_strict   => 0,
      has_version => 1,
      consistent  => 1,
    };

  # test blib or lib by default
  version_all_ok();

  done_testing;

=head1 DESCRIPTION

This module's goal is to be a one stop shop for checking to see that your
versions across your dist are sane. Please ensure that you use version C<0.04>
or later only, as earlier versions are old code and may not work correctly.
Current feature list:

=over

=item module has a version

Tests to insure that all modules checked have a VERSION defined, Can replace
L<Test::HasVersion>

=item module has a valid version

Tests to insure that all versions are valid, according to the rules of
L<version> method C<is_lax>. To quote:

I<The lax criteria corresponds to what is currently allowed by the version
parser. All of the following formats are acceptable for dotted-decimal formats
strings:>

  v1.2
  1.2345.6
  v1.23_4
  1.2345
  1.2345_01

I<If you want to limit yourself to a much more narrow definition of what a
version string constitutes, is_strict() is limited to version strings like
the following list:>

  v1.234.5
  2.3456

you can cause your tests to fail if not strict by setting L<is_strict|/is_strict> to
C<1>

=back

=head1 FUNCTIONS

=head2 version_ok

  version_ok( $filename, [ $name ] );

Test a single C<.pm> file by passing a path to the function. Checks if the
module has a version, and that it is valid with C<is_lax>.

=head2 version_all_ok

  version_all_ok( [ $directory, [ $name ]] );

Test all modules in a directory with C<version_ok>. By default it will check
C<blib> or C<lib> if you haven't passed it a directory.

=head1 CONFIGURATION AND ENVIRONMENT

=head2 has_version

  use Test::Version qw( version_all_ok ), { has_version => 0 };

Allows disabling whether a module has to have a version. If set to 0
version tests will be skipped in any module where no version is found.

really doesn't make sense to use with just L<version_ok|/version_ok>

=head2 is_strict

  use Test::Version { is_strict => 1 };

this allows enabling of L<version>s C<is_strict> checks to ensure that your
version is strict.

=head2 consistent

  use Test::Version { consistent => 1 };

Check if every module has the same version number.

=head2 ignore_unindexable

  use Test::Version { ignore_unindexable => 0};

if you have at least L<Module::Metadata> vC<1.000020> Test::Version will by
default skip any files not considered L<is_indexable|Module::Metadata/is_indexable>

=head2 filename_match

  use Test::Version 2.0 { filename_match => [qr{Foo/Bar.pm$}] };

Only test files that match the given pattern.  Pattern may be a list of
strings, regular expressions or code references.  The filename will match
if it matches one or more patterns.

=over 4

=item string

The file matches if it matches the pattern string exactly.

=item regular expression

The file matches if it matches the regular expression.

=item code reference

The file matches if the code reference returns a true value.  The filename
is passed in as the only argument to the code reference.

=back

=head2 multiple

  use Test::Version 2.02 { multiple => 1 };

Test each version for each package if multiple packages are found in a file.

=head1 SEE ALSO

The goal is to have the functionality of all of these.

=over

=item L<Test::HasVersion>

=item L<Test::ConsistentVersion>

=item L<Test::GreaterVersion>

=back

If you are using L<Dist::Zilla> there is a plugin

=over

=item L<Dist::Zilla::Plugin::Test::Version>

=back

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/plicease/test-version/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 CONTRIBUTORS

=for stopwords Dave Rolsky Gabor Szabo Karen Etheridge Michael G. Schwern Mike Doherty particle

=over 4

=item *

Dave Rolsky <autarch@urth.org>

=item *

Gabor Szabo <gabor@szabgab.com>

=item *

Karen Etheridge <ether@cpan.org>

=item *

Michael G. Schwern <schwern@pobox.com>

=item *

Mike Doherty <doherty@cs.dal.ca>

=item *

particle <particle@cpan.org>

=back

=head1 AUTHORS

=over 4

=item *

Graham Ollis <plicease@cpan.org>

=item *

Caleb Cushing <xenoterracide@gmail.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2015 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
