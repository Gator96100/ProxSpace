#!/usr/bin/bash
#
#   compress.sh - functions to compress archives in a uniform manner
#
#   Copyright (c) 2017-2020 Pacman Development Team <pacman-dev@archlinux.org>
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

[[ -n "$LIBMAKEPKG_UTIL_COMPRESS_SH" ]] && return
LIBMAKEPKG_UTIL_COMPRESS_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"


# Wrapper around many stream compression formats, for use in the middle of a
# pipeline. A tar archive is passed on stdin and compressed to stdout.
compress_as() {
	# $1: final archive filename extension for compression type detection

	local ext=".tar${1##*.tar}"

	case "$ext" in
		*.tar.gz)  ${COMPRESSGZ[@]:-gzip -c -f -n} ;;
		*.tar.bz2) ${COMPRESSBZ2[@]:-bzip2 -c -f} ;;
		*.tar.xz)  ${COMPRESSXZ[@]:-xz -c -z -} ;;
		*.tar.zst) ${COMPRESSZST[@]:-zstd -c -z -q -} ;;
		*.tar.lrz) ${COMPRESSLRZ[@]:-lrzip -q} ;;
		*.tar.lzo) ${COMPRESSLZO[@]:-lzop -q} ;;
		*.tar.Z)   ${COMPRESSZ[@]:-compress -c -f} ;;
		*.tar.lz4) ${COMPRESSLZ4[@]:-lz4 -q} ;;
		*.tar.lz)  ${COMPRESSLZ[@]:-lzip -c -f} ;;
		*.tar)     cat ;;
		*) warning "$(gettext "'%s' is not a valid archive extension.")" \
			"$ext"; cat ;;
	esac
}
