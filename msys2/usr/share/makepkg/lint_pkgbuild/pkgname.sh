#!/usr/bin/bash
#
#   pkgname.sh - Check the 'pkgname' variable conforms to requirements.
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

[[ -n "$LIBMAKEPKG_LINT_PKGBUILD_PKGNAME_SH" ]] && return
LIBMAKEPKG_LINT_PKGBUILD_PKGNAME_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"


lint_pkgbuild_functions+=('lint_pkgname')


lint_pkgname() {
	local ret=0 i

	for i in "${pkgname[@]}"; do
		if [[ -z $i ]]; then
			error "$(gettext "%s is not allowed to be empty.")" "pkgname"
			ret=1
			continue
		fi
		if [[ ${i:0:1} = "-" ]]; then
			error "$(gettext "%s is not allowed to start with a hyphen.")" "pkgname"
			ret=1
		fi
		if [[ ${i:0:1} = "." ]]; then
			error "$(gettext "%s is not allowed to start with a dot.")" "pkgname"
			ret=1
		fi
		if [[ $i = *[^[:alnum:]+_.@-]* ]]; then
			error "$(gettext "%s contains invalid characters: '%s'")" \
					'pkgname' "${i//[[:alnum:]+_.@-]}"
			ret=1
		fi
	done

	return $ret
}
