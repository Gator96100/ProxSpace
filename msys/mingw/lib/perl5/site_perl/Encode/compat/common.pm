# $File: //member/autrijus/Encode-compat/lib/Encode/compat/common.pm $ $Author: autrijus $
# $Revision: #7 $ $Change: 10024 $ $DateTime: 2004/02/13 21:42:35 $

package Encode::compat::common;
our $VERSION = '0.06';

1;

package Encode;

use strict;
our $VERSION = '0.06';

our @EXPORT = qw(
  decode  decode_utf8  encode  encode_utf8
  encodings  find_encoding
);

use constant DIE_ON_ERR		=> 1;
use constant WARN_ON_ERR	=> 2;
use constant RETURN_ON_ERR	=> 4;
use constant LEAVE_SRC		=> 8;

use constant PERLQQ		=> 256;
use constant HTMLCREF		=> 512;
use constant XMLCREF		=> 1024;

use constant FB_DEFAULT		=> 0;
use constant FB_CROAK		=> 1;
use constant FB_QUIET		=> 4;
use constant FB_WARN		=> 6;
use constant FB_PERLQQ		=> 256;
use constant FB_HTMLCREF	=> 512;
use constant FB_XMLCREF		=> 1024;

our @FB_FLAGS  = qw(DIE_ON_ERR WARN_ON_ERR RETURN_ON_ERR LEAVE_SRC
                    PERLQQ HTMLCREF XMLCREF);
our @FB_CONSTS = qw(FB_DEFAULT FB_CROAK FB_QUIET FB_WARN
                    FB_PERLQQ FB_HTMLCREF FB_XMLCREF);

our @EXPORT_OK =
    (
     qw(
       _utf8_off _utf8_on define_encoding from_to is_16bit is_8bit
       is_utf8 perlio_ok resolve_alias utf8_downgrade utf8_upgrade
      ),
     @FB_FLAGS, @FB_CONSTS,
    );

our %EXPORT_TAGS =
    (
     all          =>  [ @EXPORT, @EXPORT_OK ],
     fallbacks    =>  [ @FB_CONSTS ],
     fallback_all =>  [ @FB_CONSTS, @FB_FLAGS ],
    );

sub from_to ($$$;$) {
    use utf8;

    # XXX: bad hack
    if ($_[3] and $_[3] == FB_HTMLCREF() and lc($_[2]) eq 'latin1') {
	$_[0] = join('', map {
	    ord($_) < 128
		? $_ : '&#' . ord($_) . ';'
	} split(//, decode($_[1], $_[0])));
    }
    else {
	$_[0] = _convert(@_[0..2]);
    }
}

sub encodings {
    # XXX: revisit
    require Encode::Alias;
    return sort values %Encode::Alias::Alias;
}

sub find_encoding {
    return $_[0];
}

sub decode_utf8($;$) {
    return decode("utf-8", @_);
}

sub encode_utf8($;$) {
    return encode("utf-8", @_);
}

sub decode($$;$) {
    my $result = ($_[0] =~ /utf-?8/i)
	? $_[1] : _convert($_[1], $_[0] => 'utf-8'); 
    _utf8_on($result);
    return $result;
}

sub encode($$;$) {
    my $result = ($_[0] =~ /utf-?8/i)
	? $_[1] : _convert($_[1], 'utf-8' => $_[0]);
    _utf8_off($result);
    return $result;
}

{
    my %decoder;
    sub _convert {
	require Text::Iconv;
	Text::Iconv->raise_error(1);

	require Encode::Alias;
	my ($from, $to) = map {
	    s/^utf8$/utf-8/i;
	    s/^big5-eten$/big5/i;
	    $_;
	} map {
	    Encode::Alias->find_alias($_) || lc($_)
	} ($_[1], $_[2]);

	my $result = ($from eq $to) ? $_[0] : (
	    $decoder{$from, $to} ||= Text::Iconv->new( $from, $to )
	)->convert($_[0]);

	return $result;
    }
}

1;
