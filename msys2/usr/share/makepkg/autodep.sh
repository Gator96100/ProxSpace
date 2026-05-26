#!/usr/bin/bash
#
#   autodep.sh - functions for automatically adding depends/provides
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

[[ -n "$LIBMAKEPKG_AUTODEP_SH" ]] && return
LIBMAKEPKG_AUTODEP_SH=1

MAKEPKG_LIBRARY=${MAKEPKG_LIBRARY:-'/usr/share/makepkg'}

declare -a autodep_functions

for lib in "$MAKEPKG_LIBRARY/autodep/"*.sh; do
	source "$lib"
done

readonly -a autodep_functions

generate_autodeps() {
	for func in ${autodep_functions[@]}; do
		$func
	done
}
