package Net::DNS::SEC::ECCGOST;

#
# $Id: ECCGOST.pm 1376 2015-07-12 19:16:04Z willem $
#
use vars qw($VERSION);
$VERSION = (qw$LastChangedRevision: 1376 $)[1];


=head1 NAME

Net::DNS::SEC::ECCGOST - DNSSEC ECC-GOST digital signature algorithm


=head1 SYNOPSIS

    require Net::DNS::SEC::ECCGOST;

    $signature = Net::DNS::SEC::ECCGOST->sign( $sigdata, $private );

    $validated = Net::DNS::SEC::ECCGOST->verify( $sigdata, $keyrr, $sigbin );


=head1 DESCRIPTION

Implementation of GOST R 34.10-2001 elliptic curve digital signature
generation and verification procedures.

=head2 sign

    $signature = Net::DNS::SEC::ECCGOST->sign( $sigdata, $private );

Generates the wire-format binary signature from the binary sigdata
and the appropriate private key object.

=head2 verify

    $validated = Net::DNS::SEC::ECCGOST->verify( $sigdata, $keyrr, $sigbin );

Verifies the signature over the binary sigdata using the specified
public key resource record.

=cut


use strict;
use integer;
use warnings;
use Carp;
use MIME::Base64;

use Crypt::OpenSSL::Bignum;
use Crypt::OpenSSL::EC 1.01;
use Crypt::OpenSSL::ECDSA 0.06;
use Digest::GOST 0.06;
use Digest::GOST::CryptoPro;


my %ECcurve;
my %GOST = ( 12 => ['Digest::GOST::CryptoPro'] );


sub sign {
	my ( $class, $sigdata, $private ) = @_;

	my $ctx = Crypt::OpenSSL::Bignum::CTX->new();
	my $key = decode_base64( $private->PrivateKey );
	my $d	= Crypt::OpenSSL::Bignum->new_from_bin($key);

	my $algorithm = $private->algorithm;			# step 1  (nomenclature per RFC5832)
	my ( $object, @param ) = @{$GOST{$algorithm} || []};
	croak 'private key not GOST' unless $object;
	my $hash = $object->new(@param);
	$hash->add($sigdata);
	my $H = reverse $hash->digest;

	my $alpha = Crypt::OpenSSL::Bignum->new_from_bin($H);	# step 2
	my $group = $ECcurve{$algorithm}->dup();		# precalculated curve
	my $q	  = Crypt::OpenSSL::Bignum->zero;
	$group->get_order( $q, $ctx );
	my $e = $alpha->mod( $q, $ctx );	# Note: alpha can exceed but is never longer than q
	$e = Crypt::OpenSSL::Bignum->one if $e->is_zero;

	my $zeta;
	my $P = $group->get0_generator();
	{							# step 3
		$hash->add($key);
		$hash->add( time() ^ ( $$ + ( $$ << 15 ) ) );
		$hash->add( $hash->digest );
		my $m = Crypt::OpenSSL::Bignum->new_from_bin( $hash->digest );
		my $k = $m->mod( $q, $ctx );
		redo if $k->is_zero;

		my $x = Crypt::OpenSSL::Bignum->zero;		# step 4
		my $y = Crypt::OpenSSL::Bignum->zero;
		my $C = Crypt::OpenSSL::EC::EC_POINT::new($group);
		Crypt::OpenSSL::EC::EC_POINT::mul( $group, $C, $q, $P, $k, $ctx );
		Crypt::OpenSSL::EC::EC_POINT::get_affine_coordinates_GFp( $group, $C, $x, $y, $ctx );
		my $r = $x->mod( $q, $ctx );
		redo if $r->is_zero;

		my $v = $r->mul( $d, $ctx );			# step 5
		my $w = $k->mul( $e, $ctx );
		my $s = $v->add($w)->mod( $q, $ctx );
		redo if $s->is_zero;

		my $size = length $H;				# step 6
		$zeta = pack "a$size a$size", reverse( $s->to_bin ), reverse( $r->to_bin );
	}

	return $zeta;
}


sub verify {
	my ( $class, $sigdata, $keyrr, $sigbin ) = @_;

	# Implementation (ab)using Crypt::OpenSSL::ECDSA

	my $zeta = $sigbin;					# step 1  (nomenclature per RFC5832)
	my $size = length($zeta) >> 1;
	my ( $s, $r ) = unpack( "a$size a*", $zeta );

	my $algorithm = $keyrr->algorithm;			# step 2
	my ( $object, @param ) = @{$GOST{$algorithm} || []};
	croak 'public key not GOST' unless $object;
	my $hash = $object->new(@param);
	$hash->add($sigdata);
	my $H = reverse $hash->digest;

	my $alpha = Crypt::OpenSSL::Bignum->new_from_bin($H);	# step 3
	my $group = $ECcurve{$algorithm}->dup();		# precalculated curve
	my $ctx	  = Crypt::OpenSSL::Bignum::CTX->new();
	my $q	  = Crypt::OpenSSL::Bignum->zero;
	$group->get_order( $q, $ctx );
	my $e = $alpha->mod( $q, $ctx );	# Note: alpha can exceed but is never longer than q
	$e = Crypt::OpenSSL::Bignum->one if $e->is_zero;

	my $keybin = reverse $keyrr->keybin;			# public key
	my $keylen = length($keybin) >> 1;
	my ( $y, $x ) = map Crypt::OpenSSL::Bignum->new_from_bin($_), unpack "a$keylen a*", $keybin;
	my $Q = Crypt::OpenSSL::EC::EC_POINT::new($group);
	Crypt::OpenSSL::EC::EC_POINT::set_affine_coordinates_GFp( $group, $Q, $x, $y, $ctx );

	my $eckey = Crypt::OpenSSL::EC::EC_KEY::new();
	$eckey->set_group($group);
	$eckey->set_public_key($Q);

	# algebraic transformation of ECC-GOST into equivalent ECDSA problem
	my $dsasig = Crypt::OpenSSL::ECDSA::ECDSA_SIG->new();
	$dsasig->set_r($r);
	$dsasig->set_s( $q->sub($e)->to_bin );

	my $m = $q->sub( Crypt::OpenSSL::Bignum->new_from_bin($s) )->mod( $q, $ctx );
	Crypt::OpenSSL::ECDSA::ECDSA_do_verify( $m->to_bin, $dsasig, $eckey );
}


########################################

BEGIN {
	my %GOST_R_34_10_2001_CryptoPro_A = (			# RFC4357
		a => 'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD94',    # -3 mod p
		b => '00A6',					# 166
		p => 'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD97',
		q => 'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6C611070995AD10045841B09B761B893',
		x => '01',
		y => '8D91E471E0989CDA27DF505A453F2B7635294F2DDF23E3B122ACC99C9E9F1E14'
		);


	my $_curve = sub {
		my %param = @_;

		my $p = Crypt::OpenSSL::Bignum->new_from_hex( $param{p} );
		my $a = Crypt::OpenSSL::Bignum->new_from_hex( $param{a} );
		my $b = Crypt::OpenSSL::Bignum->new_from_hex( $param{b} );
		my $x = Crypt::OpenSSL::Bignum->new_from_hex( $param{x} );
		my $y = Crypt::OpenSSL::Bignum->new_from_hex( $param{y} );
		my $n = Crypt::OpenSSL::Bignum->new_from_hex( $param{q} );
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

	$ECcurve{12} = &$_curve(%GOST_R_34_10_2001_CryptoPro_A);
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
L<Digest::GOST>,
RFC4357, RFC5832, RFC5933

=cut

