#!/usr/bin/bash
#
#   rust.sh - Specify flags for building a package with rust
#
#   Copyright (c) 2022-2024 Pacman Development Team <pacman-dev@lists.archlinux.org>
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

[[ -n "$LIBMAKEPKG_BUILDENV_RUST_SH" ]] && return
LIBMAKEPKG_BUILDENV_RUST_SH=1

MAKEPKG_LIBRARY=${MAKEPKG_LIBRARY:-'/usr/share/makepkg'}

source "$MAKEPKG_LIBRARY/util/option.sh"
source "$MAKEPKG_LIBRARY/util/util.sh"

buildenv_vars+=('RUSTFLAGS' 'DEBUG_RUSTFLAGS')
buildenv_functions+=('buildenv_rust')

buildenv_rust() {
	if check_option "debug" "y" && ! check_option "buildflags" "n"; then
		append_once DEBUG_RUSTFLAGS "--remap-path-prefix=$srcdir=${DBGSRCDIR:-/usr/src/debug}/${pkgbase}"
		append_once RUSTFLAGS "$DEBUG_RUSTFLAGS"
	fi
}