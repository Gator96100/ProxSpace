#!/usr/bin/bash
#
#   buildenv.sh - functions for altering the build environment before
#   compilation
#
#   Copyright (c) 2015-2024 Pacman Development Team <pacman-dev@lists.archlinux.org>
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

[[ -n "$LIBMAKEPKG_BUILDENV_SH" ]] && return
LIBMAKEPKG_BUILDENV_SH=1

MAKEPKG_LIBRARY=${MAKEPKG_LIBRARY:-'/usr/share/makepkg'}

declare -a buildenv_functions build_options
buildenv_vars=('CPPFLAGS' 'CFLAGS' 'CXXFLAGS' 'LDFLAGS')

for lib in "$MAKEPKG_LIBRARY/buildenv/"*.sh; do
	source "$lib"
done

readonly -a buildenv_functions buildenv_vars build_options

prepare_buildenv() {
	# ensure this function runs first
	buildenv_buildflags

	for func in ${buildenv_functions[@]}; do
		$func
	done

	# ensure all necessary build variables are exported
	export ${buildenv_vars[@]} CC CXX CHOST MAKEFLAGS
}
