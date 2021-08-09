@echo off
cd %~dp0
del /Q ..\msys2\etc\passwd
del /Q ..\msys2\etc\group
del /Q ..\msys2\etc\fstab
del /Q ..\msys2\var\log
move /Y ..\msys2\etc\pacman.d\mirrorlist.mingw64.backup ..\msys2\etc\pacman.d\mirrorlist.mingw64
move /Y ..\msys2\etc\pacman.d\mirrorlist.msys.backup ..\msys2\etc\pacman.d\mirrorlist.msys
rmdir /Q /S ..\pm3