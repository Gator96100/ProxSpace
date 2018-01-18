package Net::DNS::SEC::DSA;

#
# $Id: DSA.pm 1376 2015-07-12 19:16:04Z willem $
#
use vars qw($VERSION);
$VERSION = (qw$LastChangedRevision: 1376 $)[1];


=head1 NAME

Net::DNS::SEC::DSA - DNSSEC DSA digital signature algorithm


=head1 SYNOPSIS

    require Net::DNS::SEC::DSA;

    $signature = Net::DNS::SEC::DSA->sign( $sigdata, $private );

    $validated = Net::DNS::SEC::DSA->verify( $sigdata, $keyrr, $sigbin );


=head1 DESCRIPTION

Implementation of DSA digital signature
generation and verification procedures.

=head2 sign

    $signature = Net::DNS::SEC::DSA->sign( $sigdata, $private );

Generates the wire-format binary signature from the binary sigdata
and the appropriate private key object.

=head2 verify

    $validated = Net::DNS::SEC::DSA->verify( $sigdata, $keyrr, $sigbin );

Verifies the signature over the binary sigdata using the specified
public key resource record.

=cut

use strict;
use integer;
use warnings;
use Carp;
use Digest::SHA;
use MIME::Base64;

use Crypt::OpenSSL::DSA 0.14;


my %DSA = (
	3 => ['Digest::SHA'],
	6 => ['Digest::SHA'],
	);


sub sign {
	my ( $class, $sigdata, $private ) = @_;

	my $algorithm = $private->algorithm;			# digest sigdata
	my ( $object, @param ) = @{$DSA{$algorithm} || []};
	die 'private key not DSA' unless $object;
	my $hash = $object->new(@param);
	$hash->add($sigdata);

	my $dsa = Crypt::OpenSSL::DSA->new();			# private key

	$dsa->set_p( decode_base64 $private->prime );
	$dsa->set_q( decode_base64 $private->subprime );
	$dsa->set_g( decode_base64 $private->base );
	$dsa->set_priv_key( decode_base64 $private->private_value );

	my $dsasig = $dsa->do_sign( $hash->digest );
	my $T	   = ( length( $dsa->get_g ) - 64 ) / 8;
	my $R	   = $dsasig->get_r;
	my $S	   = $dsasig->get_s;

	# both the R and S parameters need to be 20 octets:
	my $Rpad = 20 - length($R);
	my $Spad = 20 - length($S);
	pack "C x$Rpad a* x$Spad a*", $T, $R, $S;		# RFC2536, section 3
}


sub verify {
	my ( $class, $sigdata, $keyrr, $sigbin ) = @_;

	my $algorithm = $keyrr->algorithm;			# digest sigdata
	my ( $object, @param ) = @{$DSA{$algorithm} || []};
	die 'public key not DSA' unless $object;
	my $hash = $object->new(@param);
	$hash->add($sigdata);

	my $keybin = $keyrr->keybin;				# public key
	my $numlen = 64 + 8 * unpack( 'C', $keybin );		# RFC2536, section 2
	my ( $Q, $P, $G, $Y ) = unpack "x a20 a$numlen a$numlen a$numlen", $keybin;

	my $dsa = Crypt::OpenSSL::DSA->new();
	$dsa->set_q($Q);
	$dsa->set_g($G);
	$dsa->set_p($P);
	$dsa->set_pub_key($Y);

	my $dsasig = Crypt::OpenSSL::DSA::Signature->new();
	my ( $R, $S ) = unpack 'x a20 a20', $sigbin;		# RFC2536, section 3
	$dsasig->set_r($R);
	$dsasig->set_s($S);

	$dsa->do_verify( $hash->digest, $dsasig );
}


1;

__END__

########################################

=head1 ACKNOWLEDGMENT

The Crypt::OpenSSL::DSA package was created by T.J. Mather.


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
L<Crypt::OpenSSL::DSA>,
L<Digest::SHA>,
RFC2536

=cut

