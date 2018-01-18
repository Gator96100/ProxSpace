# NOTE: Derived from blib\lib\Crypt\OpenSSL\RSA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package Crypt::OpenSSL::RSA;

#line 142 "blib\lib\Crypt\OpenSSL\RSA.pm (autosplit into blib\lib\auto\Crypt\OpenSSL\RSA\import_random_seed.al)"
sub import_random_seed
{
    until (_random_status())
    {
        _random_seed(Crypt::OpenSSL::Random::random_bytes(20));
    }
}

# end of Crypt::OpenSSL::RSA::import_random_seed
1;
