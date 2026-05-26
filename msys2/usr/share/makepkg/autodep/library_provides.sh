#!/usr/bin/bash
#
#   library_provides.sh - Automatically add a packages libraries to provides
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

[[ -n "$LIBMAKEPKG_AUTODEP_LIBRARY_PROVIDES_SH" ]] && return
LIBMAKEPKG_AUTODEP_LIBRARY_PROVIDES_SH=1

MAKEPKG_LIBRARY=${MAKEPKG_LIBRARY:-'/usr/share/makepkg'}

# autodep_functions+=('library_provides')

library_provides() {
	if check_option "autodeps" "y"; then
		for lib in ${LIB_DIRS[@]}; do
			dir=${lib/*:}
			prefix=${lib/:*}

			if [[ ! -d "$pkgdir/$dir" ]]; then
				continue;
			fi

			mapfile -t filenames < <(find "$pkgdir/$dir" -maxdepth 1 -type f | LC_ALL=C sort)

			for fn in "${filenames[@]}"; do
				# check we have a shared library
				if LC_ALL=C readelf -h "$fn" 2>/dev/null | grep -q '.*Type:.*DYN (Shared object file).*'; then
					# extract library soname
					local sofile=$(LC_ALL=C readelf -d "$fn" 2>/dev/null | sed -n 's/.*Library soname: \[\(.*\)\].*/\1/p')

					if [[ -z "$sofile" ]]; then
						# the library has no soname
						continue
					fi

					provides+=("$prefix:$sofile")
				fi
			done
		done
	fi
}
