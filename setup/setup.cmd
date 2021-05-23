@echo off
SET "PATH=%cd%\msys2\usr\bin;%PATH%"
copy /Y %cd%\setup\*.post %cd%\msys2\etc\post-install\ >NUL
copy /Y %cd%\setup\*.conf %cd%\msys2\etc\ >NUL

echo # For a description of the file format, see the Users Guide >%cd%\msys2/etc/fstab 
echo # http://cygwin.com/cygwin-ug-net/using.html#mount-table >>%cd%\msys2/etc/fstab 
echo none / cygdrive binary,posix=0,noacl,user 0 0 >>%cd%\msys2/etc/fstab
echo %cd%\setup /setup ntfs noacl 0 0 >>%cd%\msys2/etc/fstab
echo %cd%\pm3 /pm3 ntfs noacl 0 0 >>%cd%\msys2/etc/fstab

mkdir %cd%\msys2\tmp 2> nul
mkdir %cd%\msys2\dev 2> nul
mkdir %cd%\msys2\otp 2> nul

dash /usr/bin/rebaseall -p 2> nul

del %cd%\msys2\etc\passwd 2> nul
del %cd%\msys2\etc\group 2> nul
touch /etc/passwd
touch /etc/group
bash /setup/startup_checks.sh
bash /setup/user_setup.sh
