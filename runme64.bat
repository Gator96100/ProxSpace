@echo off
cd %~dp0
call msys2\ps\setup.cmd
call msys2\msys2_shell.cmd -mingw64 -defterm -no-start %*
if not exist msys2\ps\installed64.txt msys2\msys2_shell.cmd -mingw64 -defterm -no-start %*