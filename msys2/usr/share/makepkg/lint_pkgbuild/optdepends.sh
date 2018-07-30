#!/usr/bin/bash
#
#   optdepends.sh - Check the 'optdepends' array conforms to requirements.
#
#   Copyright (c) 2014-2016 Pacman Development Team <pacman-dev@archlinux.org>
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

[[ -n "$LIBMAKEPKG_LINT_PKGBUILD_OPTDEPENDS_SH" ]] && return
LIBMAKEPKG_LINT_PKGBUILD_OPTDEPENDS_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/pkgbuild.sh"


lint_pkgbuild_functions+=('lint_optdepends')


lint_optdepends() {
	local a list name optdepends_list ret=0

	optdepends_list=("${optdepends[@]}")
	for a in "${arch[@]}"; do
		array_build list "optdepends_$a"
		optdepends_list+=("${list[@]}")
	done

	for name in "${pkgname[@]}"; do
		if extract_function_variable "package_$name" optdepends 1 list; then
			optdepends_list+=("${list[@]}")
		fi

		for a in "${arch[@]}"; do
			if extract_function_variable "package_$name" "optdepends_$a" 1 list; then
				optdepends_list+=("${list[@]}")
			fi
		done
	done

	for name in "${optdepends_list[@]}"; do
		local pkg=${name%%:[[:space:]]*}
		# the '-' character _must_ be first or last in the character range
		if [[ $pkg != +([-[:alnum:]><=.+_:]) ]]; then
			error "$(gettext "Invalid syntax for %s: '%s'")" "optdepend" "$name"
			ret=1
		fi
	done

	return $ret
}
