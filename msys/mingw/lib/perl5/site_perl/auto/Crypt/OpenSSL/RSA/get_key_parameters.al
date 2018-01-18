# NOTE: Derived from blib\lib\Crypt\OpenSSL\RSA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package Crypt::OpenSSL::RSA;

#line 295 "blib\lib\Crypt\OpenSSL\RSA.pm (autosplit into blib\lib\auto\Crypt\OpenSSL\RSA\get_key_parameters.al)"
sub get_key_parameters
{
    return map { $_ ? Crypt::OpenSSL::Bignum->bless_pointer($_) : undef }
        shift->_get_key_parameters();
}

1;
# end of Crypt::OpenSSL::RSA::get_key_parameters
