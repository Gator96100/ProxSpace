package Crypt::OpenSSL::Random;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

use XSLoader;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw( random_bytes random_pseudo_bytes random_seed
                 random_egd random_status );

$VERSION = '0.11';
XSLoader::load( __PACKAGE__, $VERSION );

1;
__END__

=head1 NAME

Crypt::OpenSSL::Random - OpenSSL/LibreSSL pseudo-random number generator access

=head1 SYNOPSIS

  use Crypt::OpenSSL::Random;

  Crypt::OpenSSL::Random::random_seed($good_random_data);
  Crypt::OpenSSL::Random::random_egd("/tmp/entropy");
  Crypt::OpenSSL::Random::random_status() or
    die "Unable to sufficiently seed the random number generator".

  my $ten_good_random_bytes = Crypt::OpenSSL::Random::random_bytes(10);
  my $ten_ok_random_bytes = Crypt::OpenSSL::Random::random_pseudo_bytes(10);

=head1 DESCRIPTION

C<Crypt::OpenSSL::Random> provides the ability to seed and query the
B<OpenSSL> and B<LibreSSL> library's pseudo-random number generators.

Note: On B<LibreSSL> C<random_egd()> is not defined.

=head2 EXPORT

None by default.

=head1 Static Methods

=over

=item random_bytes (IV num_bytes)

This function, returns a specified number of cryptographically strong
pseudo-random bytes from the PRNG.  If the PRNG has not been seeded
with enough randomness to ensure an unpredictable byte sequence, then
a false value is returned.

=item random_pseudo_bytes (IV num_bytes)

This function, is similar to c<random_bytes>, but the resulting
sequence of bytes are not necessarily unpredictable.  They can be used
for non-cryptographic purposes and for certain purposes in
cryptographic protocols, but usually not for key generation etc.

=item random_seed (PV random_bytes_string)

This function seeds the PRNG with a supplied string of bytes.  It
returns true if the PRNG has sufficient seeding.  Note: calling this
function with non-random bytes is of limited value at best!

=item random_egd (PV egd_string)

This function seeds the PRNG with data from the specified entropy
gathering daemon.  Returns the number of bytes read from the daemon on
success, or C<-1> if not enough bytes were read, or if the connection to
the daemon failed.

C<libressl> considers this function insecure, so with libressl this
function does not exist.

=item random_status ()

This function returns true if the PRNG has sufficient seeding.

=back

=head1 BUGS

Because of the internal workings of OpenSSL's random library, the
pseudo-random number generator (PRNG) accessed by
Crypt::OpenSSL::Random will be different than the one accessed by any
other perl module.  Hence, to use a module such as
Crypt::OpenSSL::Random, you will need to seed the PRNG used there from
one used here.  This class is still advantageous, however, as it
centralizes other methods, such as C<random_egd>, in one place.

=head1 AUTHOR

Ian Robertson, C<iroberts@cpan.com>

Now maintained by Reini Urban, C<rurban@cpan.org>

=head1 LICENSE

This module is available under the same licences as perl, the Artistic
license and the GPL.

=head1 SEE ALSO

perl(1), rand(3), RAND_add(3), RAND_egd(3), RAND_bytes(3).

=cut
