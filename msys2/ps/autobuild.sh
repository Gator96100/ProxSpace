#!/bin/bash 
pm3Dir=/pm3
copyDir=/builds
buildDir=/tmp
mingwDir=/mingw64
arch=64
jobs=$(nproc)

pacman -Q p7zip 1> /dev/null
if [[ $? != 0 ]]; then
  pacman --noconfirm -S p7zip
fi

cd $pm3Dir
for i in $( ls -d */ ); do
  echo Processing: ${i%%/}-$arch
  cd $pm3Dir/${i%%/}
  git fetch
  git pull
  hash=$(git rev-parse HEAD)
  date=$(date +%Y%m%d)
 if ! ls $copyDir/${i%%/}-$arch/*-$hash.7z 1> /dev/null 2>&1; then
 
	if [ ! -f "rdv40.txt" ]; then
		jobs=1
	fi
 
    make clean
	make all -j$jobs
	
	if [ $? -eq 0 ]; then
	  rm -rf $buildDir/${i%%/}/*
	  mkdir -p $copyDir/${i%%/}-$arch/
	  mkdir -p $buildDir/${i%%/}/win$arch/platforms
	  mkdir -p $buildDir/${i%%/}/firmware_win/bootrom
	  mkdir -p "$buildDir/${i%%/}/firmware_win/JTAG Only"
	  mkdir -p "$buildDir/${i%%/}/Windows Driver"

	  ldd $pm3Dir/${i%%/}/client/proxmark3.exe | grep "=> /mingw" | awk '{print $3}' | xargs -I '{}' cp -v '{}' $buildDir/${i%%/}/win$arch
	  cp -r /ps/autobuild/* $buildDir/${i%%/}/win$arch
	  cp -r $pm3Dir/${i%%/}/client/{proxmark3.exe,flasher.exe,*.dic,lualibs,scripts,pyscripts,luascripts,lualibs,hardnested,dictionaries,resources} $buildDir/${i%%/}/win$arch
	  cp $mingwDir/share/qt5/plugins/platforms/qwindows.dll $buildDir/${i%%/}/win$arch/platforms
	  cp $pm3Dir/${i%%/}/armsrc/obj/{fullimage.elf,fullimage.s19} $buildDir/${i%%/}/firmware_win
	  cp $pm3Dir/${i%%/}/bootrom/obj/{bootrom.elf,bootrom.s19} $buildDir/${i%%/}/firmware_win/bootrom
	  cp $pm3Dir/${i%%/}/recovery/{bootrom.bin,fullimage.bin,proxmark3_recovery.bin} "$buildDir/${i%%/}/firmware_win/JTAG Only"
	  cp $pm3Dir/${i%%/}/driver/proxmark3.inf "$buildDir/${i%%/}/Windows Driver"
	  rm $buildDir/${i%%/}/win$arch/hardnested/{*.h,*.c}
	  cd $buildDir/${i%%/}
	  7z a -r -mx9 $copyDir/${i%%/}-$arch/${i%%/}-$arch-$date-$hash.7z ./*
	  echo done
	fi
  fi
done