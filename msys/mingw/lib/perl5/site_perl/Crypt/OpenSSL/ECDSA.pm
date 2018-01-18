package Crypt::OpenSSL::ECDSA;

use 5.008005;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Crypt::OpenSSL::ECDSA ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	ECDSA_F_ECDSA_CHECK
	ECDSA_F_ECDSA_DATA_NEW_METHOD
	ECDSA_F_ECDSA_DO_SIGN
	ECDSA_F_ECDSA_DO_VERIFY
	ECDSA_F_ECDSA_SIGN_SETUP
	ECDSA_R_BAD_SIGNATURE
	ECDSA_R_DATA_TOO_LARGE_FOR_KEY_SIZE
	ECDSA_R_ERR_EC_LIB
	ECDSA_R_MISSING_PARAMETERS
	ECDSA_R_NEED_NEW_SETUP_VALUES
	ECDSA_R_NON_FIPS_METHOD
	ECDSA_R_RANDOM_NUMBER_GENERATION_FAILED
	ECDSA_R_SIGNATURE_MALLOC_FAILED
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	ECDSA_F_ECDSA_CHECK
	ECDSA_F_ECDSA_DATA_NEW_METHOD
	ECDSA_F_ECDSA_DO_SIGN
	ECDSA_F_ECDSA_DO_VERIFY
	ECDSA_F_ECDSA_SIGN_SETUP
	ECDSA_R_BAD_SIGNATURE
	ECDSA_R_DATA_TOO_LARGE_FOR_KEY_SIZE
	ECDSA_R_ERR_EC_LIB
	ECDSA_R_MISSING_PARAMETERS
	ECDSA_R_NEED_NEW_SETUP_VALUES
	ECDSA_R_NON_FIPS_METHOD
	ECDSA_R_RANDOM_NUMBER_GENERATION_FAILED
	ECDSA_R_SIGNATURE_MALLOC_FAILED
);

our $VERSION = '0.07';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&Crypt::OpenSSL::ECDSA::constant not defined" if $constname eq 'constant';
    my ($error, $val) = constant($constname);
    if ($error) { croak $error; }
    {
	no strict 'refs';
	# Fixed between 5.005_53 and 5.005_61
#XXX	if ($] >= 5.00561) {
#XXX	    *$AUTOLOAD = sub () { $val };
#XXX	}
#XXX	else {
	    *$AUTOLOAD = sub { $val };
#XXX	}
    }
    goto &$AUTOLOAD;
}


eval {
	local $SIG{'__DIE__'} = 'DEFAULT';

	eval {
		require XSLoader;
		XSLoader::load( 'Crypt::OpenSSL::ECDSA', $VERSION );
		1;
	} or do {
		use vars qw(@ISA);
		require DynaLoader;
		push @ISA, 'DynaLoader';
		bootstrap('Crypt::OpenSSL::ECDSA', $VERSION);
	};
};


# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__

=head1 NAME

Crypt::OpenSSL::ECDSA - Perl extension for OpenSSL ECDSA (Elliptic Curve Digital Signature Algorithm)

=head1 SYNOPSIS

    use Crypt::OpenSSL::ECDSA;
    $sig = Crypt::OpenSSL::ECDSA::ECDSA_do_sign( $digest, $eckey );
    $r = $sig->get_r;
    $s = $sig->get_s;

    $sig = Crypt::OpenSSL::ECDSA::ECDSA_SIG->new();
    $sig->set_r($r);
    $sig->set_s($s);
    Crypt::OpenSSL::ECDSA::ECDSA_do_verify( $digest, $sig, $eckey );

=head1 DESCRIPTION

This module provides an interface to the ECDSA (Elliptic Curve Digital
Signature Algorithm) functions in OpenSSL

Tested against OpenSSL 1.0.2


=head2 Export

None by default.


=head2 Exportable constants

    ECDSA_F_ECDSA_CHECK
    ECDSA_F_ECDSA_DATA_NEW_METHOD
    ECDSA_F_ECDSA_DO_SIGN
    ECDSA_F_ECDSA_DO_VERIFY
    ECDSA_F_ECDSA_SIGN_SETUP
    ECDSA_R_BAD_SIGNATURE
    ECDSA_R_DATA_TOO_LARGE_FOR_KEY_SIZE
    ECDSA_R_ERR_EC_LIB
    ECDSA_R_MISSING_PARAMETERS
    ECDSA_R_NEED_NEW_SETUP_VALUES
    ECDSA_R_NON_FIPS_METHOD
    ECDSA_R_RANDOM_NUMBER_GENERATION_FAILED
    ECDSA_R_SIGNATURE_MALLOC_FAILED


=head1 CLASS METHODS

=item new

    $sig = Crypt::OpenSSL::ECDSA::ECDSA_SIG->new();

Create a new ECDSA Signature Object.

The internal "r" and "s" components are undefined.


=head1 OBJECT METHODS

=item get_r;

    $r = $sig->get_r;

Gets signature "r" component.

The method returns a string representing a binary integer in network
(big-endian) byte order.


=item get_s;

    $s = $sig->get_s;

Gets signature "s" component.

The method returns a string representing a binary integer in network
(big-endian) byte order.


=item set_r;

    $sig->set_r($r);

Sets signature "r" component.

The argument is a string representing a binary integer in network
(big-endian) byte order.


=item set_s;

    $sig->set_r($s);

Sets signature "s" component.

The argument is a string representing a binary integer in network
(big-endian) byte order.

=head1 SEE ALSO

L<OpenSSL documentation|http://www.openssl.org/>,
L<Crypt::OpenSSL::EC>,

=head1 AUTHOR

Mike McCauley, E<lt>mikem@airspayce.comE<gt>


=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014 by Mike McCauley

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
