package Crypt::OpenSSL::Bignum::CTX;

use 5.005;
use strict;
use Carp;

use Crypt::OpenSSL::Bignum;
use vars qw( @ISA );

require DynaLoader;

@ISA = qw(DynaLoader);

bootstrap Crypt::OpenSSL::Bignum $Crypt::OpenSSL::Bignum::VERSION;

1;
__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

Crypt::OpenSSL::Bignum::CTX - Perl interface to the OpenSSL BN_CTX structure.

=head1 SYNOPSIS

  use Crypt::OpenSSL::Bignum::CTX;
  my $bn_ctx = Crypt::OpenSSL::Bignum::CTX->new();

=head1 DESCRIPTION

See the man page for Crypt::OpenSSL::Bignum.

=head1 AUTHOR

Ian Robertson, iroberts@cpan.org

=head1 SEE ALSO

L<perl>, L<Crypt::OpenSSL::Bignum>, L<BN_CTX_new(3ssl)>

=cut
