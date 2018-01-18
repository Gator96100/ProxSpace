# $File: //member/autrijus/Encode-compat/lib/Encode/compat.pm $ $Author: autrijus $
# $Revision: #7 $ $Change: 10735 $ $DateTime: 2004/06/03 14:08:57 $

package Encode::compat;
$Encode::compat::VERSION = '0.07';

use strict;

if ($] >= 5.007001 or $INC{'Encode.pm'}) {
    # nothing happens -- Encode.pm already available.
}
elsif ($] >= 5.006001 and $] <= 5.007) {
    require Encode::compat::Alias;
    $INC{'Encode/Alias.pm'} = $INC{'Encode/compat/Alias.pm'};

    require Encode::compat::common;
    require Encode::compat::5006001;
    $INC{'Encode.pm'} = __FILE__;
}
else {
    die "Encode.pm compatibility layer for $] not yet available.";
}

1;

__END__

=head1 NAME

Encode::compat - Encode.pm emulation layer

=head1 VERSION

This document describes version 0.07 of Encode::compat, released
June 3, 2004.

=head1 SYNOPSIS

    use Encode::compat; # a no-op for Perl v5.7.1+
    use Encode qw(...); # all constants and imports works transparently

    # use Encode functions as normal

=head1 DESCRIPTION

WARNING: THIS IS A PROOF-OF-CONCEPT.  Most functions are incomplete.
All implementation details are subject to change!

This module provide a compatibility layer for B<Encode.pm> users on perl
versions earlier than v5.7.1.  It translates whatever call it receives
into B<Text::Iconv>, or (in the future) B<Unicode::MapUTF8> to perform
the actual work.

The C<is_utf8()>, C<_utf8_on()> and C<_utf8_off()> calls are performed
by the method native to the perl version -- 5.6.1 would use
C<pack>/C<unpack>, 5.6.0 uses C<tr//CU>, etc.

Theoretically, it could be backported to 5.005 and earlier, with none of
the unicode-related semantics available, and serves only as a
abstraction layer above C<Text::Iconv>, C<Unicode::MapUTF8> and possibly
other transcoding modules.

=head1 CAVEATS

Currently, this module only support 5.6.1+, and merely provides the three
utility function above (C<encode()>, C<decode()> and C<from_to()>), with
a very kludgy C<FB_HTMLCREF> fallback against C<latin-1> in
C<from_to()>.

=head1 SEE ALSO

L<Encode>, L<perlunicode>

=head1 AUTHORS

Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>

=head1 COPYRIGHT

Copyright 2002, 2003, 2004 by Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>.

This program is free software; you can redistribute it and/or 
modify it under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
