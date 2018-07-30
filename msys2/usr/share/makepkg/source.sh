#!/usr/bin/bash
#
#   source.sh - functions for downloading and extracting sources
#
#   Copyright (c) 2015-2016 Pacman Development Team <pacman-dev@archlinux.org>
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

[[ -n "$LIBMAKEPKG_SOURCE_SH" ]] && return
LIBMAKEPKG_SOURCE_SH=1

LIBRARY=${LIBRARY:-'/usr/share/makepkg'}

source "$LIBRARY/util/message.sh"
source "$LIBRARY/util/pkgbuild.sh"
source "$LIBRARY/util/source.sh"


for lib in "$LIBRARY/source/"*.sh; do
	source "$lib"
done


download_sources() {
	local netfile all_sources
	local get_source_fn=get_all_sources_for_arch get_vcs=1

	msg "$(gettext "Retrieving sources...")"

	while true; do
		case $1 in
			allarch)
				get_source_fn=get_all_sources
				;;
			novcs)
				get_vcs=0
				;;
			*)
				break 2
				;;
		esac
		shift
	done

	"$get_source_fn" 'all_sources'
	for netfile in "${all_sources[@]}"; do
		pushd "$SRCDEST" &>/dev/null

		local proto=$(get_protocol "$netfile")
		case "$proto" in
			local)
				download_local "$netfile"
				;;
			bzr*)
				(( get_vcs )) && download_bzr "$netfile"
				;;
			git*)
				(( get_vcs )) && download_git "$netfile"
				;;
			hg*)
				(( get_vcs )) && download_hg "$netfile"
				;;
			svn*)
				(( get_vcs )) && download_svn "$netfile"
				;;
			*)
				download_file "$netfile"
				;;
		esac

		popd &>/dev/null
	done
}

extract_sources() {
	msg "$(gettext "Extracting sources...")"
	local netfile all_sources

	get_all_sources_for_arch 'all_sources'
	for netfile in "${all_sources[@]}"; do
		local file=$(get_filename "$netfile")
		local proto=$(get_protocol "$netfile")
		case "$proto" in
			bzr*)
				extract_bzr "$netfile"
				;;
			git*)
				extract_git "$netfile"
				;;
			hg*)
				extract_hg "$netfile"
				;;
			svn*)
				extract_svn "$netfile"
				;;
			*)
				extract_file "$file"
				;;
		esac
	done
}
