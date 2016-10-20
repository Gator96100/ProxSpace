
											#######################################
											Proxmark III Develoment Kit for Windows
											#######################################

## What's installed ##

	This cut down development environment has been created specifically for Windows users.
	* devkitARM r41
	* SVN 1.7.4
	* Qt 4.6.2

## IMPORTANT ##

	Your Proxmark III might be running old firmware. If this is the case, please download the following package and follow the instructions included to update your Proxmark III
	https://code.google.com/p/proxmark3/downloads/detail?name=pm3-bin-672.zip&can=2&q=

	IF YOU ARE UNSURE OF ANYTHING. ASK.
	 Wiki: https://code.google.com/p/proxmark3/wiki/
	Forum: http://www.proxmark.org/forum/
	  IRC: (freenode) proxmark3

## Usage ##

	Extract 'ProxSpace' to a location on drive without spaces.
		For example C:\Proxspace or D:\projects\public\proxmark\proxspace are ok whereas C:\My Documents\My Projects\proxspace is not.

	Run 'runme.bat'

	To get the Proxmark III trunk or to update checked out project type './update_SVN.sh'.
	To change to a specific revision type 'svn up -r 558', where 588 is the revision number.

	To build the project type 'make clean && make all'.

	To run the Proxmark III client type './client/proxmark3.exe COM1' where COM1 is the USB port of the Proxmark III.

	To check your firmware revision on the Proxmark III type 'hw ver'.

	To get basic help type 'help'. Or for help on a set of sub commands type the command followed by help. eg. 'hf mf help'

	To exit type 'exit'.

## Firmware upgrading the Proxmark III ##

	To upgrade the firmware on the Proxmark III:
	
	Please note that more detail is available on the wiki: https://code.google.com/p/proxmark3/wiki/

	1. Press and hold the button on the Proxmark III and attach it to a USB port on your computer.
	2. Run './client/flasher -b COM1 ./bootrom/obj/bootrom.elf'
	3. Wait for the process to complete.
	4. Detach the Proxmark III from your computer.
	5. Repeat Steps 1-4 two more times replacing Step 2 with the following two lines.
	   ./client/flasher COM1 ./armsrc/obj/fpgaimage.elf
	   ./client/flasher COM1 ./armsrc/obj/osimage.elf
