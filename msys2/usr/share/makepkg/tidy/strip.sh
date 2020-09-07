#!/usr/bin/bash
#
#   strip.sh - Strip debugging symbols from binary files
#
#   Copyright (c) 2007-2020 Pacman Development Team <pacman-dev@archlinux.org>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

[[ -n "$LIBMAKEPKG_TIDY_STRIP_SH" ]] && return
LIBMAKEPKG_TIDY_STRIP_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/option.sh"


packaging_options+=('strip' 'debug')
tidy_modify+=('tidy_strip')


source_files() {
	LANG=C readelf "$1" --debug-dump | \
		awk '/DW_AT_name +:/{name=$8}/DW_AT_comp_dir +:/{{if (name == "<artificial>") next}{if (name !~ /^[<\/]/) {printf "%s/", $8}}{print name}}'
}

strip_file() {
	local binary=$1; shift

	case "$(file -bi "$binary")" in
	*application/x-dosexec*)
		if check_option "debug" "y"; then
			if [[ -f "$dbgdir/$binary.debug" ]]; then
				return
			fi

			# copy source files to debug directory
			local file dest t
			while IFS= read -r t; do
				file=${t/${dbgsrcdir}/"$srcdir"}
				dest="${dbgsrc/"$dbgsrcdir"/}$t"
				if ! [[ -f $dest ]]; then
					mkdir -p "${dest%/*}"
					cp -- "$file" "$dest"
				fi
			done < <(source_files "$binary")

			# copy debug symbols to debug directory
			mkdir -p "$dbgdir/${binary%/*}"
			msg2 "Separating debug info from $binary into $dbgdir/$binary.debug"
			# create a dbg file with proper debug info:
			objcopy --only-keep-debug "$binary" "$dbgdir/$binary.debug"

			msg2 "Creating a debuginfo link to $dbgdir/$binary.debug in $binary"
			objcopy --add-gnu-debuglink="$dbgdir/${binary#/}.debug" "$binary"

			msg2 "Separating (again) debug info from $binary into $dbgdir/$binary.debug"
			objcopy --only-keep-debug "$binary" "$dbgdir/$binary.debug"

			msg2 "Removing old .gnu_debuglink section from $binary"
			objcopy --remove-section=.gnu_debuglink "$binary"

			# strip debug-info from the original file
			objcopy --strip-debug "$binary"
			msg2 "Creating (again) a debuginfo link to $dbgdir/$binary.debug in $binary"
			objcopy --add-gnu-debuglink="$dbgdir/${binary#/}.debug" "$binary"
			# This way dbg file gets a .gnu_debuglink section (doesn't matter where
			# it's pointing), and its contents pass the CRC32 check

			# create any needed hardlinks
			while IFS= read -rd '' file ; do
				if [[ "${binary}" -ef "${file}" && ! -f "$dbgdir/${file}.debug" ]]; then
					mkdir -p "$dbgdir/${file%/*}"
					ln "$dbgdir/${binary}.debug" "$dbgdir/${file}.debug"
				fi
			done < <(find . -type f -perm -u+w -print0 2>/dev/null)

		fi
		;;
	esac

	strip $@ "$binary"
}


tidy_strip() {
	if check_option "strip" "y"; then
		msg2 "$(gettext "Stripping unneeded symbols from binaries and libraries...")"
		# make sure library stripping variables are defined to prevent excess stripping
		[[ -z ${STRIP_SHARED+x} ]] && STRIP_SHARED="-S"
		[[ -z ${STRIP_STATIC+x} ]] && STRIP_STATIC="-S"

		if check_option "debug" "y"; then

			dbgdir="$pkgdirbase/$pkgbase-debug"
			dbgsrcdir="${DBGSRCDIR:-/usr/src/debug}"
			dbgsrc="$pkgdirbase/$pkgbase-debug$dbgsrcdir"
			mkdir -p "$dbgdir" "$dbgsrc"
		fi

		local binary strip_flags
		# *.so: Apache2 modules, OCaml stublibs, Ruby modules
		# *.oct: Octave modules
		# *.cmxs: OCaml natdynlink modules: http://gallium.inria.fr/~frisch/ndl.txt
		find * -type f ! -name '*.dll.a' ! -name '*.lib' \
			-a \( -name '*.a' -o -name '*.dll' -o -name '*.exe' -o -name '*.so' -o -name '*.so.*' -o -name '*.oct' -o -name '*.cmxs' \) -print0 \
			-o -type f -executable ! -name '*.dll' ! -name '*.exe' ! -name '*.so' ! -name '*.so.[0-9]*' ! -name '*.oct' ! -name '*.cmxs' ! -name '*.a' ! -name '*.la' ! -name '*.lib' ! -name '*.exe.manifest' ! -name '*.exe.config' ! -name '*.dll.config' ! -name '*.mdb' ! -name '*-config' ! -name '*.csh' ! -name '*.sh' ! -name '*.pl' ! -name '*.pm' ! -name '*.py' ! -name '*.rb' ! -name '*.tcl' -print0 | \
		while IFS= read -d $'\0' binary
		do
			# Skip thin archives from stripping
			case "${binary##*/}" in
				*.a)
					if [ "$(head -c 7 "${binary}")" = '!<thin>' ]
					then
						continue
					fi
				;;
			esac

			# assure this is actually a binary object
			if [ "$(head -c 2 "${binary}")" = '#!' ]
			then
				# sometimes .exe will be appended where it does not belong
				case "${exe}" in
					usr/lib/hevea/*.exe) ;;
					*.exe)	mv "${binary}" "${binary%.exe}" ;;
				esac
				continue
			fi

			# OCaml bytecode must not be stripped
			# Magic number is at end of file:
			# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=256900#74
			# http://cygwin.com/ml/cygwin-apps/2010-10/msg00057.html
			#
			# Perl Archive (PAR) binaries must not be stripped
			# https://rt.cpan.org/Public/Bug/Display.html?id=18536
			# http://cygwin.com/ml/cygwin-apps/2012-07/msg00088.html
			case $(tail -c 12 "${binary}" | tr '\012\0' '%') in
				%PAR\.pm%)  continue ;;
				Caml1999X0[0-9][0-9])  continue ;;
			esac

			# Mono assemblies must not be stripped, but remove .mdb debug symbols,
			# and make them non-executable so they're not launched by MS .NET
			if LC_ALL=C file -b "${binary}" 2>&1 | grep -q "Mono/\.Net assembly"
			then
				chmod 0644 "${binary}"
				rm -f "${binary}.mdb"
				continue
			fi

			# check for .exe from non-automake Makefile which install(1) didn't fix
			# strip(1) used to take care of this, but not anymore
			case ${CHOST} in
			*-*-cygwin*|*-*-mingw*|*-*-msys*)
				case "${binary##*/}" in
				*.dll|*.exe|*.sfx|*.so|*.so.[0-9]*|*.oct|*.cmxs) ;;
				# make sure this isn't some oddly named DLL
				*)	if LANG=en_US.UTF-8 LC_ALL=C objdump -f "${binary}" | grep -Eq '^start address 0x(0000000[01])?00401[0-9a-e][0-9a-e]0'
					then
						mv "${binary}" "${binary}.exe"
						binary+=.exe
					fi ;;
				esac
				;;
			esac
			chmod 0755 "${binary}";

			case "$(file -S -bi "$binary")" in
				*application/x-dosexec*) # Windows executables and dlls
					strip_flags="$STRIP_SHARED";;
				*application/x-sharedlib*)  # Libraries (.so)
					strip_flags="$STRIP_SHARED";;
				*application/x-archive*)    # Libraries (.a)
					strip_flags="$STRIP_STATIC";;
				*application/x-object*)
					case "$binary" in
						*.ko)                   # Kernel module
							strip_flags="$STRIP_SHARED";;
						*)
							continue;;
					esac;;
				*application/x-executable*) # Binaries
					strip_flags="$STRIP_BINARIES";;
				*application/x-pie-executable*)  # Relocatable binaries
					strip_flags="$STRIP_SHARED";;
				*)
					continue ;;
			esac
			strip_file "$binary" ${strip_flags}
		done
	fi
}
