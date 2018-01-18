@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!/usr/bin/perl
#line 15

# Computes and prints to stdout the CRC-32 values of the given files

use 5.006;
use strict;
use lib qw( blib/lib lib );
use Archive::Zip;
use FileHandle;

use vars qw( $VERSION );
BEGIN {
    $VERSION = '1.51';
}

my $totalFiles = scalar(@ARGV);
foreach my $file (@ARGV) {
    if ( -d $file ) {
        warn "$0: ${file}: Is a directory\n";
        next;
    }
    my $fh = FileHandle->new();
    if ( !$fh->open( $file, 'r' ) ) {
        warn "$0: $!\n";
        next;
    }
    binmode($fh);
    my $buffer;
    my $bytesRead;
    my $crc = 0;
    while ( $bytesRead = $fh->read( $buffer, 32768 ) ) {
        $crc = Archive::Zip::computeCRC32( $buffer, $crc );
    }
    my $fileCrc = sprintf("%08x", $crc);
    printf("$fileCrc");
    print("\t$file") if ( $totalFiles > 1 );

    if ( $file =~ /[^[:xdigit:]]([[:xdigit:]]{8})[^[:xdigit:]]/ ) {
	my $filenameCrc = $1;
	if ( lc($filenameCrc) eq lc($fileCrc) ) {
	    print("\tOK")
	} else {
	    print("\tBAD $fileCrc != $filenameCrc");
        }
    }

    print("\n");
}

__END__
:endofperl
