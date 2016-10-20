@echo off
REM *******************************************
REM CHANGE THIS PATH TO MATCH YOUR INSTALLATION
REM *******************************************
set MYPATH=%~dp0

echo #Win32_Path		Mount_Point >msys/etc/fstab 
echo %MYPATH%mingw		/mingw >>msys/etc/fstab
echo %MYPATH%devkitARM	/devkitARM >>msys/etc/fstab
echo %MYPATH%Qt\4.6.2	/qt >>msys/etc/fstab
echo %MYPATH%pm3		/pm3 >>msys/etc/fstab
msys\msys.bat
