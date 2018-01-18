package Crypt::OpenSSL::RSA;

use strict;
use Carp;

use vars qw ($VERSION @ISA @EXPORT @EXPORT_OK $AUTOLOAD);

require DynaLoader;
use AutoLoader 'AUTOLOAD';

@ISA = qw(DynaLoader);

$VERSION = '0.28';

bootstrap Crypt::OpenSSL::RSA $VERSION;

BEGIN { eval { require Crypt::OpenSSL::Bignum; }; }

1;

__END__

=head1 NAME

Crypt::OpenSSL::RSA - RSA encoding and decoding, using the openSSL libraries

=head1 SYNOPSIS

  use Crypt::OpenSSL::Random;
  use Crypt::OpenSSL::RSA;

  # not necessary if we have /dev/random:
  Crypt::OpenSSL::Random::random_seed($good_entropy);
  Crypt::OpenSSL::RSA->import_random_seed();
  $rsa_pub = Crypt::OpenSSL::RSA->new_public_key($key_string);
  $rsa_pub->use_sslv23_padding(); # use_pkcs1_oaep_padding is the default
  $ciphertext = $rsa->encrypt($plaintext);

  $rsa_priv = Crypt::OpenSSL::RSA->new_private_key($key_string);
  $plaintext = $rsa->encrypt($ciphertext);

  $rsa = Crypt::OpenSSL::RSA->generate_key(1024); # or
  $rsa = Crypt::OpenSSL::RSA->generate_key(1024, $prime);

  print "private key is:\n", $rsa->get_private_key_string();
  print "public key (in PKCS1 format) is:\n",
        $rsa->get_public_key_string();
  print "public key (in X509 format) is:\n",
        $rsa->get_public_key_x509_string();

  $rsa_priv->use_md5_hash(); # use_sha1_hash is the default
  $signature = $rsa_priv->sign($plaintext);
  print "Signed correctly\n" if ($rsa->verify($plaintext, $signature));

=head1 DESCRIPTION

Crypt::OpenSSL::RSA provides the ability to RSA encrypt strings which are
somewhat shorter than the block size of a key.  It also allows for decryption,
signatures and signature verification.

I<NOTE>: Many of the methods in this package can croak, so use eval, or
Error.pm's try/catch mechanism to capture errors.  Also, while some
methods from earlier versions of this package return true on success,
this (never documented) behavior is no longer the case.

=head1 Class Methods

=over

=item new_public_key

Create a new Crypt::OpenSSL::RSA object by loading a public key in
from a string containing Base64/DER-encoding of either the PKCS1 or
X.509 representation of the key.  The string should include the
-----BEGIN...----- and -----END...----- lines.

The padding is set to PKCS1_OAEP, but can be changed with the
use_xxx_padding methods

=cut

sub new_public_key
{
    my ($proto, $p_key_string) = @_;
    if ($p_key_string =~ /^-----BEGIN RSA PUBLIC KEY-----/)
    {
        return $proto->_new_public_key_pkcs1($p_key_string);
    }
    elsif ($p_key_string =~ /^-----BEGIN PUBLIC KEY-----/)
    {
        return $proto->_new_public_key_x509($p_key_string);
    }
    else
    {
        croak "unrecognized key format";
    }
}

=item new_private_key

Create a new Crypt::OpenSSL::RSA object by loading a private key in
from an string containing the Base64/DER encoding of the PKCS1
representation of the key.  The string should include the
-----BEGIN...----- and -----END...----- lines.  The padding is set to
PKCS1_OAEP, but can be changed with use_xxx_padding.

=item generate_key

Create a new Crypt::OpenSSL::RSA object by constructing a
private/public key pair.  The first (mandetory) argument is the key
size, while the second optional argument specifies the public exponent
(the default public exponent is 65537).  The padding is set to
PKCS1_OAEP, but can be changed with use_xxx_padding methods.

=item new_key_from_parameters

Given Crypt::OpenSSL::Bignum objects for n, e, and optionally d, p,
and q, where p and q are the prime factors of n, e is the public
exponent and d is the private exponent, create a new
Crypt::OpenSSL::RSA object using these values.  If p and q are
provided and d is undef, d is computed.  Note that while p and q are
not necessary for a private key, their presence will speed up
computation.

=cut

sub new_key_from_parameters
{
    my($proto, $n, $e, $d, $p, $q) = @_;
    return $proto->_new_key_from_parameters
        (map { $_ ? $_->pointer_copy() : 0 } $n, $e, $d, $p, $q);
}

=item import_random_seed

Import a random seed from Crypt::OpenSSL::Random, since the OpenSSL
libraries won't allow sharing of random structures across perl XS
modules.

=cut

sub import_random_seed
{
    until (_random_status())
    {
        _random_seed(Crypt::OpenSSL::Random::random_bytes(20));
    }
}

=back

=head1 Instance Methods

=over

=item DESTROY

Clean up after ourselves.  In particular, erase and free the memory
occupied by the RSA key structure.

=item get_public_key_string

Return the Base64/DER-encoded PKCS1 representation of the public
key.  This string has
header and footer lines:

  -----BEGIN RSA PUBLIC KEY------
  -----END RSA PUBLIC KEY------

=item get_public_key_x509_string

Return the Base64/DER-encoded representation of the "subject
public key", suitable for use in X509 certificates.  This string has
header and footer lines:

  -----BEGIN PUBLIC KEY------
  -----END PUBLIC KEY------

and is the format that is produced by running C<openssl rsa -pubout>.

=item get_private_key_string

Return the DER-encoded PKCS1 representation of the private key.

=item encrypt

Encrypt a binary "string" using the public (portion of the) key.

=item decrypt

Decrypt a binary "string".  Croaks if the key is public only.

=item private_encrypt

Encrypt a binary "string" using the private key.  Croaks if the key is
public only.

=item public_decrypt

Decrypt a binary "string" using the public (portion of the) key.

=item sign

Sign a string using the secret (portion of the) key.

=item verify

Check the signature on a text.

=item use_no_padding

Use raw RSA encryption. This mode should only be used to implement
cryptographically sound padding modes in the application code.
Encrypting user data directly with RSA is insecure.

=item use_pkcs1_padding

Use PKCS #1 v1.5 padding. This currently is the most widely used mode
of padding.

=item use_pkcs1_oaep_padding

Use EME-OAEP padding as defined in PKCS #1 v2.0 with SHA-1, MGF1 and
an empty encoding parameter. This mode of padding is recommended for
all new applications.  It is the default mode used by
Crypt::OpenSSL::RSA.

=item use_sslv23_padding

Use PKCS #1 v1.5 padding with an SSL-specific modification that
denotes that the server is SSL3 capable.

=item use_md5_hash

Use the RFC 1321 MD5 hashing algorithm by Ron Rivest when signing and
verifying messages.

=item use_sha1_hash

Use the RFC 3174 Secure Hashing Algorithm (FIPS 180-1) when signing
and verifying messages. This is the default.

=item use_sha224_hash, use_sha256_hash, use_sha384_hash, use_sha512_hash

These FIPS 180-2 hash algorithms, for use when signing and verifying
messages, are only available with newer openssl versions (>= 0.9.8).

=item use_ripemd160_hash

Dobbertin, Bosselaers and Preneel's RIPEMD hashing algorithm when
signing and verifying messages.

=item size

Returns the size, in bytes, of the key.  All encrypted text will be of
this size, and depending on the padding mode used, the length of
the text to be encrypted should be:

=over

=item pkcs1_oaep_padding

at most 42 bytes less than this size.

=item pkcs1_padding or sslv23_padding

at most 11 bytes less than this size.

=item no_padding

exactly this size.

=back

=item check_key

This function validates the RSA key, returning a true value if the key
is valid, and a false value otherwise.  Croaks if the key is public only.

=item get_key_parameters

Return Crypt::OpenSSL::Bignum objects representing the values of n, e,
d, p, q, d mod (p-1), d mod (q-1), and 1/q mod p, where p and q are
the prime factors of n, e is the public exponent and d is the private
exponent.  Some of these values may return as undef; only n and e will
be defined for a public key.  The Crypt::OpenSSL::Bignum module must
be installed for this to work.

=item is_private

Return true if this is a private key, and false if it is private only.

=cut

sub get_key_parameters
{
    return map { $_ ? Crypt::OpenSSL::Bignum->bless_pointer($_) : undef }
        shift->_get_key_parameters();
}

=back

=head1 BUGS

There is a small memory leak when generating new keys of more than 512 bits.

=head1 AUTHOR

Ian Robertson, iroberts@cpan.org.  For support, please email
perl-openssl-users@lists.sourceforge.net.

=head1 SEE ALSO

L<perl(1)>, L<Crypt::OpenSSL::Random(3)>, L<Crypt::OpenSSL::Bignum(3)>,
L<rsa(3)>, L<RSA_new(3)>, L<RSA_public_encrypt(3)>, L<RSA_size(3)>,
L<RSA_generate_key(3)>, L<RSA_check_key(3)>

=cut
