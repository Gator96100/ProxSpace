package Net::DNS::SEC;

#
# $Id: SEC.pm 1401 2015-09-15 22:23:13Z willem $
#
use vars qw($VERSION $SVNVERSION);
$VERSION    = '1.02';
$SVNVERSION = (qw$LastChangedRevision: 1401 $)[1];


=head1 NAME

Net::DNS::SEC - DNSSEC extensions to Net::DNS

=head1 SYNOPSIS

    use Net::DNS::SEC;

=head1 DESCRIPTION

The Net::DNS::SEC suite provides additional packages required to support
DNSSEC as described in RFC4033, RFC4034, RFC4035 and subsequent related
documents.

Net::DNS::SEC is installed as an extension to an existing Net::DNS
installation.

The extended features are made available by substituting Net::DNS::SEC
for Net::DNS in the use declaration.

=cut


use strict;
use base qw(Exporter);

use Net::DNS 1.01 qw(:DEFAULT);

use vars qw(@EXPORT);
@EXPORT = ( @Net::DNS::EXPORT, qw(algorithm digtype key_difference) );


use integer;
use warnings;
use Carp;

use Net::DNS::RR::CDS;
use Net::DNS::RR::DLV;
use Net::DNS::RR::DS;
use Net::DNS::RR::RRSIG;
use Net::DNS::RR::SIG;


=head1 UTILITY FUNCTIONS

=head2 algorithm

    $mnemonic = algorithm( 5 );
    $numeric  = algorithm( 'RSA-SHA1' );
    print "algorithm mnemonic\t", $mnemonic, "\n";
    print "algorithm number:\t",  $numeric,  "\n";

algorithm() provides conversions between an algorithm code number and
the corresponding mnemonic.

=cut

sub algorithm { &Net::DNS::RR::DS::algorithm; }


=head2 digtype

    $mnemonic = digtype( 2 );
    $numeric  = digtype( 'SHA-256' );
    print "digest type mnemonic\t", $mnemonic, "\n";
    print "digest type number:\t",  $numeric,  "\n";

digtype() provides conversions between a digest type number and the
corresponding mnemonic.

=cut

sub digtype { &Net::DNS::RR::DS::digtype; }


=head2 key_difference

    @result = key_difference( \@a, \@b );

Fills @result with all keys in array @a that are not in array @b.

=cut

sub key_difference {
	my $a = shift;
	my $b = shift;
	my $r = shift || [];		## 0.17 interface

	eval {
		local $SIG{__DIE__};
		my ($x) = grep !$_->isa('Net::DNS::RR::DNSKEY'), @$a, @$b;
		die sprintf 'unexpected %s object in key list', ref($x) if $x;

		my %index = map { ( $_->privatekeyname => 1 ) } @$b;
		@$r = grep !$index{$_->privatekeyname}, @$a;
		1;
	} || do {
		croak($@) if wantarray;
	};

	return wantarray ? (@$r) : $@;
}


1;
__END__


=head1 COPYRIGHT

Copyright (c)2001-2005 RIPE NCC. Author Olaf M. Kolkman

Portions Copyright (c)2014-2015 Dick Franks

All Rights Reserved


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

L<perl>, L<Net::DNS>, RFC4033, RFC4034, RFC4035

=cut

