#!/usr/bin/bash
#
#   pkgbuild.sh - functions to extract information from PKGBUILD files
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

[[ -n "$LIBMAKEPKG_UTIL_PKGBUILD_SH" ]] && return
LIBMAKEPKG_UTIL_PKGBUILD_SH=1


have_function() {
	declare -f "$1" >/dev/null
}

grep_function() {
	{ declare -f "$1" || declare -f package; } 2>/dev/null | grep -E "$2"
}

array_build() {
	local dest=$1 src=$2 i keys values

	# it's an error to try to copy a value which doesn't exist.
	declare -p "$2" &>/dev/null || return 1

	# Build an array of the indicies of the source array.
	eval "keys=(\"\${!$2[@]}\")"

	# Clear the destination array
	eval "$dest=()"

	# Read values indirectly via their index. This approach gives us support
	# for associative arrays, sparse arrays, and empty strings as elements.
	for i in "${keys[@]}"; do
		values+=("printf -v '$dest[$i]' %s \"\${$src[$i]}\";")
	done

	eval "${values[*]}"
}

extract_global_variable() {
	# $1: variable name
	# $2: multivalued
	# $3: name of output var

	local attr=$1 isarray=$2 outputvar=$3 ref

	if (( isarray )); then
		array_build ref "$attr"
		[[ ${ref[@]} ]] && array_build "$outputvar" "$attr"
	else
		[[ ${!attr} ]] && printf -v "$outputvar" %s "${!attr}"
	fi
}

extract_function_variable() {
	# $1: function name
	# $2: variable name
	# $3: multivalued
	# $4: name of output var

	local funcname=$1 attr=$2 isarray=$3 outputvar=$4 attr_regex= decl= r=1

	if (( isarray )); then
		printf -v attr_regex '^[[:space:]]* %s\+?=\(' "$2"
	else
		printf -v attr_regex '^[[:space:]]* %s\+?=[^(]' "$2"
	fi

	while read -r; do
		# strip leading whitespace and any usage of declare
		decl=${REPLY##*([[:space:]])}
		eval "${decl/#$attr/$outputvar}"

		# entering this loop at all means we found a match, so notify the caller.
		r=0
	done < <(grep_function "$funcname" "$attr_regex")

	return $r
}

get_pkgbuild_attribute() {
	# $1: package name
	# $2: attribute name
	# $3: multivalued
	# $4: name of output var

	local pkgname=$1 attrname=$2 isarray=$3 outputvar=$4

	printf -v "$outputvar" %s ''

	if [[ $pkgname ]]; then
		extract_global_variable "$attrname" "$isarray" "$outputvar"
		extract_function_variable "package_$pkgname" "$attrname" "$isarray" "$outputvar"
	else
		extract_global_variable "$attrname" "$isarray" "$outputvar"
	fi
}

##
#  usage : get_full_version()
# return : full version spec, including epoch (if necessary), pkgver, pkgrel
##
get_full_version() {
	if (( epoch > 0 )); then
		if [[ -n $MSYSTEM ]]; then
			printf "%s\n" "${epoch}~${pkgver}-${pkgrel}"
		else
			printf "%s\n" "$epoch:$pkgver-$pkgrel"
		fi
	else
		printf "%s\n" "$pkgver-$pkgrel"
	fi
}

##
#  usage : get_pkg_arch( [$pkgname] )
# return : architecture of the package
##
get_pkg_arch() {
	if [[ -z $1 ]]; then
		if [[ $arch = "any" ]]; then
			printf "%s\n" "any"
		else
			printf "%s\n" "$CARCH"
		fi
	else
		local arch_override
		get_pkgbuild_attribute "$1" arch 1 arch_override
		(( ${#arch_override[@]} == 0 )) && arch_override=("${arch[@]}")
		if [[ $arch_override = "any" ]]; then
			printf "%s\n" "any"
		else
			printf "%s\n" "$CARCH"
		fi
	fi
}

print_all_package_names() {
	local version=$(get_full_version)
	local architecture pkg opts a
	for pkg in ${pkgname[@]}; do
		get_pkgbuild_attribute "$pkg" 'arch' 1 architecture
		get_pkgbuild_attribute "$pkg" 'options' 1 opts
		for a in ${architecture[@]}; do
			printf "%s-%s-%s\n" "$pkg" "$version" "$a"
			if in_opt_array "debug" ${opts[@]} && in_opt_array "strip" ${opts[@]}; then
				printf "%s-%s-%s-%s\n" "$pkg" "debug" "$version" "$a"
			fi
		done
	done
}

get_all_sources() {
	local aggregate l a

	if array_build l 'source'; then
		aggregate+=("${l[@]}")
	fi

	for a in "${arch[@]}"; do
		if array_build l "source_$a"; then
			aggregate+=("${l[@]}")
		fi
	done

	array_build "$1" "aggregate"
}

get_all_sources_for_arch() {
	local aggregate l

	if array_build l 'source'; then
		aggregate+=("${l[@]}")
	fi

	if array_build l "source_$CARCH"; then
		aggregate+=("${l[@]}")
	fi

	array_build "$1" "aggregate"
}
