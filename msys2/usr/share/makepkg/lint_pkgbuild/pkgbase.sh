#!/usr/bin/bash
#
#   pkgbase.sh - Check the 'pkgbase' variable conforms to requirements.
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

[[ -n "$LIBMAKEPKG_LINT_PKGBUILD_PKGBASE_SH" ]] && return
LIBMAKEPKG_LINT_PKGBUILD_PKGBASE_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"


lint_pkgbuild_functions+=('lint_pkgbase')


lint_pkgbase() {
	local ret=0

	if [[ ${pkgbase:0:1} = "-" ]]; then
		error "$(gettext "%s is not allowed to start with a hyphen.")" "pkgname"
		return 1
	fi
	if [[ ${pkgbase:0:1} = "." ]]; then
		error "$(gettext "%s is not allowed to start with a dot.")" "pkgbase"
		ret=1
	fi
	if [[ $pkgbase = *[^[:alnum:]+_.@-]* ]]; then
		error "$(gettext "%s contains invalid characters: '%s'")" \
				'pkgbase' "${i//[[:alnum:]+_.@-]}"
		ret=1
	fi

	return $ret
}
