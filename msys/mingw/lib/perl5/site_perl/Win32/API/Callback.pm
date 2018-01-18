# See the bottom of this file for the POD documentation.  Search for the
# string '=head'.

#######################################################################
#
# Win32::API::Callback - Perl Win32 API Import Facility
#
# Author: Aldo Calpini <dada@perl.it>
# Author: Daniel Dragan <bulkdd@cpan.org>
# Maintainer: Cosimo Streppone <cosimo@cpan.org>
#
#######################################################################

package Win32::API::Callback;
use strict;
use warnings;
use vars qw( $VERSION $Stage2FuncPtrPkd );

$VERSION = '0.84';

#require XSLoader;    # to dynuhlode the module. #already loaded by Win32::API
#use Data::Dumper;

use Win32::API qw ( WriteMemory ) ;

BEGIN {
    #there is supposed to be 64 bit IVs on 32 bit perl compatibility here
    #but it is untested
    *IVSIZE = *Win32::API::IVSIZE;
    #what kind of stack processing/calling convention/machine code we needed
    eval "sub ISX64 () { ".(Win32::API::PTRSIZE() == 8 ?  1 : 0)." }";
    eval 'sub OPV () {'.$].'}';
    sub OPV();
    sub CONTEXT_XMM0();
    sub CONTEXT_RAX();
    *IsBadStringPtr = *Win32::API::IsBadStringPtr;
    sub PTRSIZE ();
    *PTRSIZE = *Win32::API::PTRSIZE;
    sub PTRLET ();
    *PTRLET = *Win32::API::Type::pointer_pack_type;
    if(OPV <= 5.008000){ #don't have unpackstring in C
        eval('sub _CallUnpack {return unpack($_[0], $_[1]);}');
    }
    *DEBUGCONST = *Win32::API::DEBUGCONST;
    *DEBUG = *Win32::API::DEBUG;
}
#######################################################################
# dynamically load in the API extension module.
#
XSLoader::load 'Win32::API::Callback', $VERSION;

#######################################################################
# PUBLIC METHODS
#
sub new {
    my ($class, $proc, $in, $out, $callconvention) = @_;
    my $self = bless {}, $class; #about croak/die safety, can safely bless here,
    #a ::Callback has no DESTROY, it has no resources to release, there is a HeapBlock obj
    #stored in the ::Callback hash, but the HeapBlock destroys on its own
    # printf "(PM)Callback::new: got proc='%s', in='%s', out='%s'\n", $proc, $in, $out;

    $self->{intypes} = []; #XS requires this, do not remove
    if (ref($in) eq 'ARRAY') {
        foreach (@$in) {
            push(@{$self->{intypes}}, $_);
        }
    }
    else {
        my @in = split '', $in;
        foreach (@in) {
            push(@{$self->{intypes}}, $_);
        }
    }
    $self->{inbytes} = 0;
    foreach(@{$self->{intypes}}){ #calc how long the c stack is
        if($_ eq 'Q' or $_ eq 'q' or $_ eq 'D' or $_ eq 'd'){
            $self->{inbytes} += 8; #always 8
        }
        else{
            $self->{inbytes} += PTRSIZE; #4 or 8
        }
    }
    $self->{outtype} = $out;
    $self->{out} = Win32::API->type_to_num($out);
    $self->{sub} = $proc;
    $self->{cdecl} = Win32::API::calltype_to_num($callconvention);

    DEBUG "(PM)Callback::new: calling CallbackCreate($self)...\n" if DEBUGCONST;
    my $hproc = MakeCB($self);

    DEBUG "(PM)Callback::new: hproc=$hproc\n" if DEBUGCONST;

    $self->{code} = $hproc;

    #### cast the spell
    return $self;
}

sub MakeStruct {
    my ($self, $n, $addr) = @_;
    DEBUG "(PM)Win32::API::Callback::MakeStruct: got self='$self'\n" if DEBUGCONST;
    my $struct = Win32::API::Struct->new($self->{intypes}->[$n]);
    $struct->FromMemory($addr);
    return $struct;
}

#this was rewritten in XS, and is broken b/c it doesn't work on 32bit Perl with Quads
#sub MakeParamArr { #on x64, never do "$i++;       $packedparam .= $arr->[$i];"
#    #on x86, structs and over word size params appears on the stack,
#    #on x64 anything over the size of a "word" is passed by pointer
#    #nothing takes more than 8 bytes per parameter on x64
#    #there is no way to formally specify a pass by copy struct in ::Callback
#    #this only matters on x86, a work around is a bunch of N/I parameters,
#    #repack them as Js, then concat them, and you have the original pass by copy
#    #x86 struct
#    my ($self, $arr)  = @_;
#    my ($i, @pass_arr) = (0);
#    for(@{$self->{intypes}}){ #elements of intypes are not 1 to 1 with stack params
#        my ($typeletter, $packedparam, $finalParam, $unpackletter)  = ($_, $arr->[$i]);
#        
#        #structs don't work, this is broken code from old version
#        #$self->{intypes} is letters types not C prototype params
#        #C prototype support would have to exist for MakeStruct to work
#        if(    $typeletter eq 'S' || $typeletter eq 's'){
#            die "Win32::API::Callback::MakeParamArr type letter \"S\" and struct support not implemented";
#            #push(@pass_arr, MakeStruct($self, $i, $packedparam));
#        }elsif($typeletter eq 'I'){
#            $unpackletter = 'I', goto UNPACK;
#        }elsif($typeletter eq 'i'){
#            $unpackletter = 'i', goto UNPACK;
#        }elsif($typeletter eq 'f' || $typeletter eq 'F'){
#            $unpackletter = 'f', goto UNPACK;
#        }
#        elsif($typeletter eq 'd' || $typeletter eq 'D'){
#            if(IVSIZE == 4){ #need more data, 32 bit machine
#                $packedparam .= $arr->[++$i];
#            }
#            $unpackletter = 'd', goto UNPACK;
#        }
#        elsif($typeletter eq 'N' || $typeletter eq 'L' #on x64, J is 8 bytes
#               || (IVSIZE == 8 ? $typeletter eq 'Q': 0)){
#            $unpackletter = 'J', goto UNPACK;
#        }elsif($typeletter eq 'n' || $typeletter eq 'l'
#               || (IVSIZE == 8 ? $typeletter eq 'q': 0)){
#            $unpackletter = 'j', goto UNPACK;
#        }elsif(IVSIZE == 4 && ($typeletter eq 'q' || $typeletter eq 'Q')){
#            #need more data, 32 bit machine
#            $finalParam = $packedparam . $arr->[++$i];
#        }elsif($typeletter eq 'p' || $typeletter eq 'P'){
#            if(!IsBadStringPtr($arr->[$i], ~0)){ #P letter is terrible design
#                $unpackletter = 'p', goto UNPACK;
#            }#else undef
#        }
#        else{ die "Win32::API::Callback::MakeParamArr unknown in type letter $typeletter";}
#        goto GOTPARAM;
#        UNPACK:
#        $finalParam = unpack($unpackletter, $packedparam);
#        GOTPARAM:
#        $i++;
#        push(@pass_arr, $finalParam);
#    }
#    return \@pass_arr;
#}

#on x64
#void RunCB($self, $EBP_ESP, $retval)
#on x86
#void RunCB($self, $EBP_ESP, $retval, $unwindcount, $F_or_D)
if(! ISX64 ) {
*RunCB  = sub {#32 bits
    my $self = $_[0];
    my (@pass_arr, $return, $typeletter, $inbytes, @arr);
    $inbytes = $self->{inbytes};
    #first is ebp copy then ret address
    $inbytes += PTRSIZE * 2;
    my $paramcount = $inbytes / PTRSIZE ;
    my $stackstr = unpack('P'.$inbytes, pack(PTRLET, $_[1]));
    #pack () were added in 5.7.2
    if (OPV > 5.007002) {
        @arr = unpack("(a[".PTRLET."])[$paramcount]",$stackstr);
    } else {
        #letter can not be used for size, must be numeric on 5.6
        @arr = unpack(("a4") x $paramcount,$stackstr);
    }
    shift @arr, shift @arr; #remove ebp copy and ret address
    $paramcount -= 2;
    $return = &{$self->{sub}}(@{MakeParamArr($self, \@arr)});
    
    #now the return type
    $typeletter = $self->{outtype};
    #float_or_double flag, its always used
    #float is default for faster copy of probably unused value
    $_[4] = 0;
    #its all the same in memory
    if($typeletter eq 'n' || $typeletter eq 'N'
          || $typeletter eq 'l' || $typeletter eq 'L'
          || $typeletter eq 'i' || $typeletter eq 'I'){
        $_[2] = pack(PTRLET, $return);
    }elsif($typeletter eq 'q' || $typeletter eq 'Q'){
        if(IVSIZE == 4){
            if($self->{'UseMI64'} || ref($return)){ #un/signed meaningless
                $_[2] = Math::Int64::int64_to_native($return);
            }
            else{
                warn("Win32::API::Callback::RunCB return value for return type Q is under 8 bytes long")
                if length($return) < 8;
                $_[2] = $return.''; #$return should be a 8 byte string
                #will be garbage padded in XS if < 8, but must be a string, not a IV or under
            }
        }
        else{
            $_[2] = pack($typeletter, $return);
        }
    }elsif($typeletter eq 'f' || $typeletter eq 'F' ){
        $_[2] = pack('f', $return);
    }elsif($typeletter eq 'd' || $typeletter eq 'D' ){
        $_[2] = pack('d', $return);
        $_[4] = 1; #use double
    }else { #return null
        $_[2] = "\x00" x 8;
    }
    
    if(! $self->{cdecl}){
        $_[3] = PTRSIZE * $paramcount; #stack rewind amount in bytes
    }
    else{$_[3] = 0;}
};
}
else{ #64 bits
*RunCB  = sub {
    my $self = $_[0];
    my (@pass_arr, $return, $typeletter);
    my $paramcount = $self->{inbytes} / IVSIZE;
    my $stack_ptr = unpack('P[J]', pack('J', ($_[1]+CONTEXT_RAX())));
    my $stack_str = unpack('P['.$self->{inbytes}.']', $stack_ptr);
    my @stack_arr = unpack("(a[J])[$paramcount]",$stack_str);
    #not very efficient, todo search for f/F/d/D in new() not here
    my $XMMStr = unpack('P['.(4 * 16).']',  pack('J', ($_[1]+CONTEXT_XMM0())));
    #print Dumper([unpack('(H[32])[4]', $XMMStr)]);
    my @XMM = unpack('(a[16])[4]', $XMMStr);
    #assume registers are copied to shadow stack space already
    #because of ... prototype, so only XMM registers need to be fetched.
    #Limitation, vararg funcs on x64 get floating points in normal registers
    #not XMMs, so a vararg function taking floats and doubles in the first 4
    #parameters isn't supported
    if($paramcount){
        for(0..($paramcount > 4 ? 4 : $paramcount)-1){
            my $typeletter = ${$self->{intypes}}[$_];
            if($typeletter eq 'f' || $typeletter eq 'F' || $typeletter eq 'd'
               || $typeletter eq 'D'){
        #x64 calling convention does not use the high 64 bits of a XMM register
        #although right here the high 64 bits are in @XMM elements
        #J on x64 is 8 bytes, a double will not corrupt, this is unreachable on x86
        #note we are copying 16 bytes elements to @stack_arr, @stack_arr is
        #normally 8 byte elements, unpack ignores the excess bytes later
                $stack_arr[$_] =  $XMM[$_];
            }
        }
    }
    #print Dumper(\@stack_arr);
    #print Dumper(\@XMM);
    $return = &{$self->{sub}}(@{MakeParamArr($self, \@stack_arr)});
    
    #now the return type
    $typeletter = $self->{outtype};
    #its all the same in memory
    if($typeletter eq 'n' || $typeletter eq 'N'
          || $typeletter eq 'l' || $typeletter eq 'L'
          || $typeletter eq 'i' || $typeletter eq 'I'
          || $typeletter eq 'q' || $typeletter eq 'Q'){
        $_[2] = pack('J', $return);
    }
    elsif($typeletter eq 'f' || $typeletter eq 'F' ){
        $_[2] = pack('f', $return);
    }
    elsif($typeletter eq 'd' || $typeletter eq 'D' ){
        $_[2] = pack('d', $return);
    }
    else { #return null
        $_[2] = pack('J', 0);
    }
};
}

sub MakeCB{
    
    my $self = $_[0];
    #this x86 function does not corrupt the callstack in a debugger since it
    #uses ebp and saves ebp on the stack, the function won't have a pretty
    #name though
    my $code =  (!ISX64) ? ('' #parenthesis required to constant fold
    ."\x55" #          push    ebp
    ."\x8B\xEC" #      mov     ebp, esp
    ."\x83\xEC\x0C"#   sub     esp, 0Ch
    ."\x8D\x45\xFC" #  lea     eax, [ebp+FuncRtnCxtVar]
    ."\x50"#           push    eax
    ."\x8D\x45\xF4"#   lea     eax, [ebp+retval]
    ."\x50"#           push    eax
    ."\x8B\xC5"#       mov     eax,ebp 
    ."\x50"#           push    eax
    ."\xB8").PackedRVTarget($self)#B8 mov imm32 to eax, a HV * winds up here
    .("\x50"#           push    eax
    ."\xB8").$Stage2FuncPtrPkd # mov     eax, 0C0DE0001h
    .("\xFF\xD0"#       call    eax
    #since ST(0) is volatile, we don't care if we fill it with garbage
    ."\x80\x7D\xFE\x00"#cmp    [ebp+FuncRtnCxtVar.F_Or_D], 0
    ."\xDD\xD8"#       fstp    st(0) pop a FP reg to make space on FPU stack
    ."\x74\x05"#       jz      5 bytes
    ."\xDD\x45\xF4"#   fld     qword ptr [ebp+retval] (double)
    ."\xEB\x03"#       jmp     3 bytes
    ."\xD9\x45\xF4"#   fld     dword ptr [ebp+retval] (float)
    #rewind sp to entry sp, no pop push after this point
    ."\x83\xC4\x24"#   add     esp, 24h
    ."\x8B\x45\xF4"#   mov     eax, dword ptr [ebp+retval]
    #edx might be garbage, we don't care, caller only looks at volatile
    #registers that the caller's prototype says the caller does
    ."\x8B\x55\xF8"#   mov     edx, dword ptr [ebp+retval+4]
    #can't use retn op, it requires a immediate count, our count is in a register
    #only one register available now, this will be complicated
    ."\x0F\xB7\x4D\xFC"#movzx  ecx, word ptr [ebp+FuncRtnCxtVar.unwind_len]
    ."\x01\xCC"#       add     esp, ecx , might be zero or more
    ."\x8B\x4D\x04"#   mov     ecx, dword ptr [ebp+4] ret address
    ."\x8B\x6D\x00"#   mov     ebp, dword ptr [ebp+0] restore BP
    ."\xFF\xE1")#       jmp     ecx


    #begin x64 part
    #these packs don't constant fold in < 5.17 :-(
    #they are here for readability
    :(''.pack('C', 0b01000000 #REX base
            | 0b00001000 #REX.W
            | 0b00000001 #REX.B
    ).pack('C', 0xB8+2) #mov to r10 register
    .PackedRVTarget($self)
    .pack('C', 0b01000000 #REX base
            | 0b00001000 #REX.W
    ).pack('C', 0xB8) #mov to rax register
    .$Stage2FuncPtrPkd
    ."\xFF\xE0");#       jmp     rax
#making a full function in Perl in x64 was removed because RtlAddFunctionTable
#has no effect on VS 2008 debugger, it is a bug in VS 2008, in WinDbg the C callstack
#is correct with RtlAddFunctionTable, and broken without RtlAddFunctionTable
#in VS 2008, the C callstack was always broken since WinDbg and VS 2008 both
#*only* use Unwind Tables on x64 to calculate C callstacks, they do not, I think,
#use 32 bit style EBP/RBP walking, x64 VC almost never uses BP addressing anyway.
#The easiest fix was to not have dynamic machine code in the callstack at all,
#which is what I did. Having good C callstacks in a debugger with ::API and
#::Callback are a good goal.
#
##--- c:\documents and settings\administrator\desktop\w32api\callback\callback.c -
#    $code .= "\x4C\x8B\xDC";#         mov         r11,rsp
#    $code .= "\x49\x89\x4B\x08";#      mov         qword ptr [r11+8],rcx 
#    $code .= "\x49\x89\x53\x10";#      mov         qword ptr [r11+10h],rdx 
#    $code .= "\x4D\x89\x43\x18";#      mov         qword ptr [r11+18h],r8 
#    $code .= "\x4D\x89\x4B\x20";#      mov         qword ptr [r11+20h],r9 
#    $code .= "\x48\x83\xEC\x78";#      sub         rsp,78h 
#    #void (*LPerlCallback)(SV *, void *, unsigned __int64 *, void *) =
#    #( void (*)(SV *, void *, unsigned __int64 *, void *)) 0xC0DE00FFFF000001;
#    #__m128 arr [4];
#    #__m128 retval;
##     arr[0].m128_u64[0] = 0xFFFF00000000FF10;
##00000000022D1017 48 B8 10 FF 00 00 00 00 FF FF mov         rax,0FFFF00000000FF10h 
##arr[0].m128_u64[1] = 0xFFFF00000000FF11;
##     arr[1].m128_u64[0] = 0xFFFF00000000FF20;
##     arr[1].m128_u64[1] = 0xFFFF00000000FF21;
##     arr[2].m128_u64[0] = 0xFFFF00000000FF30;
##     arr[2].m128_u64[1] = 0xFFFF00000000FF31;
##     arr[3].m128_u64[0] = 0xFFFF00000000FF40;
##     arr[3].m128_u64[1] = 0xFFFF00000000FF41;
#
##    LPerlCallback((SV *)0xC0DE00FFFF000002, (void*) arr, (unsigned __int64 *)&retval,
##                  (DWORD_PTR)&a);
##00000000022D1021 4D 8D 4B 08      lea         r9,[r11+8] #no 4th param
#    $code .= "\x4D\x8D\x43\xA8";#      lea         r8,[r11-58h] #&retval param
##00000000022D1029 49 89 43 B8      mov         qword ptr [r11-48h],rax 
##00000000022D102D 48 B8 11 FF 00 00 00 00 FF FF mov         rax,0FFFF00000000FF11h 
#    $code .= "\x49\x8D\x53\xB8";#     lea         rdx,[r11-48h] #arr param
##00000000022D103B 49 89 43 C0      mov         qword ptr [r11-40h],rax 
##00000000022D103F 48 B8 20 FF 00 00 00 00 FF FF mov         rax,0FFFF00000000FF20h 
##00000000022D1049 48 B9 02 00 00 FF FF 00 DE C0 mov         rcx,0C0DE00FFFF000002h
#    $code .= "\x48\xB9".PackedRVTarget($self);# mov         rcx, the HV *
##00000000022D1053 49 89 43 C8      mov         qword ptr [r11-38h],rax 
##00000000022D1057 48 B8 21 FF 00 00 00 00 FF FF mov         rax,0FFFF00000000FF21h 
##00000000022D1061 49 89 43 D0      mov         qword ptr [r11-30h],rax 
##00000000022D1065 48 B8 30 FF 00 00 00 00 FF FF mov         rax,0FFFF00000000FF30h 
##00000000022D106F 49 89 43 D8      mov         qword ptr [r11-28h],rax 
##00000000022D1073 48 B8 31 FF 00 00 00 00 FF FF mov         rax,0FFFF00000000FF31h 
##00000000022D107D 49 89 43 E0      mov         qword ptr [r11-20h],rax 
##00000000022D1081 48 B8 40 FF 00 00 00 00 FF FF mov         rax,0FFFF00000000FF40h 
##00000000022D108B 49 89 43 E8      mov         qword ptr [r11-18h],rax 
##00000000022D108F 48 B8 41 FF 00 00 00 00 FF FF mov         rax,0FFFF00000000FF41h 
##00000000022D1099 49 89 43 F0      mov         qword ptr [r11-10h],rax 
##00000000022D109D 48 B8 01 00 00 FF FF 00 DE C0 mov         rax,0C0DE00FFFF000001h
#    $code .= "\x48\xB8".$Stage2FuncPtrPkd; # mov         rax,0C0DE00FFFF000001h 
#    $code .= "\xFF\xD0";#            call        rax  
##    return *(void **)&retval;
#    $code .= "\x48\x8B\x44\x24\x20";#   mov         rax,qword ptr [retval] 
##}
#    $code .= "\x48\x83\xC4\x78";#      add         rsp,78h 
#    $code .= "\xC3";#              ret              

#$self->{codestr} = $code; #save memory
#32 bit perl doesn't use DEP in my testing, but use executable heap to be safe
#a Win32::API::Callback::HeapBlock is a ref to scalar, that scalar has the void *
my $ptr = ${($self->{codeExecAlloc} = Win32::API::Callback::HeapBlock->new(length($code)))};
WriteMemory($ptr, $code, length($code));
return $ptr;
}


1;

__END__

#######################################################################
# DOCUMENTATION
#

=head1 NAME

Win32::API::Callback - Callback support for Win32::API

=head1 SYNOPSIS

  use Win32::API;
  use Win32::API::Callback;

  my $callback = Win32::API::Callback->new(
    sub { my($a, $b) = @_; return $a+$b; },
    "NN", "N",
  );

  Win32::API->Import(
      'mydll', 'two_integers_cb', 'KNN', 'N',
  );

  $sum = two_integers_cb( $callback, 3, 2 );


=head1 FOREWORDS

=over 4

=item *
Support for this module is B<highly experimental> at this point.

=item *
I won't be surprised if it doesn't work for you.

=item *
Feedback is very appreciated.

=item *
Documentation is in the work. Either see the SYNOPSIS above
or the samples in the F<samples> or the tests in the F<t> directory.

=back

=head1 USAGE

Win32::API::Callback uses a subset of the type letters of Win32::API. C Prototype
interface isn't supported. Not all the type letters of Win32::API are supported
in Win32::API::Callback.

=over 4

=item C<I>: 
value is an unsigned integer (unsigned int)

=item C<i>: 
value is an signed integer (signed int or int)

=item C<N>: 
value is a unsigned pointer sized number (unsigned long)

=item C<n>: 
value is a signed pointer sized number (signed long or long)

=item C<Q>: 
value is a unsigned 64 bit integer number (unsigned long long, unsigned __int64)
See next item for details.

=item C<q>: 
value is a signed 64 bit integer number (long long, __int64)
If your perl has 'Q'/'q' quads support for L<pack> then Win32::API's 'q'
is a normal perl numeric scalar. All 64 bit Perls have quad support. Almost no
32 bit Perls have quad support. On 32 bit Perls, without quad support,
Win32::API::Callback's 'q'/'Q' letter is a packed 8 byte string.
So C<0x8000000050000000> from a perl with native Quad support
would be written as C<"\x00\x00\x00\x50\x00\x00\x00\x80"> on a 32 bit
Perl without Quad support. To improve the use of 64 bit integers with
Win32::API::Callback on a 32 bit Perl without Quad support, there is
a per Win32::API::Callback object setting called L<Win32::API/UseMI64>
that causes all quads to be accepted as, and returned as L<Math::Int64>
objects. 4 to 8 byte long pass by copy/return type C aggregate types
are very rare in Windows, but they are supported as "in" and return
types by using 'q'/'Q' on 32 and 64 bits. Converting between the C aggregate
and its representation as a quad is up to the reader. For "out" in
Win32::API::Callback (not "in"), if the argument is a reference, it will
automatically be treated as a Math::Int64 object without having to
previously call this function.

=item C<F>: 
value is a floating point number (float)

=item C<D>: 
value is a double precision number (double)

=item C<Unimplemented types>:
Unimplemented in Win32::API::Callback types such as shorts, chars, and
smaller than "machine word size" (32/64bit) numbers can be processed
by specifying N, then masking off the high bytes.
For example, to get a char, specify N, then do C<$numeric_char = $_[2] & 0xFF;>
in your Perl callback sub. To get a short, specify N, then do
C<$numeric_char = $_[2] & 0xFFFF;> in your Perl callback sub.

=back

=head2 FUNCTIONS

=head3 new

    $CallbackObj = Win32::API::Callback->new( sub { print "hello world";},
                                            'NDF', 'Q', '__cdecl');
    $CallbackObj = Win32::API::Callback->new( sub { print "hello world";},
                                            $in, $out);

Creates and returns a new Win32::API::Callback object. Calling convention
parameter is optional.  Calling convention parameter has same behaviour as
Win32::API's calling convention parameter. C prototype parsing of Win32::API
is not available with Win32::API::Callback. If the C caller assumes the
callback has vararg parameters, and the platform is 64 bits/x64, in the first 4
parameters, if they are floats or doubles they will be garbage. Note there is
no way to create a Win32::API::Callback callback with a vararg prototype.
A workaround is to put "enough" Ns as the in types, and stop looking at the @_
slices in your Perl sub callback after a certain count. Usually the first
parameter will somehow indicate how many additional stack parameters you are
receiving. The Ns in @_ will eventually become garbage, technically they are
the return address, saved registers, and C stack allocated variables of the
caller. They are effectivly garbage for your vararg callback. All vararg
callbacks on 32 bits must supply a calling convention, and it must be '__cdecl'
or 'WINAPIV'.

=head2 METHODS

=head3 UseMI64

See L<Win32::API/UseMI64>.

=head1 KNOWN ISSUES

=over 4

=item *

Callback is safe across a Win32 psuedo-fork. Callback is not safe across a
Cygwin fork. On Cygwin, in the child process of the fork, a Segmentation Fault
will happen if the Win32::API::Callback callback is is called.

=back

=head1 SEE ALSO

L<Win32::API::Callback::IATPatch>

=head1 AUTHOR

Aldo Calpini ( I<dada@perl.it> ).
Daniel Dragan ( I<bulkdd@cpan.org> ).

=head1 MAINTAINER

Cosimo Streppone ( I<cosimo@cpan.org> ).

=cut
