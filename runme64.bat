@echo off
call msys2\ps\setup.cmd
call msys2\msys2_shell.cmd -mingw64 -defterm -no-start %*