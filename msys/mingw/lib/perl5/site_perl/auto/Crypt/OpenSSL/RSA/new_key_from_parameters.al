# NOTE: Derived from blib\lib\Crypt\OpenSSL\RSA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package Crypt::OpenSSL::RSA;

#line 127 "blib\lib\Crypt\OpenSSL\RSA.pm (autosplit into blib\lib\auto\Crypt\OpenSSL\RSA\new_key_from_parameters.al)"
sub new_key_from_parameters
{
    my($proto, $n, $e, $d, $p, $q) = @_;
    return $proto->_new_key_from_parameters
        (map { $_ ? $_->pointer_copy() : 0 } $n, $e, $d, $p, $q);
}

# end of Crypt::OpenSSL::RSA::new_key_from_parameters
1;
