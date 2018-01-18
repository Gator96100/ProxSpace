package Net::DNS::SEC::ECDSA;

#
# $Id: ECDSA.pm 1376 2015-07-12 19:16:04Z willem $
#
use vars qw($VERSION);
$VERSION = (qw$LastChangedRevision: 1376 $)[1];


=head1 NAME

Net::DNS::SEC::ECDSA - DNSSEC ECDSA digital signature algorithm


=head1 SYNOPSIS

    require Net::DNS::SEC::ECDSA;

    $signature = Net::DNS::SEC::ECDSA->sign( $sigdata, $private );

    $validated = Net::DNS::SEC::ECDSA->verify( $sigdata, $keyrr, $sigbin );


=head1 DESCRIPTION

Implementation of ECDSA elliptic curve digital signature
generation and verification procedures.

=head2 sign

    $signature = Net::DNS::SEC::ECDSA->sign( $sigdata, $private );

Generates the wire-format binary signature from the binary sigdata
and the appropriate private key object.

=head2 verify

    $validated = Net::DNS::SEC::ECDSA->verify( $sigdata, $keyrr, $sigbin );

Verifies the signature over the binary sigdata using the specified
public key resource record.

=cut

use strict;
use integer;
use warnings;
use Carp;
use Digest::SHA;
use MIME::Base64;

use Crypt::OpenSSL::Bignum;
use Crypt::OpenSSL::EC 0.5;
use Crypt::OpenSSL::ECDSA 0.05;


my %ECcurve;
my %ECDSA = (
	13 => ['Digest::SHA', 256],
	14 => ['Digest::SHA', 384],
	);


sub sign {
	my ( $class, $sigdata, $private ) = @_;

	my $algorithm = $private->algorithm;			# digest sigdata
	my ( $object, @param ) = @{$ECDSA{$algorithm} || []};
	die 'private key not ECDSA' unless $object;
	my $hash = $object->new(@param);
	$hash->add($sigdata);
	my $digest = $hash->digest;

	my $keybin = decode_base64( $private->PrivateKey );
	my $bignum = Crypt::OpenSSL::Bignum->new_from_bin($keybin);

	my $group = $ECcurve{$algorithm}->dup();		# precalculated curve
	my $eckey = Crypt::OpenSSL::EC::EC_KEY::new();
	$eckey->set_group($group);
	$eckey->set_private_key($bignum);

	my $ecsig = Crypt::OpenSSL::ECDSA::ECDSA_do_sign( $digest, $eckey );
	my ( $R, $S ) = ( $ecsig->get_r, $ecsig->get_s );

	# both the R and S parameters need to be zero padded:
	my $size = length $digest;
	my $Rpad = $size - length $R;
	my $Spad = $size - length $S;
	pack "x$Rpad a* x$Spad a*", $R, $S;
}


sub verify {
	my ( $class, $sigdata, $keyrr, $sigbin ) = @_;

	my $algorithm = $keyrr->algorithm;			# digest sigdata
	my ( $object, @param ) = @{$ECDSA{$algorithm} || []};
	die 'public key not ECDSA' unless $object;
	my $hash = $object->new(@param);
	$hash->add($sigdata);
	my $digest = $hash->digest;

	my $keybin = $keyrr->keybin;				# public key
	my $keylen = length($keybin) >> 1;
	my ( $x, $y ) = map Crypt::OpenSSL::Bignum->new_from_bin($_), unpack "a$keylen a*", $keybin;
	my $group = $ECcurve{$algorithm}->dup();		# precalculated curve
	my $key	  = Crypt::OpenSSL::EC::EC_POINT::new($group);
	my $ctx	  = Crypt::OpenSSL::Bignum::CTX->new();
	Crypt::OpenSSL::EC::EC_POINT::set_affine_coordinates_GFp( $group, $key, $x, $y, $ctx );

	my $eckey = Crypt::OpenSSL::EC::EC_KEY::new();
	$eckey->set_group($group);
	$eckey->set_public_key($key);

	my $siglen = length($sigbin) >> 1;			# signature
	my ( $R, $S ) = unpack( "a$siglen a*", $sigbin );

	my $dsasig = Crypt::OpenSSL::ECDSA::ECDSA_SIG->new();
	$dsasig->set_r($R);
	$dsasig->set_s($S);

	Crypt::OpenSSL::ECDSA::ECDSA_do_verify( $digest, $dsasig, $eckey );
}


########################################

BEGIN {
	my %NIST_P256 = (		## FIPS 186-4, D.1.2.3
		p => 'ffffffff00000001000000000000000000000000ffffffffffffffffffffffff',
		a => 'ffffffff00000001000000000000000000000000fffffffffffffffffffffffc',    # -3 mod p
		b => '5ac635d8aa3a93e7b3ebbd55769886bc651d06b0cc53b0f63bce3c3e27d2604b',
		x => '6b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c296',
		y => '4fe342e2fe1a7f9b8ee7eb4a7c0f9e162bce33576b315ececbb6406837bf51f5',
		n => 'ffffffff00000000ffffffffffffffffbce6faada7179e84f3b9cac2fc632551',
		s => 'c49d360886e704936a6678e1139d26b7819f7e90',
		c => '7efba1662985be9403cb055c75d4f7e0ce8d84a9c5114abcaf3177680104fa0d'
		);


	my %NIST_P384 = (		## FIPS 186-4, D.1.2.4
		p => 'fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff',
		a => 'fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000fffffffc',
		b => 'b3312fa7e23ee7e4988e056be3f82d19181d9c6efe8141120314088f5013875ac656398d8a2ed19d2a85c8edd3ec2aef',
		x => 'aa87ca22be8b05378eb1c71ef320ad746e1d3b628ba79b9859f741e082542a385502f25dbf55296c3a545e3872760ab7',
		y => '3617de4a96262c6f5d9e98bf9292dc29f8f41dbd289a147ce9da3113b5f0b8c00a60b1ce1d7e819d7a431d7c90ea0e5f',
		n => 'ffffffffffffffffffffffffffffffffffffffffffffffffc7634d81f4372ddf581a0db248b0a77aecec196accc52973',
		s => 'a335926aa319a27a1d00896a6773a4827acdac73',
		c => '79d1e655f868f02fff48dcdee14151ddb80643c1406d0ca10dfe6fc52009540a495e8042ea5f744f6e184667cc722483'
		);


	my $_curve = sub {
		my %param = @_;

		my $p = Crypt::OpenSSL::Bignum->new_from_hex( $param{p} );
		my $a = Crypt::OpenSSL::Bignum->new_from_hex( $param{a} );
		my $b = Crypt::OpenSSL::Bignum->new_from_hex( $param{b} );
		my $x = Crypt::OpenSSL::Bignum->new_from_hex( $param{x} );
		my $y = Crypt::OpenSSL::Bignum->new_from_hex( $param{y} );
		my $n = Crypt::OpenSSL::Bignum->new_from_hex( $param{n} );
		my $h = Crypt::OpenSSL::Bignum->one;

		my $ctx	   = Crypt::OpenSSL::Bignum::CTX->new();
		my $method = Crypt::OpenSSL::EC::EC_GFp_mont_method();
		my $group  = Crypt::OpenSSL::EC::EC_GROUP::new($method);
		$group->set_curve_GFp( $p, $a, $b, $ctx );	# y^2 = x^3 + a*x + b  mod p

		my $G = Crypt::OpenSSL::EC::EC_POINT::new($group);
		Crypt::OpenSSL::EC::EC_POINT::set_affine_coordinates_GFp( $group, $G, $x, $y, $ctx );
		$group->set_generator( $G, $n, $h );
		die 'bad curve' unless Crypt::OpenSSL::EC::EC_GROUP::check( $group, $ctx );    # uncoverable branch
		return $group;
	};

	$ECcurve{13} = &$_curve(%NIST_P256);
	$ECcurve{14} = &$_curve(%NIST_P384);
}


1;

__END__

########################################

=head1 ACKNOWLEDGMENT

Mike McCauley created the Crypt::OpenSSL::ECDSA perl extension module
specifically for this development.


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
L<Crypt::OpenSSL::EC>, L<Crypt::OpenSSL::ECDSA>,
L<Digest::SHA>,
RFC6090, RFC6605

=cut

