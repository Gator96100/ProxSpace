package Tie::Registry;

# Tie/Registry.pm -- Provides backward compatibility for Win32::TieRegistry
# that was called Tie::Registry prior to version 0.20.
# by Tye McQueen, tye@metronet.com, see http://www.metronet.com/~tye/.

use strict;
use Carp;

use vars qw( $VERSION @ISA );
BEGIN {
	require Win32::TieRegistry;
	$VERSION = '0.15';
	@ISA     = qw{Win32::TieRegistry};
}

sub import {
	my $pkg = shift;
	Win32::TieRegistry->import( ExportLevel => 1, SplitMultis => 0, @_ );
}

1;

__END__

=pod

=head1 NAME

Tie::Registry - Legacy interface to Win32::TieRegistry (DEPRECATED)

=head1 DESCRIPTION

This module provides backward compatibility for L<Win32::TieRegistry>
that was called Tie::Registry prior to version 0.20.

=head1 AUTHOR

Tye McQueen E<lt>tye@metronet.comE<gt>

=head1 COPYRIGHT

Copyright 1999 Tye McQueen.

=cut
