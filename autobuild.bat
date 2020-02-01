@echo off
call msys2\ps\setup.cmd
echo %cd%\builds /builds ntfs noacl 0 0 >>msys2/etc/fstab
call msys2\msys2_shell.cmd -mingw32 -defterm -no-start -c /ps/autobuild.sh
call msys2\msys2_shell.cmd -mingw64 -defterm -no-start -c /ps/autobuild.sh