@echo off

copy /Y msys2\ps\*.post msys2\etc\post-install\ >NUL
echo # For a description of the file format, see the Users Guide >msys2/etc/fstab 
echo # http://cygwin.com/cygwin-ug-net/using.html#mount-table >>msys2/etc/fstab 
echo none / cygdrive binary,posix=0,noacl,user 0 0 >>msys2/etc/fstab
echo %~dp0pm3 /pm3 ntfs noacl 0 0 >>msys2/etc/fstab
echo %~dp0gcc-arm-none-eabi /gcc-arm-none-eabi ntfs noacl 0 0 >>msys2/etc/fstab
echo %~dp0builds /builds ntfs noacl 0 0 >>msys2/etc/fstab
call msys2\msys2_shell.cmd -mingw32 -defterm -no-start -c /ps/autobuild.sh
call msys2\msys2_shell.cmd -mingw64 -defterm -no-start -c /ps/autobuild.sh