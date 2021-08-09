# Proxmark III development environment for Windows
ProxSpace is a collection of tools that are required to compile the firmware and client of the Proxmark III. At its core ProxSpace uses msys2. MSYS2 is a software distro and building platform for Windows, it provides a bash shell, Autotools, revision control systems and the like for building native Windows applications using MinGW-w64 toolchains. ProxSpace uses the GNU Arm Embedded Toolchain for compiling the Proxmark III firmware.

## Files
ProxSpace comes with 2 different executables .bat files. 

 - `runme64.bat` will start ProxSpace in x64 mode.
 - `autobuild.bat` runs a script (setup/autobuild.sh) in x64 mode at startup. The script will update all git repositories in the pm3 folder and then compile them and move a zip file with the just compiled firmware and client into the build folder. It is not designed for development, just for compiling.

## What's installed
ProxSpace will automatically download and update to the latest required packages. All tools will be contained within the ProxSpace folder.

ProxSpace is based on:
 - msys2-x86_64-20210725
 
 Following packages will be automatically download or updated:
 - arm-none-eabi-gcc
 - arm-none-eabi-gdb
 - openocd
 - git
 - make
 - cmake
 - gcc
 - gdb
 - Qt5
 - readline
 - pkg-config
 - libsndfile
 - lua
 - bzip2
 - python
 - jansson

## Package management system
MSYS2 features a package management system to provide easy installation of packages, Pacman. It brings many powerful features such as dependency resolution and simple complete system upgrades, as well as straight-forward package building. All installed packages can be updated with `pacman -Syuu` For more details visit [the MSYS2 wiki](https://github.com/msys2/msys2/wiki)

## Installation
 1. There are two methods of installing the ProxSpace environment.
	* Downloading [the latest master](https://github.com/Gator96100/ProxSpace/archive/master.zip). This will upgrade the msys2 core packages and then will download and install every package required for compiling the Proxmark client and firmware. This can take some time.
	* Downloading [the latest release](https://github.com/Gator96100/ProxSpace/releases). This ProxSpace environment is prepared for a fast installation, all packages are already cached.
 2. Extract 'ProxSpace' to a location on drive without spaces. For example `C:\Proxspace` or `D:\projects\public\proxmark\proxspace` are ok, whereas `C:\My Documents\My Projects\proxspace` is not.
 3. Run `runme64.bat` depending on your Windows architecture.
 4. Get the Proxmark III repository you wish to compile. This can be done with git. For example `git clone https://github.com/RfidResearchGroup/proxmark3.git`.
 5. Go into the root directory of the repository you wish to compile. For example `cd proxmark3`.
 6. To build the project type `make clean && make all`. 
 7. In most cases the Proxmark III needs to be flashed with the just compiled firmware for details see **Firmware upgrading the Proxmark III**.
 8. To run the Proxmark III client type `./pm3`.
 9. Check your firmware revision on the Proxmark III with `hw ver`
 10. For basic help type `help`. Or for help on a set of sub commands type the command followed by help. For example `hf mf help`.
 
## Firmware upgrading the Proxmark III
Please note that more detail is available on the wiki: https://github.com/RfidResearchGroup/proxmark3/blob/master/doc/md/Use_of_Proxmark/0_Compilation-Instructions.md#flash-the-bootrom--fullimage
 1. Attach the Proxmark III to a USB port on your computer.
 2. Flash the bootrom with `./pm3-flash-bootrom`.
 3. Flash the fullimage with `./pm3-flash-fullimage`.
 4. Wait for the process to complete.
 
 ## Setup video
 [![ProxSpace Windows 10 setup](http://img.youtube.com/vi/-DLYp-yWmtQ/0.jpg)](http://www.youtube.com/watch?v=-DLYp-yWmtQ "ProxSpace Windows 10 setup")
