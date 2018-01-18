# NOTE: Derived from blib\lib\Crypt\OpenSSL\RSA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package Crypt::OpenSSL::RSA;

#line 82 "blib\lib\Crypt\OpenSSL\RSA.pm (autosplit into blib\lib\auto\Crypt\OpenSSL\RSA\new_public_key.al)"
sub new_public_key
{
    my ($proto, $p_key_string) = @_;
    if ($p_key_string =~ /^-----BEGIN RSA PUBLIC KEY-----/)
    {
        return $proto->_new_public_key_pkcs1($p_key_string);
    }
    elsif ($p_key_string =~ /^-----BEGIN PUBLIC KEY-----/)
    {
        return $proto->_new_public_key_x509($p_key_string);
    }
    else
    {
        croak "unrecognized key format";
    }
}

# end of Crypt::OpenSSL::RSA::new_public_key
1;
