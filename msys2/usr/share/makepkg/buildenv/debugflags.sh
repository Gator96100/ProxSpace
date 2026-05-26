#!/usr/bin/bash
#
#   debugflags.sh - Specify flags for building a package with debugging
#   symbols
#
#   Copyright (c) 2012-2024 Pacman Development Team <pacman-dev@lists.archlinux.org>
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

[[ -n "$LIBMAKEPKG_BUILDENV_DEBUGFLAGS_SH" ]] && return
LIBMAKEPKG_BUILDENV_DEBUGFLAGS_SH=1

MAKEPKG_LIBRARY=${MAKEPKG_LIBRARY:-'/usr/share/makepkg'}

source "$MAKEPKG_LIBRARY/util/option.sh"
source "$MAKEPKG_LIBRARY/util/util.sh"

buildenv_functions+=('buildenv_debugflags')

buildenv_debugflags() {
	if check_option "debug" "y" && ! check_option "buildflags" "n"; then
		append_once DEBUG_CFLAGS "-ffile-prefix-map=$srcdir=${DBGSRCDIR:-/usr/src/debug}/${pkgbase}"
		append_once DEBUG_CXXFLAGS "-ffile-prefix-map=$srcdir=${DBGSRCDIR:-/usr/src/debug}/${pkgbase}"
		append_once CFLAGS "$DEBUG_CFLAGS"
		append_once CXXFLAGS "$DEBUG_CXXFLAGS"
	fi
}
