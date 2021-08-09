@echo off
cd %~dp0
call setup\setup.cmd
call msys2\msys2_shell.cmd -mingw64 -defterm -no-start %*
if not exist setup\installed64.txt msys2\msys2_shell.cmd -mingw64 -defterm -no-start %*
