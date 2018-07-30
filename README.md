
	#######################################
	Proxmark III Develoment Kit for Windows
	#######################################
## Different runme ##
    The runme.bat is designed for development, when 'runme.bat' is started a terminal opens that allows to run make.
    The runme_autobuild.bat runs a script (msys/scrip.sh) at startup that updates all git repositories in the pm3 folder and then wants to compile them, it was not designed for development, just for compiling.
    
## What's installed ##

	This cut down development environment has been created specifically for Windows users.
	* msys2
	* GNU Arm Embedded Toolchain 7-2018-q2
	After starting for the first time it will automatically download following packages:
	* gcc
	* Qt5
	* readline
	* git
	* perl
	* make
	* pkg-config
## Updating packages  ##
    msys2 comes with a package  manager, all installed packages can be updated with "pacman -Syuu"

## Usage ##

	Extract 'ProxSpace' to a location on drive without spaces.
		For example C:\Proxspace or D:\projects\public\proxmark\proxspace are ok whereas C:\My Documents\My Projects\proxspace is not.

	Run 'runme.bat'
	To get the Proxmark III repository you wish to compile.
	To build the project type 'make clean && make all'.
	To run the Proxmark III client type './client/proxmark3.exe COM1' where COM1 is the USB port of the Proxmark III.
	To check your firmware revision on the Proxmark III type 'hw ver'.
	To get basic help type 'help'. Or for help on a set of sub commands type the command followed by help. eg. 'hf mf help'
	To exit type 'exit'.

## Firmware upgrading the Proxmark III ##

	To upgrade the firmware on the Proxmark III:
	Please note that more detail is available on the wiki: https://github.com/Proxmark/proxmark3/wiki

	1. Attach the Proxmark III to a USB port on your computer.
	2. To flash the BOOTROM run './client/flasher COM1 -b ./bootrom/obj/bootrom.elf'
	3. To flash the FULLIMAGE run './client/flasher COM1 ./armsrc/obj/fullimage.elf'
	4. Wait for the process to complete.
