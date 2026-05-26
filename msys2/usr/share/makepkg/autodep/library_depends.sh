#!/usr/bin/bash
#
#   library_depends.sh - Automatically add library requirements to depends
#
#   Copyright (c) 2021-2024 Pacman Development Team <pacman-dev@lists.archlinux.org>
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

[[ -n "$LIBMAKEPKG_AUTODEP_LIBRARY_DEPENDS_SH" ]] && return
LIBMAKEPKG_AUTODEP_LIBRARY_DEPENDS_SH=1

MAKEPKG_LIBRARY=${MAKEPKG_LIBRARY:-'/usr/share/makepkg'}

# autodep_functions+=('library_depends')

library_depends() {
	if check_option "autodeps" "y"; then
		local dep filename libdeps libdir libpath prefix sofile
		declare -a libdeps

		while IFS= read -rd '' filename; do
			for sofile in $(LC_ALL=C readelf -d $filename 2>/dev/null | sed -nr 's/.*Shared library: \[(.*)\].*/\1/p'); do
				# get the full path of the library
				libpath=$(ldd $filename | sed -nr "s/.$sofile => (.*) \(.*\)/\1/p")

				# if ldd can not find the library, it is likely part of the package and not in filesystem
				if [[ -z $libpath ]]; then
					continue
				fi

				# skip if the library is part of the package
				if [[ -e "$pkgdir/$libpath" ]]; then
					continue
				fi

				# find the prefix for the dependency
				libpath=${libpath#/}
				libpath=${libpath%/*}

				unset prefix
				for libdir in ${LIB_DIRS[@]}; do
					if [[ ${libdir/*:} == ${libpath} ]]; then
						prefix=${libdir/:*}
					fi
				done

				if [[ -z ${prefix} ]]; then
					continue
				fi

				# only add library dependency if it exists - this helps bootstraping dependencies
				if [[ $(run_pacman -T "$prefix:$sofile") ]]; then
					continue
				fi

				libdeps+=("$prefix:$sofile")
			done

		done < <(find "$pkgdir" -type f -perm -u+x -print0)

		depends+=($(printf '%s\n' "${libdeps[@]}" | LC_ALL=C sort -u))
	fi
}
