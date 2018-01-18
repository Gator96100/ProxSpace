package Crypt::OpenSSL::EC;

use 5.008005;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

# 0=no warns, 1=only errors, 2=ciphers, 3=progress, 4=dump data
$Crypt::OpenSSL::EC::trace = 0;  # Do not change here, use
                          # $Crypt::OpenSSL::EC::trace = [1-4]  in caller

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Crypt::OpenSSL::EC ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	EC_F_COMPUTE_WNAF
	EC_F_D2I_ECPARAMETERS
	EC_F_D2I_ECPKPARAMETERS
	EC_F_D2I_ECPRIVATEKEY
	EC_F_DO_EC_KEY_PRINT
	EC_F_ECKEY_PARAM2TYPE
	EC_F_ECKEY_PARAM_DECODE
	EC_F_ECKEY_PRIV_DECODE
	EC_F_ECKEY_PRIV_ENCODE
	EC_F_ECKEY_PUB_DECODE
	EC_F_ECKEY_PUB_ENCODE
	EC_F_ECKEY_TYPE2PARAM
	EC_F_ECPARAMETERS_PRINT
	EC_F_ECPARAMETERS_PRINT_FP
	EC_F_ECPKPARAMETERS_PRINT
	EC_F_ECPKPARAMETERS_PRINT_FP
	EC_F_ECP_NIST_MOD_192
	EC_F_ECP_NIST_MOD_224
	EC_F_ECP_NIST_MOD_256
	EC_F_ECP_NIST_MOD_521
	EC_F_EC_ASN1_GROUP2CURVE
	EC_F_EC_ASN1_GROUP2FIELDID
	EC_F_EC_ASN1_GROUP2PARAMETERS
	EC_F_EC_ASN1_GROUP2PKPARAMETERS
	EC_F_EC_ASN1_PARAMETERS2GROUP
	EC_F_EC_ASN1_PKPARAMETERS2GROUP
	EC_F_EC_EX_DATA_SET_DATA
	EC_F_EC_GF2M_MONTGOMERY_POINT_MULTIPLY
	EC_F_EC_GF2M_SIMPLE_GROUP_CHECK_DISCRIMINANT
	EC_F_EC_GF2M_SIMPLE_GROUP_SET_CURVE
	EC_F_EC_GF2M_SIMPLE_OCT2POINT
	EC_F_EC_GF2M_SIMPLE_POINT2OCT
	EC_F_EC_GF2M_SIMPLE_POINT_GET_AFFINE_COORDINATES
	EC_F_EC_GF2M_SIMPLE_POINT_SET_AFFINE_COORDINATES
	EC_F_EC_GF2M_SIMPLE_SET_COMPRESSED_COORDINATES
	EC_F_EC_GFP_MONT_FIELD_DECODE
	EC_F_EC_GFP_MONT_FIELD_ENCODE
	EC_F_EC_GFP_MONT_FIELD_MUL
	EC_F_EC_GFP_MONT_FIELD_SET_TO_ONE
	EC_F_EC_GFP_MONT_FIELD_SQR
	EC_F_EC_GFP_MONT_GROUP_SET_CURVE
	EC_F_EC_GFP_MONT_GROUP_SET_CURVE_GFP
	EC_F_EC_GFP_NIST_FIELD_MUL
	EC_F_EC_GFP_NIST_FIELD_SQR
	EC_F_EC_GFP_NIST_GROUP_SET_CURVE
	EC_F_EC_GFP_SIMPLE_GROUP_CHECK_DISCRIMINANT
	EC_F_EC_GFP_SIMPLE_GROUP_SET_CURVE
	EC_F_EC_GFP_SIMPLE_GROUP_SET_CURVE_GFP
	EC_F_EC_GFP_SIMPLE_GROUP_SET_GENERATOR
	EC_F_EC_GFP_SIMPLE_MAKE_AFFINE
	EC_F_EC_GFP_SIMPLE_OCT2POINT
	EC_F_EC_GFP_SIMPLE_POINT2OCT
	EC_F_EC_GFP_SIMPLE_POINTS_MAKE_AFFINE
	EC_F_EC_GFP_SIMPLE_POINT_GET_AFFINE_COORDINATES
	EC_F_EC_GFP_SIMPLE_POINT_GET_AFFINE_COORDINATES_GFP
	EC_F_EC_GFP_SIMPLE_POINT_SET_AFFINE_COORDINATES
	EC_F_EC_GFP_SIMPLE_POINT_SET_AFFINE_COORDINATES_GFP
	EC_F_EC_GFP_SIMPLE_SET_COMPRESSED_COORDINATES
	EC_F_EC_GFP_SIMPLE_SET_COMPRESSED_COORDINATES_GFP
	EC_F_EC_GROUP_CHECK
	EC_F_EC_GROUP_CHECK_DISCRIMINANT
	EC_F_EC_GROUP_COPY
	EC_F_EC_GROUP_GET0_GENERATOR
	EC_F_EC_GROUP_GET_COFACTOR
	EC_F_EC_GROUP_GET_CURVE_GF2M
	EC_F_EC_GROUP_GET_CURVE_GFP
	EC_F_EC_GROUP_GET_DEGREE
	EC_F_EC_GROUP_GET_ORDER
	EC_F_EC_GROUP_GET_PENTANOMIAL_BASIS
	EC_F_EC_GROUP_GET_TRINOMIAL_BASIS
	EC_F_EC_GROUP_NEW
	EC_F_EC_GROUP_NEW_BY_CURVE_NAME
	EC_F_EC_GROUP_NEW_FROM_DATA
	EC_F_EC_GROUP_PRECOMPUTE_MULT
	EC_F_EC_GROUP_SET_CURVE_GF2M
	EC_F_EC_GROUP_SET_CURVE_GFP
	EC_F_EC_GROUP_SET_EXTRA_DATA
	EC_F_EC_GROUP_SET_GENERATOR
	EC_F_EC_KEY_CHECK_KEY
	EC_F_EC_KEY_COPY
	EC_F_EC_KEY_GENERATE_KEY
	EC_F_EC_KEY_NEW
	EC_F_EC_KEY_PRINT
	EC_F_EC_KEY_PRINT_FP
	EC_F_EC_POINTS_MAKE_AFFINE
	EC_F_EC_POINT_ADD
	EC_F_EC_POINT_CMP
	EC_F_EC_POINT_COPY
	EC_F_EC_POINT_DBL
	EC_F_EC_POINT_GET_AFFINE_COORDINATES_GF2M
	EC_F_EC_POINT_GET_AFFINE_COORDINATES_GFP
	EC_F_EC_POINT_GET_JPROJECTIVE_COORDINATES_GFP
	EC_F_EC_POINT_INVERT
	EC_F_EC_POINT_IS_AT_INFINITY
	EC_F_EC_POINT_IS_ON_CURVE
	EC_F_EC_POINT_MAKE_AFFINE
	EC_F_EC_POINT_MUL
	EC_F_EC_POINT_NEW
	EC_F_EC_POINT_OCT2POINT
	EC_F_EC_POINT_POINT2OCT
	EC_F_EC_POINT_SET_AFFINE_COORDINATES_GF2M
	EC_F_EC_POINT_SET_AFFINE_COORDINATES_GFP
	EC_F_EC_POINT_SET_COMPRESSED_COORDINATES_GF2M
	EC_F_EC_POINT_SET_COMPRESSED_COORDINATES_GFP
	EC_F_EC_POINT_SET_JPROJECTIVE_COORDINATES_GFP
	EC_F_EC_POINT_SET_TO_INFINITY
	EC_F_EC_PRE_COMP_DUP
	EC_F_EC_PRE_COMP_NEW
	EC_F_EC_WNAF_MUL
	EC_F_EC_WNAF_PRECOMPUTE_MULT
	EC_F_I2D_ECPARAMETERS
	EC_F_I2D_ECPKPARAMETERS
	EC_F_I2D_ECPRIVATEKEY
	EC_F_I2O_ECPUBLICKEY
	EC_F_O2I_ECPUBLICKEY
	EC_F_OLD_EC_PRIV_DECODE
	EC_F_PKEY_EC_CTRL
	EC_F_PKEY_EC_CTRL_STR
	EC_F_PKEY_EC_DERIVE
	EC_F_PKEY_EC_KEYGEN
	EC_F_PKEY_EC_PARAMGEN
	EC_F_PKEY_EC_SIGN
	EC_PKEY_NO_PARAMETERS
	EC_PKEY_NO_PUBKEY
	EC_R_ASN1_ERROR
	EC_R_ASN1_UNKNOWN_FIELD
	EC_R_BUFFER_TOO_SMALL
	EC_R_D2I_ECPKPARAMETERS_FAILURE
	EC_R_DECODE_ERROR
	EC_R_DISCRIMINANT_IS_ZERO
	EC_R_EC_GROUP_NEW_BY_NAME_FAILURE
	EC_R_FIELD_TOO_LARGE
	EC_R_GROUP2PKPARAMETERS_FAILURE
	EC_R_I2D_ECPKPARAMETERS_FAILURE
	EC_R_INCOMPATIBLE_OBJECTS
	EC_R_INVALID_ARGUMENT
	EC_R_INVALID_COMPRESSED_POINT
	EC_R_INVALID_COMPRESSION_BIT
	EC_R_INVALID_CURVE
	EC_R_INVALID_DIGEST_TYPE
	EC_R_INVALID_ENCODING
	EC_R_INVALID_FIELD
	EC_R_INVALID_FORM
	EC_R_INVALID_GROUP_ORDER
	EC_R_INVALID_PENTANOMIAL_BASIS
	EC_R_INVALID_PRIVATE_KEY
	EC_R_INVALID_TRINOMIAL_BASIS
	EC_R_KEYS_NOT_SET
	EC_R_MISSING_PARAMETERS
	EC_R_MISSING_PRIVATE_KEY
	EC_R_NOT_A_NIST_PRIME
	EC_R_NOT_A_SUPPORTED_NIST_PRIME
	EC_R_NOT_IMPLEMENTED
	EC_R_NOT_INITIALIZED
	EC_R_NO_FIELD_MOD
	EC_R_NO_PARAMETERS_SET
	EC_R_PASSED_NULL_PARAMETER
	EC_R_PKPARAMETERS2GROUP_FAILURE
	EC_R_POINT_AT_INFINITY
	EC_R_POINT_IS_NOT_ON_CURVE
	EC_R_SLOT_FULL
	EC_R_UNDEFINED_GENERATOR
	EC_R_UNDEFINED_ORDER
	EC_R_UNKNOWN_GROUP
	EC_R_UNKNOWN_ORDER
	EC_R_UNSUPPORTED_FIELD
	EC_R_WRONG_ORDER
	EVP_PKEY_CTRL_EC_PARAMGEN_CURVE_NID
	OPENSSL_ECC_MAX_FIELD_BITS
	OPENSSL_EC_NAMED_CURVE
	POINT_CONVERSION_COMPRESSED
	POINT_CONVERSION_HYBRID
	POINT_CONVERSION_UNCOMPRESSED
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	EC_F_COMPUTE_WNAF
	EC_F_D2I_ECPARAMETERS
	EC_F_D2I_ECPKPARAMETERS
	EC_F_D2I_ECPRIVATEKEY
	EC_F_DO_EC_KEY_PRINT
	EC_F_ECKEY_PARAM2TYPE
	EC_F_ECKEY_PARAM_DECODE
	EC_F_ECKEY_PRIV_DECODE
	EC_F_ECKEY_PRIV_ENCODE
	EC_F_ECKEY_PUB_DECODE
	EC_F_ECKEY_PUB_ENCODE
	EC_F_ECKEY_TYPE2PARAM
	EC_F_ECPARAMETERS_PRINT
	EC_F_ECPARAMETERS_PRINT_FP
	EC_F_ECPKPARAMETERS_PRINT
	EC_F_ECPKPARAMETERS_PRINT_FP
	EC_F_ECP_NIST_MOD_192
	EC_F_ECP_NIST_MOD_224
	EC_F_ECP_NIST_MOD_256
	EC_F_ECP_NIST_MOD_521
	EC_F_EC_ASN1_GROUP2CURVE
	EC_F_EC_ASN1_GROUP2FIELDID
	EC_F_EC_ASN1_GROUP2PARAMETERS
	EC_F_EC_ASN1_GROUP2PKPARAMETERS
	EC_F_EC_ASN1_PARAMETERS2GROUP
	EC_F_EC_ASN1_PKPARAMETERS2GROUP
	EC_F_EC_EX_DATA_SET_DATA
	EC_F_EC_GF2M_MONTGOMERY_POINT_MULTIPLY
	EC_F_EC_GF2M_SIMPLE_GROUP_CHECK_DISCRIMINANT
	EC_F_EC_GF2M_SIMPLE_GROUP_SET_CURVE
	EC_F_EC_GF2M_SIMPLE_OCT2POINT
	EC_F_EC_GF2M_SIMPLE_POINT2OCT
	EC_F_EC_GF2M_SIMPLE_POINT_GET_AFFINE_COORDINATES
	EC_F_EC_GF2M_SIMPLE_POINT_SET_AFFINE_COORDINATES
	EC_F_EC_GF2M_SIMPLE_SET_COMPRESSED_COORDINATES
	EC_F_EC_GFP_MONT_FIELD_DECODE
	EC_F_EC_GFP_MONT_FIELD_ENCODE
	EC_F_EC_GFP_MONT_FIELD_MUL
	EC_F_EC_GFP_MONT_FIELD_SET_TO_ONE
	EC_F_EC_GFP_MONT_FIELD_SQR
	EC_F_EC_GFP_MONT_GROUP_SET_CURVE
	EC_F_EC_GFP_MONT_GROUP_SET_CURVE_GFP
	EC_F_EC_GFP_NIST_FIELD_MUL
	EC_F_EC_GFP_NIST_FIELD_SQR
	EC_F_EC_GFP_NIST_GROUP_SET_CURVE
	EC_F_EC_GFP_SIMPLE_GROUP_CHECK_DISCRIMINANT
	EC_F_EC_GFP_SIMPLE_GROUP_SET_CURVE
	EC_F_EC_GFP_SIMPLE_GROUP_SET_CURVE_GFP
	EC_F_EC_GFP_SIMPLE_GROUP_SET_GENERATOR
	EC_F_EC_GFP_SIMPLE_MAKE_AFFINE
	EC_F_EC_GFP_SIMPLE_OCT2POINT
	EC_F_EC_GFP_SIMPLE_POINT2OCT
	EC_F_EC_GFP_SIMPLE_POINTS_MAKE_AFFINE
	EC_F_EC_GFP_SIMPLE_POINT_GET_AFFINE_COORDINATES
	EC_F_EC_GFP_SIMPLE_POINT_GET_AFFINE_COORDINATES_GFP
	EC_F_EC_GFP_SIMPLE_POINT_SET_AFFINE_COORDINATES
	EC_F_EC_GFP_SIMPLE_POINT_SET_AFFINE_COORDINATES_GFP
	EC_F_EC_GFP_SIMPLE_SET_COMPRESSED_COORDINATES
	EC_F_EC_GFP_SIMPLE_SET_COMPRESSED_COORDINATES_GFP
	EC_F_EC_GROUP_CHECK
	EC_F_EC_GROUP_CHECK_DISCRIMINANT
	EC_F_EC_GROUP_COPY
	EC_F_EC_GROUP_GET0_GENERATOR
	EC_F_EC_GROUP_GET_COFACTOR
	EC_F_EC_GROUP_GET_CURVE_GF2M
	EC_F_EC_GROUP_GET_CURVE_GFP
	EC_F_EC_GROUP_GET_DEGREE
	EC_F_EC_GROUP_GET_ORDER
	EC_F_EC_GROUP_GET_PENTANOMIAL_BASIS
	EC_F_EC_GROUP_GET_TRINOMIAL_BASIS
	EC_F_EC_GROUP_NEW
	EC_F_EC_GROUP_NEW_BY_CURVE_NAME
	EC_F_EC_GROUP_NEW_FROM_DATA
	EC_F_EC_GROUP_PRECOMPUTE_MULT
	EC_F_EC_GROUP_SET_CURVE_GF2M
	EC_F_EC_GROUP_SET_CURVE_GFP
	EC_F_EC_GROUP_SET_EXTRA_DATA
	EC_F_EC_GROUP_SET_GENERATOR
	EC_F_EC_KEY_CHECK_KEY
	EC_F_EC_KEY_COPY
	EC_F_EC_KEY_GENERATE_KEY
	EC_F_EC_KEY_NEW
	EC_F_EC_KEY_PRINT
	EC_F_EC_KEY_PRINT_FP
	EC_F_EC_POINTS_MAKE_AFFINE
	EC_F_EC_POINT_ADD
	EC_F_EC_POINT_CMP
	EC_F_EC_POINT_COPY
	EC_F_EC_POINT_DBL
	EC_F_EC_POINT_GET_AFFINE_COORDINATES_GF2M
	EC_F_EC_POINT_GET_AFFINE_COORDINATES_GFP
	EC_F_EC_POINT_GET_JPROJECTIVE_COORDINATES_GFP
	EC_F_EC_POINT_INVERT
	EC_F_EC_POINT_IS_AT_INFINITY
	EC_F_EC_POINT_IS_ON_CURVE
	EC_F_EC_POINT_MAKE_AFFINE
	EC_F_EC_POINT_MUL
	EC_F_EC_POINT_NEW
	EC_F_EC_POINT_OCT2POINT
	EC_F_EC_POINT_POINT2OCT
	EC_F_EC_POINT_SET_AFFINE_COORDINATES_GF2M
	EC_F_EC_POINT_SET_AFFINE_COORDINATES_GFP
	EC_F_EC_POINT_SET_COMPRESSED_COORDINATES_GF2M
	EC_F_EC_POINT_SET_COMPRESSED_COORDINATES_GFP
	EC_F_EC_POINT_SET_JPROJECTIVE_COORDINATES_GFP
	EC_F_EC_POINT_SET_TO_INFINITY
	EC_F_EC_PRE_COMP_DUP
	EC_F_EC_PRE_COMP_NEW
	EC_F_EC_WNAF_MUL
	EC_F_EC_WNAF_PRECOMPUTE_MULT
	EC_F_I2D_ECPARAMETERS
	EC_F_I2D_ECPKPARAMETERS
	EC_F_I2D_ECPRIVATEKEY
	EC_F_I2O_ECPUBLICKEY
	EC_F_O2I_ECPUBLICKEY
	EC_F_OLD_EC_PRIV_DECODE
	EC_F_PKEY_EC_CTRL
	EC_F_PKEY_EC_CTRL_STR
	EC_F_PKEY_EC_DERIVE
	EC_F_PKEY_EC_KEYGEN
	EC_F_PKEY_EC_PARAMGEN
	EC_F_PKEY_EC_SIGN
	EC_PKEY_NO_PARAMETERS
	EC_PKEY_NO_PUBKEY
	EC_R_ASN1_ERROR
	EC_R_ASN1_UNKNOWN_FIELD
	EC_R_BUFFER_TOO_SMALL
	EC_R_D2I_ECPKPARAMETERS_FAILURE
	EC_R_DECODE_ERROR
	EC_R_DISCRIMINANT_IS_ZERO
	EC_R_EC_GROUP_NEW_BY_NAME_FAILURE
	EC_R_FIELD_TOO_LARGE
	EC_R_GROUP2PKPARAMETERS_FAILURE
	EC_R_I2D_ECPKPARAMETERS_FAILURE
	EC_R_INCOMPATIBLE_OBJECTS
	EC_R_INVALID_ARGUMENT
	EC_R_INVALID_COMPRESSED_POINT
	EC_R_INVALID_COMPRESSION_BIT
	EC_R_INVALID_CURVE
	EC_R_INVALID_DIGEST_TYPE
	EC_R_INVALID_ENCODING
	EC_R_INVALID_FIELD
	EC_R_INVALID_FORM
	EC_R_INVALID_GROUP_ORDER
	EC_R_INVALID_PENTANOMIAL_BASIS
	EC_R_INVALID_PRIVATE_KEY
	EC_R_INVALID_TRINOMIAL_BASIS
	EC_R_KEYS_NOT_SET
	EC_R_MISSING_PARAMETERS
	EC_R_MISSING_PRIVATE_KEY
	EC_R_NOT_A_NIST_PRIME
	EC_R_NOT_A_SUPPORTED_NIST_PRIME
	EC_R_NOT_IMPLEMENTED
	EC_R_NOT_INITIALIZED
	EC_R_NO_FIELD_MOD
	EC_R_NO_PARAMETERS_SET
	EC_R_PASSED_NULL_PARAMETER
	EC_R_PKPARAMETERS2GROUP_FAILURE
	EC_R_POINT_AT_INFINITY
	EC_R_POINT_IS_NOT_ON_CURVE
	EC_R_SLOT_FULL
	EC_R_UNDEFINED_GENERATOR
	EC_R_UNDEFINED_ORDER
	EC_R_UNKNOWN_GROUP
	EC_R_UNKNOWN_ORDER
	EC_R_UNSUPPORTED_FIELD
	EC_R_WRONG_ORDER
	EVP_PKEY_CTRL_EC_PARAMGEN_CURVE_NID
	OPENSSL_ECC_MAX_FIELD_BITS
	OPENSSL_EC_NAMED_CURVE
	POINT_CONVERSION_COMPRESSED
	POINT_CONVERSION_HYBRID
	POINT_CONVERSION_UNCOMPRESSED
);

our $VERSION = '1.01';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&Crypt::OpenSSL::EC::constant not defined" if $constname eq 'constant';
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

require XSLoader;
XSLoader::load('Crypt::OpenSSL::EC', $VERSION);

# Preloaded methods go here.

sub print_errs {
    my ($msg) = @_;
    my ($count, $err, $errs, $e) = (0,0,'');
    while ($err = Crypt::OpenSSL::EC::ERR_get_error()) {
        $count ++;
	$e = "$msg $$: $count - " . Crypt::OpenSSL::EC::ERR_error_string($err) . "\n";
	$errs .= $e;
	warn $e if $Crypt::OpenSSL::EC::trace;
    }
    return $errs;
}

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__

=head1 NAME

Crypt::OpenSSL::EC - Perl extension for OpenSSL EC (Elliptic Curves) library

=head1 SYNOPSIS

   use Crypt::OpenSSL::EC;
   use Crypt::OpenSSL::Bignum::CTX;

   # Use of $ctx is optional in all calls, here we demonstrate its use.
   # If it is provided it will increase performance.
   my $ctx = Crypt::OpenSSL::Bignum::CTX->new();

   my $method = Crypt::OpenSSL::EC::EC_GFp_mont_method();
   my $group = Crypt::OpenSSL::EC::EC_GROUP::new($method);
   Crypt::OpenSSL::EC::EC_GROUP::set_curve_GFp($group, $p, $a, $b, $ctx);
   my $method = Crypt::OpenSSL::EC::EC_GROUP::method_of($group);
   Crypt::OpenSSL::EC::EC_GROUP::copy($tmp, $group);
   Crypt::OpenSSL::EC::EC_GROUP::get_curve_GFp($group, $p, $a, $b, $ctx);

   $Crypt::OpenSSL::EC::trace = 1;
   Crypt::OpenSSL::EC::print_errs();
   my $P = Crypt::OpenSSL::EC::EC_POINT::new($group);


   Crypt::OpenSSL::EC::EC_POINT_set_to_infinity($group, $P);
   my $bool = Crypt::OpenSSL::EC::EC_POINT::is_at_infinity($group, $P);

   my $buf = Crypt::OpenSSL::EC::EC_POINT::point2oct($group, $Q, &Crypt::OpenSSL::EC::POINT_CONVERSION_COMPRESSED, $ctx);
   Crypt::OpenSSL::EC::EC_POINT::oct2point($group, $P, $buf, $ctx);
   Crypt::OpenSSL::EC::EC_POINT::add($group, $P, $P, $Q, $ctx);

   Crypt::OpenSSL::EC::EC_POINT::set_compressed_coordinates_GFp($group, $Q, $x, 1, $ctx));
   my $bool = Crypt::OpenSSL::EC::EC_POINT::is_on_curve($group, $Q, $ctx));
   Crypt::OpenSSL::EC::EC_POINT::copy($R, $P);
   my $result = Crypt::OpenSSL::EC::EC_POINT::cmp($group, $P, $Q, $ctx);
   Crypt::OpenSSL::EC::EC_POINT::set_affine_coordinates_GFp($group, $P, $x, $y, $ctx);
   Crypt::OpenSSL::EC::EC_POINT::get_affine_coordinates_GFp($group, $P, $x, $y, $ctx);
   Crypt::OpenSSL::EC::EC_GROUP::set_generator($group, $P, $z, Crypt::OpenSSL::Bignum->one());
   my $degree = Crypt::OpenSSL::EC::EC_GROUP::get_degree($group)
   my $order = Crypt::OpenSSL::EC::EC_GROUP::get_order($group, $order, $ctx);
   Crypt::OpenSSL::EC::EC_POINT::mul($group, $Q, $order, $P, $n1, $ctx));
   Crypt::OpenSSL::EC::EC_POINT::free($P);
   Crypt::OpenSSL::EC::EC_GROUP::free($group);

=head1 DESCRIPTION

This module provides a standard (non-OO) interface to the OpenSSL EC (Elliptic Curve) library.
Some OO Calls are supported.

Most of the functions described in openssl/ec.h are supported.

It provides the Crypt::OpenSSL::EC class which defines some high level functions and constants.
At also provides 4 other classes for managing EC objects:

=over 4

=item Crypt::OpenSSL::EC::EC_GROUP

=item Crypt::OpenSSL::EC::EC_POINT

=item Crypt::OpenSSL::EC::EC_KEY

=item Crypt::OpenSSL::EC::EC_METHOD

=back

All objects created by these 4 classes are implemented as blessed Perl mortal
references.  This ensures they will be auto-destroyed when the Perl variable
becomes unreferenced. ASlo the approproae EC free function wil be called to
free the underlying EC object.

Further, it means that many of the functions below can be called using O-O
methods.  If a method's first argument is the same as the class the method is
in, then it can be called O-O style. For example the following 2 calls are
equivalent:

=over 4

=item my $newgroup = Crypt::OpenSSL::EC::EC_GROUP::dup($group);

=item my $newgroup = $group->dup();

=back

=over 4

=item Crypt::OpenSSL::EC::EC_GFp_simple_method();

Returns the basic GFp ec methods which provides the basis for the
optimized methods. 

=item Crypt::OpenSSL::EC::EC_GFp_mont_method();

Returns GFp methods using montgomery multiplication.

=item Crypt::OpenSSL::EC::EC_GFp_nist_method();

Returns GFp methods using optimized methods for NIST recommended curves

=item Crypt::OpenSSL::EC::EC_GF2m_simple_method();

Not available if OPENSSL_NO_EC2M is defined in OpenSSL.

Returns the basic GF2m ec method 

=item Crypt::OpenSSL::EC::EC_GROUP::new($method);

Creates a new EC_GROUP object
$method is the method to use

=item Crypt::OpenSSL::EC::EC_GROUP::set_curve_GFp($group, $p, $a, $b, $ctx);

Sets the parameter of a ec over GFp defined by y^2 = x^3 + a*x + b
  group  EC_GROUP object
  p      BIGNUM with the prime number
  a      BIGNUM with parameter a of the equation
  b      BIGNUM with parameter b of the equation
  ctx    BN_CTX object (optional)
 return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_GROUP::method_of($group);

Returns the EC_METHOD of the EC_GROUP object.

=item Crypt::OpenSSL::EC::EC_METHOD::get_field_type($method)

Returns the field type of the EC_METHOD.

=item Crypt::OpenSSL::EC::EC_GROUP::copy($dst, $src);

Copies EC_GROUP objects. Note: both EC_GROUPs must use the same EC_METHOD.
return newly created EC_GROUP object or NULL in case of an error.

=item Crypt::OpenSSL::EC::EC_GROUP::dup($src);

Creates a new EC_GROUP object and copies the copies the content
form src to the newly created EC_GROUP object.
return newly created EC_GROUP object or NULL in case of an error.

=item Crypt::OpenSSL::EC::EC_GROUP::get_curve_GFp($group, $p, $a, $b, $ctx);

Gets the parameter of the ec over GFp defined by y^2 = x^3 + a*x + b
  group  EC_GROUP object
  p      BIGNUM for the prime number
  a      BIGNUM for parameter a of the equation
  b      BIGNUM for parameter b of the equation
  ctx    BN_CTX object (optional)
 return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_GROUP::set_curve_GF2m($group, $p, $a, $b, $ctx);

Not available if OPENSSL_NO_EC2M is defined in OpenSSL.

    
Sets the parameter of a ec over GF2m defined by y^2 + x*y = x^3 + a*x^2 + b
  group  EC_GROUP object
  p      BIGNUM with the polynomial defining the underlying field
  a      BIGNUM with parameter a of the equation
  b      BIGNUM with parameter b of the equation
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_GROUP::get_curve_GF2m($group, $p, $a, $b, $ctx);

Not available if OPENSSL_NO_EC2M is defined in OpenSSL.

Gets the parameter of the ec over GF2m defined by y^2 + x*y = x^3 + a*x^2 + b
  group  EC_GROUP object
  p      BIGNUM for the polynomial defining the underlying field
  a      BIGNUM for parameter a of the equation
  b      BIGNUM for parameter b of the equation
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured


=item Crypt::OpenSSL::EC::print_errs();

=item Crypt::OpenSSL::EC::EC_POINT::new($group);

Creates a new EC_POINT object for the specified EC_GROUP
  group  EC_GROUP the underlying EC_GROUP object
  return newly created EC_POINT object or NULL if an error occurred

=item Crypt::OpenSSL::EC::EC_POINT::free($point);

Frees a EC_POINT object
  point  EC_POINT object to be freed
This should normally not be called from Perl, since EC_POINT objects created by this 
library are auto-destroyed when they become unreferenced.

=item Crypt::OpenSSL::EC::EC_POINT::clear_free($point);

Clears and frees a EC_POINT object
  point  EC_POINT object to be cleared and freed
This should normally not be called from Perl, since EC_POINT objects created by this 
library are auto-destroyed when they become unreferenced.


=item Crypt::OpenSSL::EC::EC_POINT::copy($dst, $src);

Copies EC_POINT object
  dst  destination EC_POINT object
  src  source EC_POINT object
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_POINT::dup($src, $group);

Creates a new EC_POINT object and copies the content of the supplied
EC_POINT
  src    source EC_POINT object
  group  underlying the EC_GROUP object
  return newly created EC_POINT object or NULL if an error occurred 

=item Crypt::OpenSSL::EC::EC_POINT::set_to_infinity($group, $point);

Sets a point to infinity (neutral element)
  group  underlying EC_GROUP object
  point  EC_POINT to set to infinity
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_POINT::get_Jprojective_coordinates_GFp($group, $p, $x, $y, $z, $ctx);

Gets the jacobian projective coordinates of a EC_POINT over GFp
  group  underlying EC_GROUP object
  p      EC_POINT object
  x      BIGNUM for the x-coordinate
  y      BIGNUM for the y-coordinate
  z      BIGNUM for the z-coordinate
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_POINT::set_affine_coordinates_GFp($group, $p, $x, $y, $ctx);

Sets the affine coordinates of a EC_POINT over GFp
  group  underlying EC_GROUP object
  p      EC_POINT object
  x      BIGNUM with the x-coordinate
  y      BIGNUM with the y-coordinate
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_POINT::get_affine_coordinates_GFp($group, $p, $x, $y, $ctx);

Gets the affine coordinates of a EC_POINT over GFp
  group  underlying EC_GROUP object
  p      EC_POINT object
  x      BIGNUM for the x-coordinate
  y      BIGNUM for the y-coordinate
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_POINT::set_compressed_coordinates_GFp($group, $p, $x, $y_bit, $ctx);

Sets the x9.62 compressed coordinates of a EC_POINT over GFp
  group  underlying EC_GROUP object
  p      EC_POINT object
  x      BIGNUM with x-coordinate
  y_bit  integer with the y-Bit (either 0 or 1)
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_POINT::set_affine_coordinates_GF2m($group, $p, $x, $y, $ctx);

Not available if OPENSSL_NO_EC2M is defined in OpenSSL.

Sets the affine coordinates of a EC_POINT over GF2m
  group  underlying EC_GROUP object
  p      EC_POINT object
  x      BIGNUM with the x-coordinate
  y      BIGNUM with the y-coordinate
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_POINT::get_affine_coordinates_GF2m($group, $p, $x, $y, $ctx);

Not available if OPENSSL_NO_EC2M is defined in OpenSSL.

Gets the affine coordinates of a EC_POINT over GF2m
  group  underlying EC_GROUP object
  p      EC_POINT object
  x      BIGNUM for the x-coordinate
  y      BIGNUM for the y-coordinate
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_POINT::set_compressed_coordinates_GF2m($group, $p, $x, $y_bit, $ctx);

Not available if OPENSSL_NO_EC2M is defined in OpenSSL.

Sets the x9.62 compressed coordinates of a EC_POINT over GF2m
  group  underlying EC_GROUP object
  p      EC_POINT object
  x      BIGNUM with x-coordinate
  y_bit  integer with the y-Bit (either 0 or 1)
  ctx    BN_CTX object (optional)
  \return 1 on success and 0 if an error occured


=item Crypt::OpenSSL::EC::EC_POINT::is_at_infinity($group, $p);

Checks whether the point is the neutral element of the group
  group  the underlying EC_GROUP object
  p      EC_POINT object
  return 1 if the point is the neutral element and 0 otherwise

=item Crypt::OpenSSL::EC::EC_POINT::point2oct($group, $p, $form, $ctx);

Encodes a EC_POINT object to a octet string
  group  underlying EC_GROUP object
  p      EC_POINT object
  form   point conversion form
  ctx    BN_CTX object (optional)
  return the encoded EC point

=item Crypt::OpenSSL::EC::EC_POINT::oct2point($group, $p, $buf, $ctx);

Decodes a EC_POINT from a octet string
  group  underlying EC_GROUP object
  p      EC_POINT object
  buf    buffer with the encoded ec point
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_POINT::point2bn($group, $p, $form, $bn, $ctx);

=item Crypt::OpenSSL::EC::EC_POINT::bn2point($group, $bn, $p, $ctx);

=item Crypt::OpenSSL::EC::EC_POINT::point2hex($group, $p, $form, $bn, $ctx);

=item Crypt::OpenSSL::EC::EC_POINT::hex2point($group, $bn, $p, $ctx);


=item Crypt::OpenSSL::EC::EC_POINT::add($group, $r, $a, $b, $ctx);

 Computes the sum of two EC_POINT 
  group  underlying EC_GROUP object
  r      EC_POINT object for the result (r = a + b)
  a      EC_POINT object with the first summand
  b      EC_POINT object with the second summand
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_POINT::dbl($group, $r, $a, $ctx);

Computes the double of a EC_POINT
  group  underlying EC_GROUP object
  r      EC_POINT object for the result (r = 2 * a)
  a      EC_POINT object 
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_POINT::invert($group, $a, $ctx);

Computes the inverse of a EC_POINT
  group  underlying EC_GROUP object
  a      EC_POINT object to be inverted (it's used for the result as well)
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_POINT::is_on_curve($group, $point, $ctx));

Checks whether the point is on the curve 
  group  underlying EC_GROUP object
  point  EC_POINT object to check
  ctx    BN_CTX object (optional)
  return 1 if point if on the curve and 0 otherwise

=item Crypt::OpenSSL::EC::EC_POINT::cmp($group, $a, $b, $ctx);

Compares two EC_POINTs 
  group  underlying EC_GROUP object
  a      first EC_POINT object
  b      second EC_POINT object
  ctx    BN_CTX object (optional)
  return 0 if both points are equal and a value != 0 otherwise

=item Crypt::OpenSSL::EC::EC_POINT::make_affine($group, $point, $ct);

=item Crypt::OpenSSL::EC::EC_POINTs::make_affine

Not Implemented

=item Crypt::OpenSSL::EC::EC_POINTs::mul

Not Implemented

=item    Crypt::OpenSSL::EC::EC_GROUP::set_generator($group, $generator, $order, $cofactor);

Sets the generator and it's order/cofactor of a EC_GROUP object.
  group      EC_GROUP object 
  generator  EC_POINT object with the generator.
  order      the order of the group generated by the generator.
  cofactor   the index of the sub-group generated by the generator
           in the group of all points on the elliptic curve.
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_GROUP::get0_generator($group);

Returns the generator of a EC_GROUP object.

  group  EC_GROUP object

return the currently used generator (possibly NULL).

=item Crypt::OpenSSL::EC::EC_GROUP::get_degree($group)

Returns the number of bits needed to represent a field element 
  group  EC_GROUP object
  return number of bits needed to represent a field element

=item Crypt::OpenSSL::EC::EC_GROUP::check($group, $ctx);

Checks whether the parameter in the EC_GROUP define a valid ec group
  group  EC_GROUP object
  ctx    BN_CTX object (optional)
  return 1 if group is a valid ec group and 0 otherwise

=item  Crypt::OpenSSL::EC::EC_GROUP::check_discriminant($group, $ctx);

Checks whether the discriminant of the elliptic curve is zero or not
  group  EC_GROUP object
  ctx    BN_CTX object (optional)
  return 1 if the discriminant is not zero and 0 otherwise

=item  Crypt::OpenSSL::EC:: EC_GROUP::cmp($a, $b, $ctx);

Compares two EC_GROUP objects
  a    first EC_GROUP object
  b    second EC_GROUP object
  ctx  BN_CTX object (optional)
  return 0 if both groups are equal and 1 otherwise

=item Crypt::OpenSSL::EC::EC::EC_GROUP::new_curve_GFp($p, $a, $b, $ctx);

Creates a new EC_GROUP object with the specified parameters defined
over GFp (defined by the equation y^2 = x^3 + a*x + b)
  p    BIGNUM with the prime number
  a    BIGNUM with the parameter a of the equation
  b    BIGNUM with the parameter b of the equation
  ctx  BN_CTX object (optional)
  return newly created EC_GROUP object with the specified parameters

=item Crypt::OpenSSL::EC::EC_GROUP::new_curve_GF2m($p, $a, $b, $ctx);

Not available if OPENSSL_NO_EC2M is defined in OpenSSL.

Creates a new EC_GROUP object with the specified parameters defined
over GF2m (defined by the equation y^2 + x*y = x^3 + a*x^2 + b)
  p    BIGNUM with the polynomial defining the underlying field
  a    BIGNUM with the parameter a of the equation
  b    BIGNUM with the parameter b of the equation
  ctx  BN_CTX object (optional)
  return newly created EC_GROUP object with the specified parameters

=item Crypt::OpenSSL::EC::EC_GROUP::new_by_curve_name($nid);

Creates a EC_GROUP object with a curve specified by a NID
  nid  NID of the OID of the curve name
  return newly created EC_GROUP object with specified curve or NULL
           if an error occurred

=item Crypt::OpenSSL::EC::EC_get_builtin_curves($r, $nitems);

EC_builtin_curves(EC_builtin_curve *r, size_t size) returns number 
of all available curves or zero if a error occurred. 
In case r ist not zero nitems EC_builtin_curve structures 
are filled with the data of the first nitems internal groups


=item Crypt::OpenSSL::EC::EC_GROUP::get_order($group, $order, $ctx);

Gets the order of a EC_GROUP

  group  EC_GROUP object
  order  BIGNUM to which the order is copied
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_GROUP::get_cofactor($group, $cofactopr, $ctx)

Gets the cofactor of a EC_GROUP

  group     EC_GROUP object
  cofactor  BIGNUM to which the cofactor is copied
  ctx       BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item Crypt::OpenSSL::EC::EC_GROUP::set_curve_name($group, $nid);

Sets the name of a EC_GROUP object
  group  EC_GROUP object
  nid    NID of the curve name OID

=item Crypt::OpenSSL::EC::EC_GROUP::get_curve_name($group);

Returns the curve name of a EC_GROUP object
  group  EC_GROUP object
  return NID of the curve name OID or 0 if not set.

=item Crypt::OpenSSL::EC::EC_GROUP::set_asn1_flag($group, $flag);

Sets the ASN flag for the group

=item Crypt::OpenSSL::EC::EC_GROUP::get_asn1_flag($group);

Returns the ASN flag for the group

=item    Crypt::OpenSSL::EC::EC_GROUP::set_point_conversion_form($group, $form);

Sets the point conversion form.

=item    Crypt::OpenSSL::EC::EC_GROUP::get_point_conversion_form($group);

Retuns the point conversion for for the group

=item    Crypt::OpenSSL::EC::EC_GROUP::get0_seed($group);

Returns the 0 seed

=item    Crypt::OpenSSL::EC::EC_GROUP::get_seed_len($group);

Returns the seed length

=item    Crypt::OpenSSL::EC::EC_GROUP::set_seed($group, $seed);

Sets the group seed

=item    Crypt::OpenSSL::EC::EC_POINT::mul($group, $r, $n, $q, $m, $ctx));

Computes r = generator * n + q * m
  group  underlying EC_GROUP object
  r      EC_POINT object for the result
  n      BIGNUM with the multiplier for the group generator (optional)
  q      EC_POINT object with the first factor of the second summand
  m      BIGNUM with the second factor of the second summand
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item    Crypt::OpenSSL::EC::EC_GROUP::precompute_mult($group, $ctx);

Stores multiples of generator for faster point multiplication
  group  EC_GROUP object
  ctx    BN_CTX object (optional)
  return 1 on success and 0 if an error occured

=item    Crypt::OpenSSL::EC::EC_GROUP::have_precompute_mult($group);

Reports whether a precomputation has been done
  group  EC_GROUP object
  return 1 if a pre-computation has been done and 0 otherwise

=item    Crypt::OpenSSL::EC::EC_GROUP::get_basis_type($group);

EC_GROUP_get_basis_type() returns the NID of the basis type
used to represent the field elements 

=item    Crypt::OpenSSL::EC::EC_GROUP::get_trinomial_basis($group, $k);

Not available if OPENSSL_NO_EC2M is defined in OpenSSL.

=item    Crypt::OpenSSL::EC:: EC_GROUP::get_pentanomial_basis($group, $k1, $k2, $k3);

Not available if OPENSSL_NO_EC2M is defined in OpenSSL.

=item    Crypt::OpenSSL::EC::EC_GROUP::free($group);

Frees a EC_GROUP object.
This should normally not be called from Perl, since EC_GROUP objects created by this 
library are auto-destroyed when they become unreferenced.

=item    Crypt::OpenSSL::EC::EC_GROUP::clear_free($group);

Clears and frees a EC_GROUP object
This should normally not be called from Perl, since EC_GROUP objects created by this 
library are auto-destroyed when they become unreferenced.

=item Crypt::OpenSSL::EC::EC_KEY::new();
Creates a new EC_KEY object.
 return EC_KEY object or NULL if an error occurred.

=item Crypt::OpenSSL::EC::EC_KEY::new_by_curve_name($nid);

Creates a new EC_KEY object using a named curve as underlying
EC_GROUP object.
  nid  NID of the named curve.
  return EC_KEY object or NULL if an error occurred. 

=item Crypt::OpenSSL::EC::EC_KEY::free($key);

Frees a EC_KEY object.
  key  EC_KEY object to be freed.
This should normally not be called from Perl, since EC_KEY objects created by this 
library are auto-destroyed when they become unreferenced.

=item Crypt::OpenSSL::EC::EC_KEY::copy($dst, $src);

Copies a EC_KEY object.
  dst  destination EC_KEY object
  src  src EC_KEY object
  return dst or NULL if an error occurred.

=item Crypt::OpenSSL::EC::EC_KEY::dup($src);

Creates a new EC_KEY object and copies the content from src to it.
  src  the source EC_KEY object
  return newly created EC_KEY object or NULL if an error occurred.

=item Crypt::OpenSSL::EC::EC_KEY::up_ref($key);

Increases the internal reference count of a EC_KEY object.
  key  EC_KEY object
  return 1 on success and 0 if an error occurred.

=item Crypt::OpenSSL::EC::EC_KEY::get0_group($key);

Returns the EC_GROUP object of a EC_KEY object
  key  EC_KEY object
  \return the EC_GROUP object (possibly NULL).

=item Crypt::OpenSSL::EC::EC_KEY::set_group($key, $group);

Sets the EC_GROUP of a EC_KEY object.
  key    EC_KEY object
  group  EC_GROUP to use in the EC_KEY object (note: the EC_KEY
         object will use an own copy of the EC_GROUP).
  return 1 on success and 0 if an error occurred.

=item Crypt::OpenSSL::EC::EC_KEY::set_private_key($key, $prv);

Sets the private key of a EC_KEY object.
  key  EC_KEY object
  prv  BIGNUM with the private key (note: the EC_KEY object
       will use an own copy of the BIGNUM).
  return 1 on success and 0 if an error occurred.

=item Crypt::OpenSSL::EC::EC_KEY::get0_public_key($key);

Returns the public key of a EC_KEY object.
  key  the EC_KEY object
  return a EC_POINT object with the public key (possibly NULL)

=item Crypt::OpenSSL::EC::EC_KEY::set_public_key($key, $pub);

Sets the public key of a EC_KEY object.
  key  EC_KEY object
  pub  EC_POINT object with the public key (note: the EC_KEY object
       will use an own copy of the EC_POINT object).
  return 1 on success and 0 if an error occurred.

=item Crypt::OpenSSL::EC::EC_KEY::get_enc_flags($key);

=item Crypt::OpenSSL::EC::EC_KEY::set_enc_flags($key, $flags);

=item Crypt::OpenSSL::EC::EC_KEY::get_conv_form($key)

=item Crypt::OpenSSL::EC::EC_KEY::set_conv_form($key, $form);

=item Crypt::OpenSSL::EC::EC_KEY::get_key_method_data

Not Implemented

=item Crypt::OpenSSL::EC::EC_KEY::insert_key_method_data

Not Implemented

=item Crypt::OpenSSL::EC::EC_KEY::set_asn1_flag($key, $flag);


=item Crypt::OpenSSL::EC::EC_KEY::precompute_mult($key, $ctx);

Creates a table of pre-computed multiples of the generator to 
further EC_KEY operations.
  key  EC_KEY object
  ctx  BN_CTX object (optional)
  return 1 on success and 0 if an error occurred.

=item Crypt::OpenSSL::EC::EC_KEY::generate_key($key);

Creates a new ec private (and optional a new public) key.
  key  EC_KEY object
  return 1 on success and 0 if an error occurred.

=item Crypt::OpenSSL::EC::EC_KEY::check_key($key);

Verifies that a private and/or public key is valid.
  key  the EC_KEY object
  return 1 on success and 0 otherwise.

=back

=head2 EXPORT

None by default.

=head2 Exportable constants

  EC_F_COMPUTE_WNAF
  EC_F_D2I_ECPARAMETERS
  EC_F_D2I_ECPKPARAMETERS
  EC_F_D2I_ECPRIVATEKEY
  EC_F_DO_EC_KEY_PRINT
  EC_F_ECKEY_PARAM2TYPE
  EC_F_ECKEY_PARAM_DECODE
  EC_F_ECKEY_PRIV_DECODE
  EC_F_ECKEY_PRIV_ENCODE
  EC_F_ECKEY_PUB_DECODE
  EC_F_ECKEY_PUB_ENCODE
  EC_F_ECKEY_TYPE2PARAM
  EC_F_ECPARAMETERS_PRINT
  EC_F_ECPARAMETERS_PRINT_FP
  EC_F_ECPKPARAMETERS_PRINT
  EC_F_ECPKPARAMETERS_PRINT_FP
  EC_F_ECP_NIST_MOD_192
  EC_F_ECP_NIST_MOD_224
  EC_F_ECP_NIST_MOD_256
  EC_F_ECP_NIST_MOD_521
  EC_F_EC_ASN1_GROUP2CURVE
  EC_F_EC_ASN1_GROUP2FIELDID
  EC_F_EC_ASN1_GROUP2PARAMETERS
  EC_F_EC_ASN1_GROUP2PKPARAMETERS
  EC_F_EC_ASN1_PARAMETERS2GROUP
  EC_F_EC_ASN1_PKPARAMETERS2GROUP
  EC_F_EC_EX_DATA_SET_DATA
  EC_F_EC_GF2M_MONTGOMERY_POINT_MULTIPLY
  EC_F_EC_GF2M_SIMPLE_GROUP_CHECK_DISCRIMINANT
  EC_F_EC_GF2M_SIMPLE_GROUP_SET_CURVE
  EC_F_EC_GF2M_SIMPLE_OCT2POINT
  EC_F_EC_GF2M_SIMPLE_POINT2OCT
  EC_F_EC_GF2M_SIMPLE_POINT_GET_AFFINE_COORDINATES
  EC_F_EC_GF2M_SIMPLE_POINT_SET_AFFINE_COORDINATES
  EC_F_EC_GF2M_SIMPLE_SET_COMPRESSED_COORDINATES
  EC_F_EC_GFP_MONT_FIELD_DECODE
  EC_F_EC_GFP_MONT_FIELD_ENCODE
  EC_F_EC_GFP_MONT_FIELD_MUL
  EC_F_EC_GFP_MONT_FIELD_SET_TO_ONE
  EC_F_EC_GFP_MONT_FIELD_SQR
  EC_F_EC_GFP_MONT_GROUP_SET_CURVE
  EC_F_EC_GFP_MONT_GROUP_SET_CURVE_GFP
  EC_F_EC_GFP_NIST_FIELD_MUL
  EC_F_EC_GFP_NIST_FIELD_SQR
  EC_F_EC_GFP_NIST_GROUP_SET_CURVE
  EC_F_EC_GFP_SIMPLE_GROUP_CHECK_DISCRIMINANT
  EC_F_EC_GFP_SIMPLE_GROUP_SET_CURVE
  EC_F_EC_GFP_SIMPLE_GROUP_SET_CURVE_GFP
  EC_F_EC_GFP_SIMPLE_GROUP_SET_GENERATOR
  EC_F_EC_GFP_SIMPLE_MAKE_AFFINE
  EC_F_EC_GFP_SIMPLE_OCT2POINT
  EC_F_EC_GFP_SIMPLE_POINT2OCT
  EC_F_EC_GFP_SIMPLE_POINTS_MAKE_AFFINE
  EC_F_EC_GFP_SIMPLE_POINT_GET_AFFINE_COORDINATES
  EC_F_EC_GFP_SIMPLE_POINT_GET_AFFINE_COORDINATES_GFP
  EC_F_EC_GFP_SIMPLE_POINT_SET_AFFINE_COORDINATES
  EC_F_EC_GFP_SIMPLE_POINT_SET_AFFINE_COORDINATES_GFP
  EC_F_EC_GFP_SIMPLE_SET_COMPRESSED_COORDINATES
  EC_F_EC_GFP_SIMPLE_SET_COMPRESSED_COORDINATES_GFP
  EC_F_EC_GROUP_CHECK
  EC_F_EC_GROUP_CHECK_DISCRIMINANT
  EC_F_EC_GROUP_COPY
  EC_F_EC_GROUP_GET0_GENERATOR
  EC_F_EC_GROUP_GET_COFACTOR
  EC_F_EC_GROUP_GET_CURVE_GF2M
  EC_F_EC_GROUP_GET_CURVE_GFP
  EC_F_EC_GROUP_GET_DEGREE
  EC_F_EC_GROUP_GET_ORDER
  EC_F_EC_GROUP_GET_PENTANOMIAL_BASIS
  EC_F_EC_GROUP_GET_TRINOMIAL_BASIS
  EC_F_EC_GROUP_NEW
  EC_F_EC_GROUP_NEW_BY_CURVE_NAME
  EC_F_EC_GROUP_NEW_FROM_DATA
  EC_F_EC_GROUP_PRECOMPUTE_MULT
  EC_F_EC_GROUP_SET_CURVE_GF2M
  EC_F_EC_GROUP_SET_CURVE_GFP
  EC_F_EC_GROUP_SET_EXTRA_DATA
  EC_F_EC_GROUP_SET_GENERATOR
  EC_F_EC_KEY_CHECK_KEY
  EC_F_EC_KEY_COPY
  EC_F_EC_KEY_GENERATE_KEY
  EC_F_EC_KEY_NEW
  EC_F_EC_KEY_PRINT
  EC_F_EC_KEY_PRINT_FP
  EC_F_EC_POINTS_MAKE_AFFINE
  EC_F_EC_POINT_ADD
  EC_F_EC_POINT_CMP
  EC_F_EC_POINT_COPY
  EC_F_EC_POINT_DBL
  EC_F_EC_POINT_GET_AFFINE_COORDINATES_GF2Mg
  EC_F_EC_POINT_GET_AFFINE_COORDINATES_GFP
  EC_F_EC_POINT_GET_JPROJECTIVE_COORDINATES_GFP
  EC_F_EC_POINT_INVERT
  EC_F_EC_POINT_IS_AT_INFINITY
  EC_F_EC_POINT_IS_ON_CURVE
  EC_F_EC_POINT_MAKE_AFFINE
  EC_F_EC_POINT_MUL
  EC_F_EC_POINT_NEW
  EC_F_EC_POINT_OCT2POINT
  EC_F_EC_POINT_POINT2OCT
  EC_F_EC_POINT_SET_AFFINE_COORDINATES_GF2M
  EC_F_EC_POINT_SET_AFFINE_COORDINATES_GFP
  EC_F_EC_POINT_SET_COMPRESSED_COORDINATES_GF2M
  EC_F_EC_POINT_SET_COMPRESSED_COORDINATES_GFP
  EC_F_EC_POINT_SET_JPROJECTIVE_COORDINATES_GFP
  EC_F_EC_POINT_SET_TO_INFINITY
  EC_F_EC_PRE_COMP_DUP
  EC_F_EC_PRE_COMP_NEW
  EC_F_EC_WNAF_MUL
  EC_F_EC_WNAF_PRECOMPUTE_MULT
  EC_F_I2D_ECPARAMETERS
  EC_F_I2D_ECPKPARAMETERS
  EC_F_I2D_ECPRIVATEKEY
  EC_F_I2O_ECPUBLICKEY
  EC_F_O2I_ECPUBLICKEY
  EC_F_OLD_EC_PRIV_DECODE
  EC_F_PKEY_EC_CTRL
  EC_F_PKEY_EC_CTRL_STR
  EC_F_PKEY_EC_DERIVE
  EC_F_PKEY_EC_KEYGEN
  EC_F_PKEY_EC_PARAMGEN
  EC_F_PKEY_EC_SIGN
  EC_PKEY_NO_PARAMETERS
  EC_PKEY_NO_PUBKEY
  EC_R_ASN1_ERROR
  EC_R_ASN1_UNKNOWN_FIELD
  EC_R_BUFFER_TOO_SMALL
  EC_R_D2I_ECPKPARAMETERS_FAILURE
  EC_R_DECODE_ERROR
  EC_R_DISCRIMINANT_IS_ZERO
  EC_R_EC_GROUP_NEW_BY_NAME_FAILURE
  EC_R_FIELD_TOO_LARGE
  EC_R_GROUP2PKPARAMETERS_FAILURE
  EC_R_I2D_ECPKPARAMETERS_FAILURE
  EC_R_INCOMPATIBLE_OBJECTS
  EC_R_INVALID_ARGUMENT
  EC_R_INVALID_COMPRESSED_POINT
  EC_R_INVALID_COMPRESSION_BIT
  EC_R_INVALID_CURVE
  EC_R_INVALID_DIGEST_TYPE
  EC_R_INVALID_ENCODING
  EC_R_INVALID_FIELD
  EC_R_INVALID_FORM
  EC_R_INVALID_GROUP_ORDER
  EC_R_INVALID_PENTANOMIAL_BASIS
  EC_R_INVALID_PRIVATE_KEY
  EC_R_INVALID_TRINOMIAL_BASIS
  EC_R_KEYS_NOT_SET
  EC_R_MISSING_PARAMETERS
  EC_R_MISSING_PRIVATE_KEY
  EC_R_NOT_A_NIST_PRIME
  EC_R_NOT_A_SUPPORTED_NIST_PRIME
  EC_R_NOT_IMPLEMENTED
  EC_R_NOT_INITIALIZED
  EC_R_NO_FIELD_MOD
  EC_R_NO_PARAMETERS_SET
  EC_R_PASSED_NULL_PARAMETER
  EC_R_PKPARAMETERS2GROUP_FAILURE
  EC_R_POINT_AT_INFINITY
  EC_R_POINT_IS_NOT_ON_CURVE
  EC_R_SLOT_FULL
  EC_R_UNDEFINED_GENERATOR
  EC_R_UNDEFINED_ORDER
  EC_R_UNKNOWN_GROUP
  EC_R_UNKNOWN_ORDER
  EC_R_UNSUPPORTED_FIELD
  EC_R_WRONG_ORDER
  EVP_PKEY_CTRL_EC_PARAMGEN_CURVE_NID
  OPENSSL_ECC_MAX_FIELD_BITS
  OPENSSL_EC_NAMED_CURVE
  POINT_CONVERSION_COMPRESSED
  POINT_CONVERSION_HYBRID
  POINT_CONVERSION_UNCOMPRESSED



=head1 SEE ALSO

Crypt::OpenSSL::Bignum

OpenSSL

=head1 AUTHOR

Mike McCauley, E<lt>mikem@airspayce.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2012 by Mike McCauley

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.


=cut

