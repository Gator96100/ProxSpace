package Net::DNS::SEC::RSA;

#
# $Id: RSA.pm 1376 2015-07-12 19:16:04Z willem $
#
use vars qw($VERSION);
$VERSION = (qw$LastChangedRevision: 1376 $)[1];


=head1 NAME

Net::DNS::SEC::RSA - DNSSEC RSA digital signature algorithm


=head1 SYNOPSIS

    require Net::DNS::SEC::RSA;

    $signature = Net::DNS::SEC::RSA->sign( $sigdata, $private );

    $validated = Net::DNS::SEC::RSA->verify( $sigdata, $keyrr, $sigbin );


=head1 DESCRIPTION

Implementation of RSA digital signature
generation and verification procedures.

=head2 sign

    $signature = Net::DNS::SEC::RSA->sign( $sigdata, $private );

Generates the wire-format binary signature from the binary sigdata
and the appropriate private key object.

=head2 verify

    $validated = Net::DNS::SEC::RSA->verify( $sigdata, $keyrr, $sigbin );

Verifies the signature over the binary sigdata using the specified
public key resource record.

=cut

use strict;
use integer;
use warnings;
use Carp;
use MIME::Base64;

use Crypt::OpenSSL::Bignum;
use Crypt::OpenSSL::RSA 0.27;


my %RSA = (
	1  => 'use_md5_hash',
	5  => 'use_sha1_hash',
	7  => 'use_sha1_hash',
	8  => 'use_sha256_hash',
	10 => 'use_sha512_hash',
	);


sub sign {
	my ( $class, $sigdata, $private ) = @_;

	my $hash = $RSA{$private->algorithm} || die 'private key not RSA';

	my @param = map Crypt::OpenSSL::Bignum->new_from_bin( decode_base64( $private->$_ ) ),
			qw(Modulus PublicExponent PrivateExponent
			Prime1 Prime2 Exponent1 Exponent2 Coefficient);
	my $rsa = Crypt::OpenSSL::RSA->new_key_from_parameters(@param);

	$rsa->use_pkcs1_oaep_padding;
	$rsa->$hash;
	$rsa->sign($sigdata);
}


sub verify {
	my ( $class, $sigdata, $keyrr, $sigbin ) = @_;

	my $hash = $RSA{$keyrr->algorithm} || die 'public key not RSA';

	my $keybin = $keyrr->keybin;				# public key
	my ( $short, $long ) = unpack( 'Cn', $keybin );		# RFC3110, section 2
	my $keyfmt = $short ? "x a$short a*" : "x3 a$long a*";
	my ( $exponent, $modulus ) = unpack( $keyfmt, $keybin );

	my $bn_modulus	= Crypt::OpenSSL::Bignum->new_from_bin($modulus);
	my $bn_exponent = Crypt::OpenSSL::Bignum->new_from_bin($exponent);

	my $rsa = Crypt::OpenSSL::RSA->new_key_from_parameters( $bn_modulus, $bn_exponent );
	$rsa->use_pkcs1_oaep_padding;
	$rsa->$hash;

	$rsa->verify( $sigdata, $sigbin );
}


1;

__END__

########################################

=head1 ACKNOWLEDGMENT

Andy Vaskys (Network Associates Laboratories) supplied the code for
handling RSA with SHA1 (Algorithm 5).

The Crypt::OpenSSL::RSA package was created by Ian Robertson.


=head1 COPYRIGHT

Copyright (c)2014 Dick Franks.

All rights reserved.


=head1 LICENSE

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted, provided
that the above copyright notice appear in all copies and that both that
copyright notice and this permission notice appear in supporting
documentation, and that the name of the author not be used in advertising
or publicity pertaining to distribution of the software without specific
prior written permission.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.


=head1 SEE ALSO

L<Net::DNS>, L<Net::DNS::SEC>,
L<Crypt::OpenSSL::RSA>,
RFC2437, RFC3110

=cut

