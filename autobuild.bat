@echo off
call msys2\ps\setup.cmd
taskkill /IM "gpg-agent.exe" /F
echo %~dp0builds /builds ntfs noacl 0 0 >>msys2/etc/fstab
call msys2\msys2_shell.cmd -mingw64 -defterm -no-start -c /ps/autobuild.sh