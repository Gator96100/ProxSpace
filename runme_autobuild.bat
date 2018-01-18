@echo off
REM *******************************************
REM CHANGE THIS PATH TO MATCH YOUR INSTALLATION
REM *******************************************
set MYPATH=%~dp0
set autobuild=true

echo #Win32_Path		Mount_Point >msys/etc/fstab 
echo %MYPATH%devkitARM	/devkitARM >>msys/etc/fstab
echo %MYPATH%Qt\5.6 	/qt >>msys/etc/fstab
echo %MYPATH%pm3		/pm3 >>msys/etc/fstab
echo %MYPATH%build		/build >>msys/etc/fstab
echo %MYPATH%finished		/finished >>msys/etc/fstab
msys\msys.bat
