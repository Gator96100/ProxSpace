@echo off
cd "%~dp0client"
call setup.bat
::If you want to force the COM port add it to the line, example:
::bash pm3-flash-bootrom COM3
bash pm3-flash-bootrom
pause