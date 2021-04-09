@echo off
color 0a
MODE CON COLS=80 LINES=36
title FPGA FLASH FILE
echo.
echo.
echo.
echo   ==========================================================================
echo   ©¦!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! O__O !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!©¦
echo   ©¦======================================================================©¦
echo   ©¦BOOTROM + FULLIMAGE FLASHER BATCH FILE                                ©¦
echo   ©¦                                                                      ©¦
echo   ©¦you will need to have this batch in \win32 folder                     ©¦
echo   ©¦you will need to have bootrom.elf in \firmware_win\bootrom folder     ©¦
echo   ©¦you will need to have fullimage.elf in \firmware_win folder           ©¦
echo   ©¦you will need to have flasher.exe in \win32 folder                    ©¦
echo   ©¦                                                                      ©¦
echo   ©¦                                                                      ©¦
echo   ©¦IF YOU HAVE THOSE REQUISITES HIT ANY BUTTON TO CONTINUE !             ©¦
echo   ©¦----------------------------------------------------------------------©¦
echo   ==========================================================================
pause.

cls
echo.                
echo             ====================================================
echo             FLASHING bootrom.elf + fullimage.elf, please wait...
echo             ====================================================
echo.

call client\setup.bat
client\flasher.exe com5 -b client\bootrom.elf client\fullimage.elf

pause.

cls
title DONE
echo.
echo   ___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___
echo  /   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \
echo  \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/
echo  /   \___/                                                   \___/   \
echo  \___/                                                           \___/
echo  /   \                                                           /   \
echo  \___/                                                           \___/
echo  /   \       FLASHING OPERATION SUCCESSFUL ! Enjoy it !          /   \
echo  \___/                                                           \___/
echo  /   \                                                           /   \
echo  \___/                                                           \___/
echo  /   \                                BATCH FILE BY ASPER        /   \
echo  \___/                                                           \___/
echo  /   \                                                           /   \
echo  \___/                                                           \___/
echo  /   \___                                                     ___/   \
echo  \___/   \___     ___     ___     ___     ___     ___     ___/   \___/
echo  /   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \
echo  \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/
echo      \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/

echo.
pause.
cls
MODE CON COLS=130 LINES=36
cmd.exe

