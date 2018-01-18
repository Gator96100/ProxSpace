package File::Find::Rule::Perl;

=pod

=head1 NAME

File::Find::Rule::Perl - Common rules for searching for Perl things

=head1 SYNOPSIS

  use File::Find::Rule       ();
  use File::Find::Rule::Perl ();
  
  # Find all Perl files smaller than 10k
  my @files = File::Find::Rule->perl_file
                              ->size('<10Ki')
                              ->in('dir');
  
  # Locate all the modules that PAUSE will index
  my @mod = File::Find::Rule->no_index
                            ->perl_module
                            ->in('My-Distribution');

=head1 DESCRIPTION

I write a lot of things that muck with Perl files. And it always annoyed
me that finding "perl files" requires a moderately complex
L<File::Find::Rule> pattern.

B<File::Find::Rule::Perl> provides methods for finding various
types Perl-related files, or replicating search queries run on a
distribution in various parts of the CPAN ecosystem.

=head1 METHODS

=cut

use 5.006;
use strict;
use warnings;
use Carp;
use File::Spec        0.82 ();
use File::Spec::Unix       ();
use File::Find::Rule  0.20 ();
use Params::Util      0.38 ();
use Parse::CPAN::Meta 1.38 ();

our $VERSION = '1.15';
use base 'File::Find::Rule';
our @EXPORT  = @File::Find::Rule::EXPORT;

use constant FFR => 'File::Find::Rule';





#####################################################################
# File::Find::Rule Method Addition

=pod

=head2 perl_module

The C<perl_module> rule locates perl modules. That is, files that
are named C<*.pm>.

This rule is equivalent to C<-E<gt>>file-E<gt>name( '*.pm' )> and is
included primarily for completeness.

=cut

sub File::Find::Rule::perl_module {
	my $find = $_[0]->_force_object;
	return $find->name('*.pm')->file;
}

=pod

=head2 perl_test

The C<perl_test> rule locates perl test scripts. That is, files that
are named C<*.t>.

This rule is equivalent to C<-E<gt>>file-E<gt>name( '*.t' )> and is
included primarily for completeness.

=cut

sub File::Find::Rule::perl_test {
	my $find = $_[0]->_force_object;
	return $find->name('*.t')->file;
}

=pod

=head2 perl_installer

The C<perl_installer> rule locates perl distribution installers. That is,
it locates C<Makefile.PL> and C<Build.PL> files.

=cut

sub File::Find::Rule::perl_installer {
	my $self = shift()->_force_object;
	return $self->file->name( 'Makefile.PL', 'Build.PL' );
}

=pod

=head2 perl_script

The C<perl_script> rule locates perl scripts.

This is any file that ends in F<.pl>, or any files without extensions
that have a perl "hash-bang" line.

=cut

sub File::Find::Rule::perl_script {
	my $self = shift()->_force_object;
	$self->or(
		FFR->name( '*.pl' )->file,
		FFR->name( qr/^[^.]+$/ )->file
		   ->exec( \&File::Find::Rule::Perl::_shebang ),
	);
}

sub File::Find::Rule::Perl::_shebang {
	local *SEARCHFILE;
	open SEARCHFILE, $_ or return !1;
	my $first_line = <SEARCHFILE>;
	close SEARCHFILE;
	return !1 unless defined $first_line;
	return $first_line =~ /^#!.*\bperl\b/;
}

=pod

=head2 perl_file

The C<perl_file> rule locates all files containing Perl code.

This includes all the files matching the above C<perl_module>,
C<perl_test>, C<perl_installer> and C<perl_script> rules.

=cut

sub File::Find::Rule::perl_file {
	my $self = shift()->_force_object;
	$self->or(
		FFR->name('*.pm', '*.t', '*.pl', 'Makefile.PL', 'Build.PL')->file,
		FFR->name( qr/^[^.]+$/ )->file
		   ->exec( \&File::Find::Rule::Perl::_shebang ),
	);
}

=pod

=head2 no_index

  # Provide the rules directly
  $rule->no_index(
      directory => [ 'inc', 't', 'examples' ],
      file      => [ 'Foo.pm', 'lib/Foo.pm' ],
  );
  
  # Provide a META.yml to use
  $rule->no_index( 'META.yml' );
  
  # Provide a dist root directory to look for a META.yml in
  $rule->no_index( 'My-Distribution' );
  
  # Automatically pick up a META.yml from the target directory
  $rule->no_index->in( 'My-Distribution' );

The C<no_index> method applies a set of rules as per the no_index section
in a C<META.yml> file.

=cut

# There's probably some bugs in this process somewhere,
sub File::Find::Rule::no_index {
	my $find  = shift()->_force_object;

	# Variables we'll need in the closure
	my $rule = undef;
	my $root = undef;

	# Handle the various param options
	if ( @_ == 0 ) {
		# No params means we auto-calculate
		$rule = undef;

	} elsif ( Params::Util::_HASHLIKE($_[0]) ) {
		$rule = _no_index($_[0]);

	} elsif ( defined Params::Util::_STRING($_[0]) ) {
		my $path = shift;
		if ( -d $path ) {
			# This is probably a dist directory
			my $meta = File::Spec->catfile($path, 'META.yml');
			$path = $meta if -f $meta;
		}
		if ( -f $path ) {
			# This is a META.yml file
			my $meta = Parse::CPAN::Meta::LoadFile($path);

			# Shortcut if there's nothing to do
			my $no_index = $meta->{no_index};
			if ( $no_index ) {
				$rule = _no_index($no_index);
			}
		}
	} else {
		Carp::croak("Invalid or unsupported parameter type");
	}

	# Generate the subroutine in advance
	my $function = sub {
		my $shortname = $_[0];
		my $fullname  = $_[2];

		# In the automated case the first time we are
		# called we are passed the META.yml-relative root.
		unless ( defined $root ) {
			if ( File::Spec->file_name_is_absolute($fullname) ) {
				$root = $fullname;
			} else {
				$root = File::Spec->rel2abs(
					File::Spec->curdir
				);
			}
		}
		unless ( defined $rule ) {
			$rule = '';
			my $meta = File::Spec->catfile( $root, 'META.yml' );
			if ( -f $meta ) {
				my $yaml = Parse::CPAN::Meta::LoadFile($meta);
				if ( $yaml and $yaml->{no_index} ) {
					$rule = _no_index( $yaml->{no_index} );
				}
			}
		}

		# Shortcut when there is no META.yml
		return 0 unless $rule;

		# Derive the META.yml-relative unix path
		my $absname = File::Spec->file_name_is_absolute($fullname)
			? $fullname
			: File::Spec->rel2abs($shortname);
		my $relpath = File::Spec->abs2rel($absname, $root);

		# Attempt to match a META.yml entry
		if ( ($rule->{directory}->{$relpath} or $rule->{directory}->{$absname} ) and -d $absname ) {
			return 1;
		}
		if ( ( $rule->{file}->{$relpath} or $rule->{file}->{$absname} ) and -f $absname ) {
			return 1;
		}
		return 0;
	};

	# Generate the rule
	return $find->or(
		FFR->exec( $function )->prune->discard,
		FFR->new,
	);
}

sub _no_index {
	my $param = shift;

	# Index the directory and file entries for faster access
	my %file = $param->{file} ? (
		map { $_ => 1 } @{$param->{file}}
	) : ();
	my %directory = $param->{directory} ? (
		map { $_ => 1 } @{$param->{directory}}
	) : ();

	return {
		file      => \%file,
		directory => \%directory,
	};
}

1;

=pod

=head1 SUPPORT

Bugs should always be submitted via the CPAN bug tracker

L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=File-Find-Rule-Perl>

For other issues, contact the maintainer

=head1 AUTHOR

Adam Kennedy E<lt>adamk@cpan.orgE<gt>

=head1 SEE ALSO

L<http://ali.as/>, L<File::Find::Rule>, L<File::Find::Rule::PPI>

=head1 COPYRIGHT

Copyright 2006 - 2012 Adam Kennedy.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
