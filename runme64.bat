@echo off
REM *******************************************
REM CHANGE THIS PATH TO MATCH YOUR INSTALLATION
REM *******************************************
set MYPATH=%~dp0
set autobuild=false

echo # For a description of the file format, see the Users Guide >msys2/etc/fstab 
echo # http://cygwin.com/cygwin-ug-net/using.html#mount-table >>msys2/etc/fstab 
echo none / cygdrive binary,posix=0,noacl,user 0 0 >>msys2/etc/fstab
echo %MYPATH%pm3 /pm3 ntfs noacl 0 0 >>msys2/etc/fstab
echo %MYPATH%gcc-arm-none-eabi /gcc-arm-none-eabi ntfs noacl 0 0 >>msys2/etc/fstab
msys2\msys2_shell.cmd -mingw64 -defterm