package Net::DNS::RR::OPT;

#
# $Id: OPT.pm 1474 2016-04-12 13:21:25Z willem $
#
use vars qw($VERSION);
$VERSION = (qw$LastChangedRevision: 1474 $)[1];


use strict;
use base qw(Net::DNS::RR);

=head1 NAME

Net::DNS::RR::OPT - DNS OPT resource record

=cut


use integer;

use Carp;
use Net::DNS::Parameters;

use constant CLASS_TTL_RDLENGTH => length pack 'n N n', (0) x 3;

use constant OPT => typebyname qw(OPT);


sub _decode_rdata {			## decode rdata from wire-format octet string
	my $self = shift;
	my ( $data, $offset ) = @_;

	my $limit = $offset + $self->{rdlength};

	my $index = $offset - CLASS_TTL_RDLENGTH;		# OPT redefines class and TTL fields
	@{$self}{qw(size rcode version flags)} = unpack "\@$index n C2 n", $$data;
	@{$self}{rcode} = @{$self}{rcode} << 4;
	delete @{$self}{qw(class ttl)};

	while ( $offset <= $limit - 4 ) {
		my ( $code, $length ) = unpack "\@$offset nn", $$data;
		$offset += 4;
		$self->option( $code, substr $$data, $offset, $length );
		$offset += $length;
	}
}


sub _encode_rdata {			## encode rdata as wire-format octet string
	my $self = shift;

	my $rdata = '';
	foreach ( $self->options ) {
		my $value = $self->option($_);
		$rdata .= pack 'nna*', $_, length($value), $value;
	}
	return $rdata;
}


sub encode {				## overide RR method
	my $self = shift;

	my $data = $self->_encode_rdata;
	my $size = $self->size;
	my @xttl = ( $self->rcode >> 4, $self->version, $self->flags );
	pack 'C n n C2n n a*', 0, OPT, $size, @xttl, length($data), $data;
}


sub string {				## overide RR method
	my $self = shift;

	my $edns   = $self->version;
	my $flags  = sprintf '%04x', $self->flags;
	my $rcode  = $self->rcode;
	my $size   = $self->size;
	my @option = sort { $a <=> $b } $self->options;
	my @lines  = map sprintf( "%s\t%s", ednsoptionbyval($_), unpack 'H*', $self->option($_) ), @option;
	my @format = join "\n;;\t\t", @lines;

	$rcode = 0 if $rcode < 16;				# weird: 1 .. 15 not EDNS codes!!

	my $rc = exists( $self->{rdlength} ) && $rcode ? "$rcode + [4-bits]" : rcodebyval($rcode);

	$rc = 'BADVERS' if $rcode == 16;			# code 16 unambiguous here

	return <<"QQ";
;; EDNS version $edns
;;	flags:	$flags
;;	rcode:	$rc
;;	size:	$size
;;	option: @format
QQ
}


my ( $class, $ttl );

sub class {				## overide RR method
	carp qq[Usage: OPT has no "class" attribute, please use "size()"] unless $class++;
	&size;
}

sub ttl {				## overide RR method
	my $self = shift;
	carp qq[Usage: OPT has no "ttl" attribute, please use "flags()" or "rcode()"] unless $ttl++;
	my @rcode = map unpack( 'C',   pack 'N', $_ ), @_;
	my @flags = map unpack( 'x2n', pack 'N', $_ ), @_;
	pack 'C2n', $self->rcode(@rcode), $self->version, $self->flags(@flags);
}


sub version {
	my $version = shift->{version};
	return defined($version) ? $version : 0;
}


sub size {
	my $self = shift;
	for ( $self->{size} ) {
		my $UDP_size = 0;
		( $UDP_size, $_ ) = ( shift || 0 ) if scalar @_;
		return $UDP_size > 512 ? ( $_ = $UDP_size ) : 512 unless $_;
		return $_ > 512 ? $_ : 512;
	}
}


sub rcode {
	my $self = shift;
	return $self->{rcode} || 0 unless scalar @_;
	delete $self->{rdlength};				# (ab)used to signal incomplete value
	my $val = shift || 0;
	$self->{rcode} = $val < 16 ? 0 : $val;			# discard non-EDNS rcodes 1 .. 15
}


sub flags {
	my $self = shift;
	return $self->{flags} || 0 unless scalar @_;
	$self->{flags} = shift;
}


sub options {
	my ($self) = @_;
	&option;
	return keys %{$self->{option}};
}

sub option {
	my $self = shift;

	my $options = $self->{option} ||= {};
	while ( scalar @_ ) {
		my $number = ednsoptionbyname(shift);
		return $options->{$number} unless scalar @_;
		my $value = shift;
		delete $options->{$number};
		$options->{$number} = $value if defined $value;
	}
}


sub _specified {
	my $self = shift;
	my @spec = grep $self->{$_}, qw(size flags rcode option);
	scalar @spec;
}


1;
__END__


=head1 SYNOPSIS

    use Net::DNS;
    $opt = new Net::DNS::RR(
	type	=> "OPT",  
	flags	=> 0x8000,	# extended flags
	rcode	=> 0,		# extended RCODE
	size	=> 1280,	# UDP payload size
	);

=head1 DESCRIPTION

EDNS OPT pseudo resource record.

The OPT record supports EDNS protocol extensions and is not intended to be
created, accessed or modified directly by user applications.

All access to EDNS features is performed indirectly by operations on the
packet header. The underlying mechanism is entirely hidden from the user.

=head1 METHODS

The available methods are those inherited from the base class augmented
by the type-specific methods defined in this package.

Use of undocumented package features or direct access to internal data
structures is discouraged and could result in program termination or
other unpredictable behaviour.


=head2 version

    $version = $rr->version;

The version of EDNS used by this OPT record.

=head2 size

	$size = $packet->edns->size;
	$more = $packet->edns->size(1280);

size() advertises the maximum size (octets) of UDP packet that can be
reassembled in the network stack of the originating host.

=head2 rcode

	$extended_rcode	  = $packet->header->rcode;
	$incomplete_rcode = $packet->edns->rcode;

The 12 bit extended RCODE. The most significant 8 bits reside in the OPT
record. The least significant 4 bits can only be obtained from the packet
header.

=head2 flags

	$edns_flags = $packet->edns->flags;

	$do = $packet->header->do;
	$packet->header->do(1);

16 bit field containing EDNS extended header flags.

=head2 options, option

	@option = $packet->edns->options;

	$octets = $packet->edns->option($option_code);

	$packet->edns->option( NSID => 'value' );
	$packet->edns->option( 3    => 'value' );

When called in a list context, options() returns a list of option codes
found in the OPT record.

When called with a single argument, option() returns the octet string
corresponding to the specified option. The function value is undefined
if the specified option is absent.

Options can be changed by providing an argument list containing one or
more (name => value) pairs to be added or modified. The effect of such
changes is cumulative. An option is deleted if the value is undefined.


=head1 COPYRIGHT

Copyright (c)2001,2002 RIPE NCC.  Author Olaf M. Kolkman.

Portions Copyright (c)2012 Dick Franks.

All rights reserved.

Package template (c)2009,2012 O.M.Kolkman and R.W.Franks.


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

L<perl>, L<Net::DNS>, L<Net::DNS::RR>, RFC6891, RFC3225

=cut
