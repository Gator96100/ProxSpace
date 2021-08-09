@echo off
cd %~dp0
del /Q installed
del /Q ..\msys2\etc\passwd
del /Q ..\msys2\etc\group
del /Q ..\msys2\etc\fstab
del /Q ..\msys2\var\log