#!/bin/bash 
pm3Dir=/pm3
copyDir=/builds
buildDir=/tmp
mingwDir=/mingw64

function check_requirements {
	pacman -Q p7zip 1> /dev/null
	if [[ $? != 0 ]]; then
		pacman --noconfirm -S p7zip
	fi
}

function copy_shell {
	DEPLIST=(	
			"/usr/bin/bash.exe"
			"/usr/bin/dirname.exe"
			"/usr/bin/basename.exe"
			"/usr/bin/uname.exe"
			"/usr/bin/awk.exe"
			"/usr/bin/grep.exe"
			"/usr/bin/sleep.exe"
			)
	mkdir -p "$dstDir/client/libs/shell"
	for dep in ${DEPLIST[*]}; do
		ldd $dep | grep "=> /usr" | awk '{print $3}' | xargs -I '{}' cp -v '{}' "$dstDir/client/libs/shell"
		cp $dep "$dstDir/client/libs/shell"
	done
	
	#tmp dir required for bash
	mkdir -p "$dstDir/client/tmp"
}

function copy_common {
	rm -rf "$dstDir"
	mkdir -p "$copyDir/$buildName/"
	mkdir -p "$dstDir/client"
	mkdir -p "$dstDir/client/libs"
	mkdir -p "$dstDir/recovery"
	mkdir -p "$dstDir/Windows Driver (not required for Windows 10)"

	#Copy required libraries to client/libs
	ldd "$srcDir/client/proxmark3.exe" | grep "=> /mingw" | awk '{print $3}' | xargs -I '{}' cp -v '{}' "$dstDir/client/libs"
	#Copy qt5 platform dll
	cp "$mingwDir/share/qt5/plugins/platforms/qwindows.dll" "$dstDir/client/libs"
	#Copy firmware
	cp "$srcDir/armsrc/obj/fullimage.elf" "$dstDir/client"
	cp "$srcDir/bootrom/obj/bootrom.elf" "$dstDir/client"
	#Copy recovery
	cp $srcDir/recovery/{bootrom.bin,fullimage.bin,proxmark3_recovery.bin} "$dstDir/recovery"
	#Copy driver
	cp "$srcDir/driver/proxmark3.inf" "$dstDir/Windows Driver (not required for Windows 10)"
}

function check_for_updates {
	git fetch
	git pull --ff-only
	hash=$(git rev-parse HEAD)
	
	if ls $copyDir/$buildName/*-$hash.7z 1> /dev/null 2>&1; then
		return 1 #build exist
	else
		return 0 #build doesn't exist
	fi
}

function zip_folder {
	date=$(date +%Y%m%d)
	7z a -r -mx9 $copyDir/$buildName/$buildName-$date-$hash.7z $dstDir/*
}

function build_rrg {
	make clean
	#Running python scripts outside ProxSpace is a bad idea  
	make SKIPPYTHON=1 -j
	if [ $? -eq 0 ]; then
		copy_common
		copy_shell
		
		#Copy contents of the autobuild folder 
		cp -r /setup/autobuild/rrg/* "$dstDir"
		
		#Copy the client and additional files
		cp -r $srcDir/client/{proxmark3.exe,lualibs,luascripts,cmdscripts,dictionaries,resources} "$dstDir/client"
		
		#Copy the pm3 scripts
		cp -r $srcDir/{pm3,pm3-flash,pm3-flash-all,pm3-flash-bootrom,pm3-flash-fullimage} "$dstDir/client"
		
		zip_folder
	fi
}

function build_official {
	make clean
	make
	if [ $? -eq 0 ]; then
		copy_common
		
		#Copy contents of the autobuild folder 
		cp -r /setup/autobuild/official/* "$dstDir"
		
		#Copy the client and additional files
		cp -r $srcDir/client/{proxmark3.exe,flasher.exe,*.dic,lualibs,scripts,hardnested} "$dstDir/client"
		
		#Remove accidentally copied .h/.c files from hardnested folder
		rm $dstDir/client/hardnested/{*.h,*.c}
		
		zip_folder
	fi
}


function loop_folders {
	for i in $( ls -d */ ); do
		buildName=${i%%/}
		srcDir=$pm3Dir/$buildName
		dstDir=$buildDir/$buildName
		echo Processing: $srcDir
		cd $srcDir
		
		if check_for_updates; then
			#Build rrg
			if [ -f "pm3" ]; then
				build_rrg
			else
				build_official
			fi
		fi
	done
}
check_requirements
cd $pm3Dir
loop_folders

