package Math::UInt64;

use strict;
use warnings;

use Math::Int64;

sub import { goto &Math::Int64::import }

1;

# ABSTRACT: Manipulate 64 bit unsigned integers from Perl

__END__

=encoding UTF-8

=head1 NAME

Math::UInt64 - Manipulate 64 bit unsigned integers from Perl

=head1 DESCRIPTION

Math::UInt64 is just an alias for Math::Int64, the only reason it
exists as an independent package is to allow L<Storable> to load it on
demand.

=head1 SEE ALSO

L<Math::Int64>.

=cut
