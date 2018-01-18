use strict;
use warnings;

package inc::latest;

# ABSTRACT: use modules bundled in inc/ if they are newer than installed ones

our $VERSION = '0.500';

package inc::latest;

use Carp;
use File::Basename ();
use File::Spec     ();
use File::Path     ();
use IO::File       ();
use File::Copy     ();

# track and return modules loaded by inc::latest
my @loaded_modules;
sub loaded_modules { @loaded_modules }

# must ultimately "goto" the import routine of the module to be loaded
# so that the calling package is correct when $mod->import() runs.
sub import {
    my ( $package, $mod, @args ) = @_;
    return unless ( defined $mod );

    my $private_path = 'inc/latest/private.pm';
    if ( -e $private_path ) {
        # user mode - delegate work to bundled private module
        require $private_path;
        splice( @_, 0, 1, 'inc::latest::private' );
        goto \&inc::latest::private::import;
    }

    # author mode - just record and load the modules
    push( @loaded_modules, $mod );
    require inc::latest::private;
    goto \&inc::latest::private::_load_module;
}

sub write {
    my $package = shift;
    my ( $where, @preload ) = @_;

    warn "should really be writing in inc/" unless $where =~ /inc$/;

    # write inc/latest.pm
    File::Path::mkpath($where);
    my $fh = IO::File->new( File::Spec->catfile( $where, 'latest.pm' ), "w" );
    print {$fh} "# This stub created by inc::latest $VERSION\n";
    print {$fh} <<'HERE';
package inc::latest;
use strict;
use vars '@ISA';
require inc::latest::private;
@ISA = qw/inc::latest::private/;
HERE
    if (@preload) {
        print {$fh} "\npackage inc::latest::preload;\n";
        for my $mod (@preload) {
            print {$fh} "inc::latest->import('$mod');\n";
        }
    }
    print {$fh} "\n1;\n";
    close $fh;

    # write inc/latest/private;
    require inc::latest::private;
    File::Path::mkpath( File::Spec->catdir( $where, 'latest' ) );
    my $from = $INC{'inc/latest/private.pm'};
    my $to = File::Spec->catfile( $where, 'latest', 'private.pm' );
    File::Copy::copy( $from, $to ) or die "Couldn't copy '$from' to '$to': $!";

    return 1;
}

sub bundle_module {
    my ( $package, $module, $where ) = @_;

    # create inc/inc_$foo
    ( my $dist = $module ) =~ s{::}{-}g;
    my $inc_lib = File::Spec->catdir( $where, "inc_$dist" );
    File::Path::mkpath $inc_lib;

    # get list of files to copy
    require ExtUtils::Installed;
    # workaround buggy EU::Installed check of @INC
    my $inst = ExtUtils::Installed->new( extra_libs => [@INC] );
    my $packlist = $inst->packlist($module) or die "Couldn't find packlist";
    my @files = grep { /\.pm$/ } keys %$packlist;

    # figure out prefix
    my $mod_path = quotemeta $package->_mod2path($module);
    my ($prefix) = grep { /$mod_path$/ } @files;
    $prefix =~ s{$mod_path$}{};

    # copy files
    for my $from (@files) {
        next unless $from =~ /\.pm$/;
        ( my $mod_path = $from ) =~ s{^\Q$prefix\E}{};
        my $to = File::Spec->catfile( $inc_lib, $mod_path );
        File::Path::mkpath( File::Basename::dirname($to) );
        File::Copy::copy( $from, $to ) or die "Couldn't copy '$from' to '$to': $!";
    }
    return 1;
}

# Translate a module name into a directory/file.pm to search for in @INC
sub _mod2path {
    my ( $self, $mod ) = @_;
    my @parts = split /::/, $mod;
    $parts[-1] .= '.pm';
    return $parts[0] if @parts == 1;
    return File::Spec->catfile(@parts);
}

1;


# vim: ts=4 sts=4 sw=4 tw=75 et:

__END__

=pod

=encoding UTF-8

=head1 NAME

inc::latest - use modules bundled in inc/ if they are newer than installed ones

=head1 VERSION

version 0.500

=head1 SYNOPSIS

  # in Makefile.PL or Build.PL
  use inc::latest 'Some::Configure::Prereq';

=head1 DESCRIPTION

B<WARNING -- THIS IS AN EXPERIMENTAL MODULE>.  It was originally bundled
(as an experiment) with L<Module::Build> and has been split out for more
general use.

The C<inc::latest> module helps bootstrap configure-time dependencies for
CPAN distributions.  These dependencies get bundled into the C<inc>
directory within a distribution and are used by F<Makefile.PL> or F<Build.PL>.

Arguments to C<inc::latest> are module names that are checked against both
the current C<@INC> array and against specially-named directories in
C<inc>.  If the bundled version is newer than the installed one (or the
module isn't installed, then, the bundled directory is added to the start
of C<@INC> and the module is loaded from there.

There are actually two variations of C<inc::latest> -- one for authors and
one for the C<inc> directory.  For distribution authors, the C<inc::latest>
installed in the system will record modules loaded via C<inc::latest> and
can be used to create the bundled files in C<inc>, including writing the
second variation as C<inc/latest.pm>.

This second C<inc::latest> is the one that is loaded in a distribution
being installed (e.g. from F<Makefile.PL> or F<Build.PL>).  This bundled
C<inc::latest> is the one that determines which module to load.

=head2 Special notes on bundling

The C<inc::latest> module creates bundled directories based on the packlist
file of an installed distribution.  Even though C<inc::latest> takes module
name arguments, it is better to think of it as bundling and making
available entire I<distributions>.  When a module is loaded through
C<inc::latest>, it looks in all bundled distributions in C<inc/> for a
newer module than can be found in the existing C<@INC> array.

Thus, the module-name provided should usually be the "top-level" module
name of a distribution, though this is not strictly required.
C<inc::latest> has a number of heuristics to discover module names,
allowing users to do things like this:

  use inc::latest 'Devel::AssertOS::Unix';

even though Devel::AssertOS::Unix is contained within the Devel-CheckOS
distribution.

At the current time, packlists are required.  Thus, bundling dual-core
modules may require a 'forced install' over versions in the latest version
of perl in order to create the necessary packlist for bundling.

=head2 Managing dependency chains

Before bundling a distribution you must ensure that all prerequisites are
also bundled and load in the correct order.

For example, if you need C<Wibble>, but C<Wibble> depends on C<Wobble>,
and you have bundled C<Module::Build>, your F<Build.PL> might look like this:

  use inc::latest 'Wobble';
  use inc::latest 'Wibble';
  use inc::latest 'Module::Build';

  Module::Build->new(
    module_name => 'Foo::Bar',
    license => 'perl',
  )->create_build_script;

Authors are strongly suggested to limit the bundling of additional
dependencies if at all possible and to carefully test their distribution
tarballs before uploading to CPAN.

=head1 USAGE

=head2 As bundled in inc/

Using L</Author-mode>, a special stub module will be created in your
distribute directory as F<inc/latest.pm>.  In your F<Makefile.PL> or
F<Build.PL>, you can then load C<inc::latest> to load bundled modules.

When calling C<use>, the bundled C<inc::latest> takes a single module name
and optional arguments to pass to that module's own import method.

  use inc::latest 'Foo::Bar' qw/foo bar baz/;

The implementation is private.  Only the C<import> method is public.

=head2 Author-mode

When you have L<inc::latest> installed from CPAN, then you are in author-mode
if any of the Author-mode methods are available.  For example:

  if ( inc::latest->can('write') ) {
    inc::latest->write('inc');
  }

Using author-mode, you can create the stub F<inc/latest.pm> and bundle
modules into F<inc>.

=over 4

=item loaded_modules()

  my @list = inc::latest->loaded_modules;

This takes no arguments and always returns a list of module names requested
for loading via "use inc::latest 'MODULE'", regardless of whether the load
was successful or not.

=item write()

  inc::latest->write( 'inc' );

This writes the bundled version of inc::latest to the directory name given
as an argument.  It almost all cases, it should be 'C<inc>'.

=item bundle_module()

  for my $mod ( inc::latest->loaded_modules ) {
    inc::latest->bundle_module($mod, $dir);
  }

If $mod corresponds to a packlist, then this function creates a
specially-named directory in $dir and copies all .pm files from the modlist
to the new directory (which almost always should just be 'inc').  For
example, if Foo::Bar is the name of the module, and $dir is 'inc', then the
directory would be 'inc/inc_Foo-Bar' and contain files like this:

  inc/inc_Foo-Bar/Foo/Bar.pm

Currently, $mod B<must> have a packlist.  If this is not the case (e.g. for
a dual-core module), then the bundling will fail.  You may be able to
create a packlist by forced installing the module on top of the version
that came with core Perl.

=back

=for :stopwords cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at L<https://github.com/dagolden/inc-latest/issues>.
You will be notified automatically of any progress on your issue.

=head2 Source Code

This is open source software.  The code repository is available for
public review and contribution under the terms of the license.

L<https://github.com/dagolden/inc-latest>

  git clone https://github.com/dagolden/inc-latest.git

=head1 AUTHORS

=over 4

=item *

David Golden <dagolden@cpan.org>

=item *

Eric Wilhelm <ewilhelm@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by David Golden.

This is free software, licensed under:

  The Apache License, Version 2.0, January 2004

=cut
