package Math::Int64::die_on_overflow;

use strict;
use warnings;

use Math::Int64 ();

sub import {
    require Math::Int64;
    Math::Int64::_set_may_die_on_overflow(1);
    $^H{'Math::Int64::die_on_overflow'} = 1;
    goto &Math::Int64::_check_pragma_compatibility;
}


sub unimport {
    undef $^H{'Math::Int64::die_on_overflow'}
}

1;

# ABSTRACT: catch overflows when using Math::Int64

__END__

=encoding UTF-8

=head1 NAME

Math::Int64::die_on_overflow - catch overflows when using Math::Int64

=head1 SYNOPSIS

  use Math::Int64 qw(uint64);
  use Math::Int64::die_on_overflow;

  my $number = uint64(2**32);
  say($number * $number); # overflow error!


=head1 SEE ALSO

L<Math::Int64>.

=cut
