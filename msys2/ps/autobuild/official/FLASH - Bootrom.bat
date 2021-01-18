@echo off
color 0a
MODE CON COLS=80 LINES=36
title Bootrom FLASH FILE
echo.
echo.
echo.
echo   =============================================================================
echo   ©¦!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! O__O !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!©¦
echo   ©¦=========================================================================©¦
echo   ©¦Bootrom-ONLY FLASHER BATCH FILE                                          ©¦
echo   ©¦                                                                         ©¦
echo   ©¦you will need to have this file (FLASH - Bootrom.bat) in \win32 folder   ©¦
echo   ©¦you will need to have flasher.exe in \win32 folder                       ©¦
echo   ©¦you will need to have bootrom.elf in \firmware_win\bootrom folder        ©¦
echo   ©¦                                                                         ©¦
echo   ©¦                                                                         ©¦
echo   ©¦   ! FLASHING BOOTROM CAN BE EXTREMELY DANGEROUS !                       ©¦
echo   ©¦     ! FLASHING BOOTROM CAN BE EXTREMELY DANGEROUS !                     ©¦
echo   ©¦       ! FLASHING BOOTROM CAN BE EXTREMELY DANGEROUS !                   ©¦
echo   ©¦         ! FLASHING BOOTROM CAN BE EXTREMELY DANGEROUS !                 ©¦
echo   ©¦           ! FLASHING BOOTROM CAN BE EXTREMELY DANGEROUS !               ©¦
echo   ©¦             ! FLASHING BOOTROM CAN BE EXTREMELY DANGEROUS !             ©¦
echo   ©¦               ! FLASHING BOOTROM CAN BE EXTREMELY DANGEROUS !           ©¦
echo   ©¦                 ! FLASHING BOOTROM CAN BE EXTREMELY DANGEROUS !         ©¦
echo   ©¦                   ! FLASHING BOOTROM CAN BE EXTREMELY DANGEROUS !       ©¦
echo   ©¦                     ! FLASHING BOOTROM CAN BE EXTREMELY DANGEROUS !     ©¦
echo   ©¦                       ! FLASHING BOOTROM CAN BE EXTREMELY DANGEROUS !   ©¦
echo   ©¦                                                                         ©¦
echo   ©¦                                                                         ©¦
echo   ©¦IF YOU HAVE THOSE REQUISITES                                             ©¦
echo   ©¦               HIT ANY BUTTON TO CONTINUE AT YOUR OWN RISK !!!           ©¦
echo   ©¦-------------------------------------------------------------------------©¦
echo   =============================================================================
pause.

cls
echo.
echo                 ====================================
echo                 FLASHING bootrom.elf, please wait...
echo                 ====================================
echo.

call client\setup.bat
client\flasher.exe com5 -b client\bootrom.elf

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