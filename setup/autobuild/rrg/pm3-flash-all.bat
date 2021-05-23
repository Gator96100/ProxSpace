@echo off
cd "%~dp0client"
call setup.bat
::If you want to force the COM port add it to the line, example:
::bash pm3-flash-all COM3
bash pm3-flash-all
pause