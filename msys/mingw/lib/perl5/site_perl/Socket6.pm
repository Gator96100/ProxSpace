# Copyright (C) 2000-2016 Hajimu UMEMOTO <ume@mahoroba.org>.
# All rights reserved.
#
# This module is based on perl5.005_55-v6-19990721 written by KAME
# Project.
#
# Copyright (C) 1995, 1996, 1997, 1998, and 1999 WIDE Project.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of the project nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

# $Id: Socket6.pm 664 2016-03-22 16:11:41Z ume $

package Socket6;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $AUTOLOAD);
$VERSION = "0.27";

=head1 NAME

Socket6 - IPv6 related part of the C socket.h defines and structure manipulators

=head1 SYNOPSIS

    use Socket;
    use Socket6;

    @res = getaddrinfo('hishost.com', 'daytime', AF_UNSPEC, SOCK_STREAM);
    $family = -1;
    while (scalar(@res) >= 5) {
	($family, $socktype, $proto, $saddr, $canonname, @res) = @res;

	($host, $port) = getnameinfo($saddr, NI_NUMERICHOST | NI_NUMERICSERV);
	print STDERR "Trying to connect to $host port $port...\n";

	socket(Socket_Handle, $family, $socktype, $proto) || next;
        connect(Socket_Handle, $saddr) && last;

	close(Socket_Handle);
	$family = -1;
    }

    if ($family != -1) {
	print STDERR "connected to $host port $port\n";
    } else {
	die "connect attempt failed\n";
    }

=head1 DESCRIPTION

This module provides glue routines to the various IPv6 functions.

If you use the Socket6 module,
be sure to specify "use Socket" as well as "use Socket6".

Functions supplied are:

=over

=item inet_pton FAMILY, TEXT_ADDRESS

    This function takes an IP address in presentation (or string) format
    and converts it into numeric (or binary) format.
    The type of IP address conversion (IPv4 versus IPv6) is controlled
    by the FAMILY argument.

=item inet_ntop FAMILY, BINARY_ADDRESS

    This function takes an IP address in numeric (or binary) format
    and converts it into presentation (or string) format
    The type of IP address conversion (IPv4 versus IPv6) is controlled
    by the FAMILY argument.

=item pack_sockaddr_in6 PORT, ADDR

    This function takes two arguments: a port number, and a 16-octet
    IPv6 address structure (as returned by inet_pton()).
    It returns the sockaddr_in6 structure with these arguments packed
    into their correct fields, as well as the AF_INET6 family.
    The other fields are not set and their values should not be relied upon.

=item pack_sockaddr_in6_all PORT, FLOWINFO, ADDR, SCOPEID

    This function takes four arguments: a port number, a 16-octet
    IPv6 address structure (as returned by inet_pton), any
    special flow information, and any specific scope information.
    It returns a complete sockaddr_in6 structure with these arguments packed
    into their correct fields, as well as the AF_INET6 family.

=item unpack_sockaddr_in6 NAME

    This function takes a sockaddr_in6 structure (as returned by
    pack_sockaddr_in6()) and returns a list of two elements:
    the port number and the 16-octet IP address.
    This function will croak if it determines it has not been
    passed an IPv6 structure.

=item unpack_sockaddr_in6_all NAME

    This function takes a sockaddr_in6 structure (as returned by
    pack_sockaddr_in6()) and returns a list of four elements:
    the port number, the flow information, the 16-octet IP address,
    and the scope information.
    This function will croak if it determines it has not been
    passed an IPv6 structure.

=item gethostbyname2 HOSTNAME, FAMILY

=item getaddrinfo NODENAME, SERVICENAME, [FAMILY, SOCKTYPE, PROTOCOL, FLAGS]

    This function converts node names to addresses and service names
    to port numbers.
    If the NODENAME argument is not a false value,
    then a nodename to address lookup is performed;
    otherwise a service name to port number lookup is performed.
    At least one of NODENAME and SERVICENAME must have a true value.

    If the lookup is successful, a list consisting of multiples of
    five elements is returned.
    Each group of five elements consists of the address family,
    socket type, protocol, 16-octet IP address, and the canonical
    name (undef if the node name passed is already the canonical name).

    The arguments FAMILY, SOCKTYPE, PROTOCOL, and FLAGS are all optional.

    This function will croak if it determines it has not been
    passed an IPv6 structure.

    If the lookup is unsuccessful, the function returns a single scalar.
    This will contain the string version of that error in string context,
    and the numeric value in numeric context.

=item getnameinfo NAME, [FLAGS]

    This function takes a socket address structure. If successful, it returns
    two strings containing the node name and service name.

    The optional FLAGS argument controls what kind of lookup is performed.

    If the lookup is unsuccessful, the function returns a single scalar.
    This will contain the string version of that error in string context,
    and the numeric value in numeric context.

=item getipnodebyname HOST, [FAMILY, FLAGS]

    This function takes either a node name or an IP address string
    and performs a lookup on that name (or conversion of the string).
    It returns a list of five elements: the canonical host name,
    the address family, the length in octets of the IP addresses
    returned, a reference to a list of IP address structures, and
    a reference to a list of aliases for the host name.

    The arguments FAMILY and FLAGS are optional.
    Note: This function does not handle IPv6 scope identifiers,
    and should be used with care.
    And, this function was deprecated in RFC3493.
    The getnameinfo function should be used instead.

=item getipnodebyaddr FAMILY, ADDRESS

    This function takes an IP address family and an IP address structure
    and performs a reverse lookup on that address.
    It returns a list of five elements: the canonical host name,
    the address family, the length in octets of the IP addresses
    returned, a reference to a list of IP address structures, and
    a reference to a list of aliases for the host name.

    Note: This function does not handle IPv6 scope identifiers,
    and should be used with care.
    And, this function was deprecated in RFC3493.
    The getaddrinfo function should be used instead.

=item gai_strerror ERROR_NUMBER

    This function returns a string corresponding to the error number
    passed in as an argument.

=item in6addr_any

    This function returns the 16-octet wildcard address.

=item in6addr_loopback

    This function returns the 16-octet loopback address.

=back

=cut

use Carp;

use base qw(Exporter DynaLoader);

@EXPORT = qw(
	inet_pton inet_ntop pack_sockaddr_in6 pack_sockaddr_in6_all
	unpack_sockaddr_in6 unpack_sockaddr_in6_all sockaddr_in6
	gethostbyname2 getaddrinfo getnameinfo
	in6addr_any in6addr_loopback
	gai_strerror getipnodebyname getipnodebyaddr
	AI_ADDRCONFIG
	AI_ALL
	AI_CANONNAME
	AI_NUMERICHOST
	AI_NUMERICSERV
	AI_DEFAULT
	AI_MASK
	AI_PASSIVE
	AI_V4MAPPED
	AI_V4MAPPED_CFG
	EAI_ADDRFAMILY
	EAI_AGAIN
	EAI_BADFLAGS
	EAI_FAIL
	EAI_FAMILY
	EAI_MEMORY
	EAI_NODATA
	EAI_NONAME
	EAI_SERVICE
	EAI_SOCKTYPE
	EAI_SYSTEM
	EAI_BADHINTS
	EAI_PROTOCOL
	IP_AUTH_TRANS_LEVEL
	IP_AUTH_NETWORK_LEVEL
	IP_ESP_TRANS_LEVEL
	IP_ESP_NETWORK_LEVEL
	IPPROTO_IP
	IPPROTO_IPV6
	IPSEC_LEVEL_AVAIL
	IPSEC_LEVEL_BYPASS
	IPSEC_LEVEL_DEFAULT
	IPSEC_LEVEL_NONE
	IPSEC_LEVEL_REQUIRE
	IPSEC_LEVEL_UNIQUE
	IPSEC_LEVEL_USE
	IPV6_AUTH_TRANS_LEVEL
	IPV6_AUTH_NETWORK_LEVEL
	IPV6_ESP_NETWORK_LEVEL
	IPV6_ESP_TRANS_LEVEL
	NI_NOFQDN
	NI_NUMERICHOST
	NI_NAMEREQD
	NI_NUMERICSERV
	NI_DGRAM
	NI_WITHSCOPEID
);
push @EXPORT, qw(AF_INET6) unless defined eval {Socket::AF_INET6()};
push @EXPORT, qw(PF_INET6) unless defined eval {Socket::PF_INET6()};

@EXPORT_OK = qw(AF_INET6 PF_INET6);

%EXPORT_TAGS = (
    all     => [@EXPORT],
);

sub sockaddr_in6 {
    if (wantarray) {
	croak "usage:   (port,iaddr) = sockaddr_in6(sin_sv)" unless @_ == 1;
        unpack_sockaddr_in6(@_);
    } else {
	croak "usage:   sin_sv = sockaddr_in6(port,iaddr))" unless @_ == 2;
        pack_sockaddr_in6(@_);
    }
}

sub AUTOLOAD {
    my($constname);
    ($constname = $AUTOLOAD) =~ s/.*:://o;
    $! = 0;
    my $val = constant($constname, @_ ? $_[0] : 0);
    if ($! != 0) {
	croak "Your vendor has not defined Socket macro $constname, used";
    }
    eval "sub $AUTOLOAD { $val }";
    goto &$AUTOLOAD;
}

bootstrap Socket6 $VERSION;

1;
