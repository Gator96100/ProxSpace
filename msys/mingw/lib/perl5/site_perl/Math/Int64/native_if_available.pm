package Math::Int64::native_if_available;

use strict;
use warnings;

use Math::Int64 ();

sub import {
    if (Math::Int64::_backend() eq 'IV' and $] >= 5.008) {
        Math::Int64::_set_may_use_native(1);
        $^H{'Math::Int64::native_if_available'} = 1;
        goto &Math::Int64::_check_pragma_compatibility;
    }
}

sub unimport {
    undef $^H{'Math::Int64::native_if_available'};
}

1;

# ABSTRACT: Use the native Perl 64-bit integer implementation when available

__END__

=encoding UTF-8

=head1 NAME

Math::Int64::native_if_available - Use the native Perl 64-bit integer implementation when available

=head1 SYNOPSIS

  use Math::Int64 qw(uint64);
  use Math::Int64::native_if_available;

=head1 SEE ALSO

L<Math::Int64>.

=cut


