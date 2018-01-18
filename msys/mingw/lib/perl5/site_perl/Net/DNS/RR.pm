package Net::DNS::RR;

#
# $Id: RR.pm 1475 2016-04-15 09:46:40Z willem $
#
use vars qw($VERSION);
$VERSION = (qw$LastChangedRevision: 1475 $)[1];


=head1 NAME

Net::DNS::RR - DNS resource record base class

=head1 SYNOPSIS

    use Net::DNS;

    $rr = new Net::DNS::RR('example.com IN A 192.0.2.99');

    $rr = new Net::DNS::RR(
	    name    => 'example.com',
	    type    => 'A',
	    address => '192.0.2.99'
	    );


=head1 DESCRIPTION

Net::DNS::RR is the base class for DNS Resource Record (RR) objects.
See also the manual pages for each specific RR type.

=cut


use strict;
use integer;
use Carp;

use Net::DNS::Parameters;
use Net::DNS::Domain;
use Net::DNS::DomainName;


=head1 METHODS

B<WARNING!!!>  Do not assume the RR objects you receive from a query
are of a particular type.  You must always check the object type
before calling any of its methods.  If you call an unknown method,
you will get an error message and execution will be terminated.

=cut

sub new {
	return eval {
		local $SIG{__DIE__};
		scalar @_ > 2 ? &_new_hash : &_new_string;
	} || do {
		my $class = shift || __PACKAGE__;
		my @param = map defined($_) ? split : 'undef', @_;
		my $stmnt = substr "new $class( @param )", 0, 80;
		croak "${@}in $stmnt\n";
	};
}


=head2 new (from string)

    $a	   = new Net::DNS::RR('host.example.com. 86400 A 192.0.2.1');
    $mx	   = new Net::DNS::RR('example.com. 7200 MX 10 mailhost.example.com.');
    $cname = new Net::DNS::RR('www.example.com 300 IN CNAME host.example.com');
    $txt   = new Net::DNS::RR('txt.example.com 3600 HS TXT "text data"');

Returns an RR object of the appropriate type, or a C<Net::DNS::RR>
object if the type is not implemented.	The attribute values are
extracted from the string passed by the user.  The syntax of the
argument string follows the RFC1035 specification for zone files,
and is compatible with the result returned by the string method.

The name and RR type are required; all other information is optional.
If omitted, the TTL defaults to 0 and the RR class defaults to IN.
Omitting the optional fields is useful for creating the empty RDATA
sections required for certain dynamic update operations.  See the
C<Net::DNS::Update> manual page for additional examples.

All names are interpreted as fully qualified domain names.
The trailing dot (.) is optional.

=cut

my $PARSE_REGEX = q/("[^"]*")|;[^\n]*|[ \t\n\r\f()]/;

sub _new_string {
	my $base;
	local $_;
	( $base, $_ ) = @_;
	croak 'argument absent or undefined' unless defined $_;
	croak 'non-scalar argument' if ref $_;

	# parse into quoted strings, contiguous non-whitespace and (discarded) comments
	s/\\\\/\\092/g;						# disguise escaped escape
	s/\\"/\\034/g;						# disguise escaped quote
	s/\\\(/\\040/g;						# disguise escaped bracket
	s/\\\)/\\041/g;						# disguise escaped bracket
	s/\\;/\\059/g;						# disguise escaped semicolon
	my ( $name, @token ) = grep defined && length, split /$PARSE_REGEX/o;

	my ( $t1, $t2, $t3 ) = @token;
	croak 'unable to parse RR string' unless defined $t1;

	my ( $ttl, $class );
	unless ( defined $t2 ) {				# <name> <type>
		@token = ('ANY') if $classbyname{$t1};		# <name> <class>
	} elsif ( $classbyname{$t1} || $t1 =~ /^CLASS\d/ ) {
		$class = shift @token;				# <name> <class> [<ttl>] <type>
		$ttl = shift @token if $t2 =~ /^\d/;
	} elsif ( $t1 =~ /^\d/ ) {
		$ttl = shift @token;				# <name> <ttl> [<class>] <type>
		$class = shift @token if $classbyname{$t2} || $t2 =~ /^CLASS\d/;
	}

	my $type      = shift(@token);
	my $populated = scalar @token;

	my $self = $base->_subclass( $type, $populated );	# create RR object
	$self->name($name);
	$self->class($class) if defined $class;			# specify CLASS
	$self->ttl($ttl)     if defined $ttl;			# specify TTL

	return $self unless $populated;				# empty RR

	if ( $#token && $token[0] =~ /^[\\]?#$/ ) {
		shift @token;					# RFC3597 hexadecimal format
		my $count = shift(@token) || 0;
		my $rdata = pack 'H*', join '', @token;
		my $rdlen = $self->{rdlength} = length $rdata;
		croak 'length and hexadecimal data inconsistent' unless $rdlen == $count;
		$self->_decode_rdata( \$rdata, 0 ) if $rdlen;	# unpack RDATA
		return $self;
	}

	$self->_parse_rdata(@token);				# parse arguments
	return $self;
}


=head2 new (from hash)

    $rr = new Net::DNS::RR(%hash);

    $rr = new Net::DNS::RR(
	    name    => 'host.example.com',
	    ttl	    => 86400,
	    class   => 'IN',
	    type    => 'A',
	    address => '192.0.2.1'
	    );
 
    $rr = new Net::DNS::RR(
	    name    => 'txt.example.com',
	    type    => 'TXT',
	    txtdata => [ 'one', 'two' ]
	    );

Returns an RR object of the appropriate type, or a C<Net::DNS::RR>
object if the type is not implemented.	See the manual pages for
each RR type to see what fields the type requires.

The C<name> and C<type> fields are required; all others are optional.
If omitted, C<ttl> defaults to 0 and C<class> defaults to IN.
Omitting the optional fields is useful for creating the empty RDATA
sections required for certain dynamic update operations.

=cut

sub _new_hash {
	my ( $base, %argument ) = @_;

	my %attribute = ( name => '.', type => 'ANY' );
	while ( my ( $key, $value ) = each %argument ) {
		$attribute{lc $key} = $value;
	}

	my ( $name, $type, $class, $ttl ) = @attribute{qw(name type class ttl)};
	delete @attribute{qw(name class type ttl rdlength)};	# strip non-RDATA fields

	my $populated = scalar %attribute;			# RDATA specified

	my $self = $base->_subclass( $type, $populated );	# RR with defaults (if appropriate)
	$self->name($name);
	$self->class($class) if defined $class;			# specify CLASS
	$self->ttl($ttl)     if defined $ttl;			# specify TTL

	while ( my ( $attribute, $value ) = each %attribute ) {
		$self->$attribute( ref($value) eq 'ARRAY' ? @$value : $value );
	}

	return $self;
}


=head2 decode

    ( $rr, $next ) = decode Net::DNS::RR( \$data, $offset, @opaque );

Decodes a DNS resource record at the specified location within a
DNS packet.

The argument list consists of a reference to the buffer containing
the packet data and offset indicating where resource record begins.
Remaining arguments, if any, are passed as opaque data to
subordinate decoders.

Returns a C<Net::DNS::RR> object and the offset of the next record
in the packet.

An exception is raised if the data buffer contains insufficient or
corrupt data.

Any remaining arguments are passed as opaque data to subordinate
decoders and do not form part of the published interface.

=cut

use constant RRFIXEDSZ => length pack 'n2 N n', (0) x 4;

sub decode {
	my $base = shift;
	my ( $data, $offset, @opaque ) = @_;

	my ( $owner, $fixed ) = decode Net::DNS::DomainName1035(@_);

	my $index = $fixed + RRFIXEDSZ;
	die 'corrupt wire-format data' if length $$data < $index;
	my $type = unpack "\@$fixed n", $$data;
	my $self = $base->_subclass( typebyval($type) );
	$self->{owner} = $owner;
	@{$self}{qw(class ttl rdlength)} = unpack "\@$fixed x2 n N n", $$data;

	my $next = $index + $self->{rdlength};
	die 'corrupt wire-format data' if length $$data < $next;

	$self->{offset} = $offset || 0;
	$self->_decode_rdata( $data, $index, @opaque ) if $next > $index or $self->type eq 'OPT';
	delete $self->{offset};

	return wantarray ? ( $self, $next ) : $self;
}


=head2 encode

    $data = $rr->encode( $offset, @opaque );

Returns the C<Net::DNS::RR> in binary format suitable for inclusion
in a DNS packet buffer.

The offset indicates the intended location within the packet data
where the C<Net::DNS::RR> is to be stored.

Any remaining arguments are opaque data which are passed intact to
subordinate encoders.

=cut

sub encode {
	my $self = shift;
	my ( $offset, @opaque ) = scalar(@_) ? @_ : ( 0x4000, {} );

	my $owner = $self->{owner}->encode( $offset, @opaque );
	my $type  = $self->{type};
	my $class = $self->{class} || 1;
	my $index = $offset + length($owner) + RRFIXEDSZ;
	my $rdata = eval { $self->_encode_rdata( $index, @opaque ); } || '';
	return pack 'a* n2 N n a*', $owner, $type, $class, $self->ttl, length $rdata, $rdata;
}


=head2 canonical

    $data = $rr->canonical;

Returns the C<Net::DNS::RR> in canonical binary format suitable for
DNSSEC signature validation.

The absence of the associative array argument signals to subordinate
encoders that the canonical uncompressed lower case form of embedded
domain names is to be used.

=cut

sub canonical {
	my $self = shift;

	my $owner = $self->{owner}->canonical;
	my $type  = $self->{type};
	my $class = $self->{class} || 1;
	my $index = RRFIXEDSZ + length $owner;
	my $rdata = eval { $self->_encode_rdata($index); } || '';
	pack 'a* n2 N n a*', $owner, $type, $class, $self->ttl, length $rdata, $rdata;
}


=head2 print

    $rr->print;

Prints the record to the standard output.  Calls the string method
to get the formatted RR representation.

=cut

sub print {
	print shift->string, "\n";
}


=head2 string

    print $rr->string, "\n";

Returns a string representation of the RR using the zone file format
described in RFC1035.  All domain names are fully qualified with
trailing dot.  This differs from RR attribute methods, which omit
the trailing dot.

=cut

sub string {
	my $self = shift;

	my @ttl = grep defined, ( $self->{ttl} );
	my $core = join "\t", $self->{owner}->string, @ttl, $self->class, $self->type;

	my $rdata = $self->rdstring( 14 + length $core );
	return join "\t", $core, length $rdata ? $rdata : '; no data';
}


=head2 owner name

    $owner = $rr->name;

Returns the owner name of the record.

=cut

sub name {
	my $self = shift;
	$self->{owner} = new Net::DNS::DomainName1035(shift) if scalar @_;
	$self->{owner}->name if defined wantarray;
}

sub owner { &name; }			## compatibility with RFC1034


=head2 type

    $type = $rr->type;

Returns the record type.

=cut

sub type {
	my $self = shift;
	croak 'not possible to change RR->type' if scalar @_;
	typebyval( $self->{type} );
}


=head2 class

    $class = $rr->class;

Resource record class.

=cut

sub class {
	my $self = shift;
	$self->{class} = classbyname(shift) if scalar @_;
	classbyval( $self->{class} || 1 ) if defined wantarray;
}


=head2 ttl

    $ttl = $rr->ttl;
    $ttl = $rr->ttl(3600);

Resource record time to live in seconds.

=cut

# The following time units are recognised, but are not part of the
# published API.  These are required for parsing BIND zone files but
# should not be used in other contexts.
my %unit = ( W => 604800, D => 86400, H => 3600, M => 60, S => 1 );
%unit = ( %unit, map { /\D/ ? lc($_) : $_ } %unit );

sub ttl {
	my ( $self, $time ) = @_;

	return $self->{ttl} || 0 unless defined $time;		# avoid defining rr->{ttl}

	my $ttl = 0;
	my %time = reverse split /(\D)\D*/, $time . 'S';
	while ( my ( $u, $t ) = each %time ) {
		my $scale = $unit{$u} || die qq(bad time: $t$u);
		$ttl += $t * $scale;
	}
	$self->{ttl} = $ttl;
}


################################################################################
##
##	Default implementation for unknown RR type
##
################################################################################

sub _decode_rdata {			## decode rdata from wire-format octet string
	my ( $self, $data, $offset ) = @_;
	$self->{rdata} = substr $$data, $offset, $self->{rdlength};
}


sub _encode_rdata {			## encode rdata as wire-format octet string
	my $rdata = shift->{rdata};
	return defined $rdata ? $rdata : '';
}


sub _format_rdata {			## format rdata portion of RR string
	my $self = shift;
	my $data = $self->_encode_rdata;
	my $size = length($data) || return '';
	join ' ', '\\#', $size, unpack 'H*', $data;		# RFC3597 unknown RR format
}


sub _parse_rdata {			## parse RR attributes in argument list
	my $self = shift;
	die join ' ', $self->type, 'not implemented' if ref($self) eq __PACKAGE__;
	die join ' ', 'no zone file representation defined for', $self->type;
}


sub _defaults { }			## set attribute default values


sub dump {				## print internal data structure
	require Data::Dumper;					# uncoverable pod
	local $Data::Dumper::Maxdepth = $Data::Dumper::Maxdepth || 6;
	local $Data::Dumper::Sortkeys = $Data::Dumper::Sortkeys || 1;
	print Data::Dumper::Dumper(@_);
}

sub rdatastr {				## obsolete RR subtype method
	&rdstring;						# uncoverable pod
}


=head2 rdata

    $rr = new Net::DNS::RR( type => NULL, rdata => 'arbitrary' );

Resource record data section when viewed as opaque octets.

=cut

sub rdata {
	my $self = shift;

	return eval { $self->_encode_rdata( 0x4000, {} ); } unless scalar @_;

	my $rdata = shift;
	my $rdlen = $self->{rdlength} = length $rdata;
	my $hash  = {};
	$self->_decode_rdata( \$rdata, 0, $hash ) if $rdlen;
	croak 'found compression pointer in rdata' if keys %$hash;
}


=head2 rdstring

    $rdstring = $rr->rdstring;

Returns a string representation of the RR-specific data.

=cut

sub rdstring {
	my $self = shift;
	my $coln = shift || 0;
	my $cols = 80;

	my @rdata = eval { $self->_format_rdata; };

	carp $@ if $@;

	my ( @line, @fill );
	foreach (@rdata) {
		if ( ( $coln += 1 + length ) > $cols ) {
			push @line, join ' ', @fill;		# multi-line format
			$coln = length;
			@fill = ();
		}
		$coln = $cols if chomp;				# line terminator
		push( @fill, $_ );
	}
	return join ' ', @fill unless scalar @line;		# simple RR

	$line[0] = '( ' . $line[0];				# multi-line RR
	return join "\n\t", @line, join ' ', @fill, ')' if $coln < $cols;
	return join "\n\t", @line, join( ' ', @fill ), ')';
}


=head2 rdlength

    $rdlength = $rr->rdlength;

Returns the length of the encoded RR-specific data.

=cut

sub rdlength {
	length shift->_encode_rdata;
}


=head2 plain

    $plain = $rr->plain;

Returns a simplified single line representation of the RR using the
zone file format defined in RFC1035.  This facilitates interaction
with programs like nsupdate which have simplified RR parsers.

=cut

sub plain {
	join ' ', shift->token;
}


=head2 token

    @token = $rr->token;

Returns a token list representation of the RR zone file string.

=cut

sub token {
	local $_ = shift->string;

	# parse into quoted strings, contiguous non-whitespace and (discarded) comments
	s/\\\\/\\092/g;						# disguise escaped escape
	s/\\"/\\034/g;						# disguise escaped quote
	s/\\\(/\\040/g;						# disguise escaped bracket
	s/\\\)/\\041/g;						# disguise escaped bracket
	s/\\;/\\059/g;						# disguise escaped semicolon
	my @token = grep defined && length, split /$PARSE_REGEX/o;
}


###################################################################################

=head1 Sorting of RR arrays

Sorting of RR arrays is done by Net::DNS::rrsort(), see documentation
for L<Net::DNS>. This package provides class methods to set the
comparator function used for a particular RR based on its attributes.


=head2 set_rrsort_func

    my $function = sub {		## numerically ascending order
	$Net::DNS::a->{'preference'} <=> $Net::DNS::b->{'preference'};
    };

    Net::DNS::RR::MX->set_rrsort_func( 'preference', $function );

    Net::DNS::RR::MX->set_rrsort_func( 'default_sort', $function );

set_rrsort_func() must be called as a class method. The first argument is
the attribute name on which the sorting is to take place. If you specify
"default_sort" then that is the sort algorithm that will be used when
get_rrsort_func() is called without an RR attribute as argument.

The second argument is a reference to a comparator function that uses the
global variables $a and $b in the Net::DNS package. During sorting, the
variables $a and $b will contain references to objects of the class whose
set_rrsort_func() was called. The above sorting function will only be
applied to Net::DNS::RR::MX objects.

The above example is the sorting function implemented in MX.

=cut

use vars qw(%rrsortfunct);

sub set_rrsort_func {
	my $class     = shift;
	my $attribute = shift;
	my $function  = shift;

	my ($type) = $class =~ m/::([^:]+)$/;
	$rrsortfunct{$type}{$attribute} = $function;
}


=head2 get_rrsort_func

    $function = Net::DNS::RR::MX->get_rrsort_func('preference');
    $function = Net::DNS::RR::MX->get_rrsort_func();

get_rrsort_func() returns a reference to the comparator function.

=cut

my $default = sub { $Net::DNS::a->canonical() cmp $Net::DNS::b->canonical(); };

sub get_rrsort_func {
	my $class = shift;
	my $attribute = shift || 'default_sort';

	my ($type) = $class =~ m/::([^:]+)$/;

	$rrsortfunct{$type}{$attribute} || $default;
}


################################################################################
#
#  Net::DNS::RR->_subclass($rrtype)
#  Net::DNS::RR->_subclass($rrtype, $default)
#
# Create a new object blessed into appropriate RR subclass, after
# loading the subclass module (if necessary).  A subclass with no
# corresponding module will be regarded as unknown and blessed
# into the RR base class.
#
# The optional second argument indicates that default values are
# to be copied into the newly created object.

use vars qw(%_LOADED %_MINIMAL);

$_MINIMAL{ANY} = bless [type => 255], __PACKAGE__;
%_LOADED = %_MINIMAL;

sub _subclass {
	my $class   = shift;
	my $rrtype  = shift;
	my $default = shift;

	unless ( $_LOADED{$rrtype} ) {
		my $number = typebyname($rrtype);
		my $mnemon = typebyval($number);

		unless ( $_LOADED{$mnemon} ) {			# load once only
			$mnemon =~ s/[^A-Za-z0-9]//g;		# expect the unexpected

			my $module = join '::', __PACKAGE__, $mnemon;
			my $subclass = eval("require $module") ? $module : __PACKAGE__;

			# cache pre-built minimal and populated default object images
			my @base = ( 'type' => $number, $@ ? ( 'exception' => $@ ) : () );

			$_MINIMAL{$mnemon} = bless [@base], $subclass;

			my $object = bless {@base}, $subclass;
			$object->_defaults;
			$_LOADED{$mnemon} = bless [%$object], $subclass;
		}

		$_MINIMAL{$rrtype} = $_MINIMAL{$mnemon};
		$_LOADED{$rrtype}  = $_LOADED{$mnemon};
	}

	my $prebuilt = $default ? $_LOADED{$rrtype} : $_MINIMAL{$rrtype};
	bless {@$prebuilt}, ref($prebuilt);			# create object
}


################################################################################

use vars qw($AUTOLOAD);

sub DESTROY { }				## Avoid tickling AUTOLOAD (in cleanup)

sub AUTOLOAD {				## Default method
	my $self = shift;
	my $oref = ref($self);
	confess 'undefined method ', $AUTOLOAD unless $oref;
	confess "unknown RRtype\n" . $self->{exception} if $oref eq __PACKAGE__;

	no strict q/refs/;
	my ($method) = reverse split /::/, $AUTOLOAD;
	*{$AUTOLOAD} = sub {undef};	## suppress repetition and deep recursion

	my $string = $self->string;
	my @object = grep defined($_), $oref->VERSION, $oref;

	@_ = (<<"END");
***  FATAL PROGRAM ERROR!!	Unknown method '$method'
***  which the program has attempted to call for the object:
***
$string
***
***  The @object object has no method '$method'
***  THIS IS A BUG IN THE CALLING SOFTWARE, which incorrectly assumes
***  that the object would be of a particular type.  The type of an
***  object should be checked before calling any of its methods.
END
	goto &{'Carp::confess'};
}


1;
__END__


=head1 COPYRIGHT

Copyright (c)1997-2001 Michael Fuhr. 

Portions Copyright (c)2002,2003 Chris Reinhardt.

Portions Copyright (c)2005-2007 Olaf Kolkman.

Portions Copyright (c)2007,2012 Dick Franks.

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

L<perl>, L<Net::DNS>, L<Net::DNS::Question>,
L<Net::DNS::Packet>, L<Net::DNS::Update>,
RFC1035 Section 4.1.3, RFC1123, RFC3597

=cut

