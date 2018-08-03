# Pactoys Recipe Library
# Copyright (C) 2016 Renato Silva
# Licensed under BSD

declare -Ag pactoys
test -n "${pactoys[module.recipe]}" && return
pactoys[module.recipe]=1

source "${PACTOYS_LIBRARY:-/usr/share/pactoys/library}/default.sh" || return
source "${PACTOYS_LIBRARY:-/usr/share/pactoys/library}/output.sh"  || return
source "${PACTOYS_LIBRARY:-/usr/share/pactoys/library}/util.sh"    || return

pactoys_recipe_location() {
    local recipe="${1}"
    local -n nameref_location="${2}"
    if [[ "${recipe}" = */* ]]
        then nameref_location="${recipe%/*}"
        else nameref_location="${PWD}"
    fi
}

pactoys_recipe_folder() {
    local recipe="${1}"
    local -n nameref_name="${2}"
    pactoys_recipe_location "${recipe}" nameref_name
    while [[ "${nameref_name}" = */ ]]; do
        nameref_name="${nameref_name%/}"
    done
    nameref_name="${nameref_name##*/}"
}

pactoys_recipe_type() {
    local -n nameref_type="${1}"
    local -n nameref_pkgname="${2}"
    local -n nameref_arch="${3}"
    local name
    test -n "${nameref_pkgname}" || return 1
    for name in "${nameref_pkgname[@]}"; do
        if [[ "${name}" != mingw-w64-* ]]; then
            nameref_type='unix'
            return 0
        fi
    done
    if [[ "${nameref_arch[@]}" = any ]]
        then nameref_type='mingw'
        else nameref_type='unix'
    fi
    return 0
}

pactoys_recipe_info() {
    local recipe="${1}"
    local -a properties=("${@:2}")
    local property
    for property in "${properties[@]}"; do
        local -n nameref_property="${property#*:}"
        property="${property%:*}"
        nameref_property=()
        pactoys_lines_to_list nameref_property "$(
            MINGW_PACKAGE_PREFIX='mingw-w64'
            PATH=".:${PATH}" source "${recipe}"
            declare -n nameref_property="${property}"
            printf '%s\n' "${nameref_property[@]}")"
    done
}

pactoys_package_name() {
    local recipe="${1}"
    local pkgbase="${2}"
    local pkgname="${3}"
    local -n nameref_name="${4}"
    local name directory
    pactoys_recipe_folder "${recipe}" directory
    name="${pkgbase:-${pkgname}}"
    nameref_name="${name:-<unknown>} (${directory})"
    nameref_name="${nameref_name% (${name})}"
}

pactoys_find_recipes() {
    local -n nameref_recipes="${1}"
    local recipe_name="${2}"
    local maintainer="${3}"
    local directories=("${@:4}")
    if test -n "${maintainer}"; then
        local email="$(pactoys_noiseless git config user.email)"
        maintainer="^#.*Maintainer.*:.*[<(]?${email}[)>]?"
        if test -z "${email}"; then
            pactoys[error]='failed detecting maintainer from git'
            return 1
        fi
    fi
    pactoys_find_files nameref_recipes "${recipe_name}" "${maintainer}" "${directories[@]}" || return 1
    if test -z "${nameref_recipes}"; then
        pactoys[error]='no recipes found'
        return 1
    fi
}
