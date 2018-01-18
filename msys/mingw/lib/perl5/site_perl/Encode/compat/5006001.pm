# $File: //member/autrijus/Encode-compat/lib/Encode/compat/5006001.pm $ $Author: autrijus $
# $Revision: #3 $ $Change: 2534 $ $DateTime: 2002/12/02 00:33:16 $

package Encode::compat::5006001;
our $VERSION = '0.05';

1;

package Encode;

use strict;
use base 'Exporter';
no warnings 'redefine';

sub _utf8_on {
    $_[0] = pack('U*', unpack('U0U*', $_[0]))
}

sub _utf8_off {
    $_[0] = pack('C*', unpack('C*', $_[0]))
}

sub is_utf8 {
    # XXX: got any better ideas?
    use utf8;
    foreach my $char (split(//, $_[0])) {
	return 1 if ord($char) > 255;
    }
    return 0;
}

1;
