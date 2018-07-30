# Pactoys Util Library
# Copyright (C) 2016 Renato Silva
# Licensed under BSD

declare -Ag pactoys
test -n "${pactoys[module.util]}" && return
pactoys[module.util]=1

source "${PACTOYS_LIBRARY:-/usr/share/pactoys/library}/default.sh" || return

pactoys_separate() {
    local items="${1}"
    local columns=("${@:2}")
    local column
    for column in "${columns[@]}"; do
        local -n nameref_column="${column}"
        if [[ "${items}" = *::* ]]; then
            nameref_column="${items%%::*}"
            items="${items#*::}"
        elif test -z "${items}"
            then nameref_column=
            else nameref_column="${items}" items=
        fi
    done
}

pactoys_lines_to_list() {
    local -n nameref_list="${1}"
    local _pactoys_lines="${2}"
    local _pactoys_strip="${3}"
    nameref_list=()
    while IFS= read -r line; do
        test -z "${line}" && continue
        nameref_list+=("${line/${_pactoys_strip}/}")
    done <<< "${_pactoys_lines}"
}

pactoys_path_to_list() {
    local -n nameref_list="${1}"
    local _pactoys_path="${2}"
    local _pactoys_current
    nameref_list=()
    while [[ "${_pactoys_path}" = *:* ]]; do
        _pactoys_current="${_pactoys_path%%:*}"
        _pactoys_path="${_pactoys_path#*:}"
        test -n "${_pactoys_current}" || continue
        nameref_list+=("${_pactoys_current}")
    done
    test -z "${_pactoys_path}" && return 0
    nameref_list+=("${_pactoys_path}")
}

pactoys_init_hash() {
    local -n nameref_hash="${1}"
    local value="${2}"
    local keys=("${@:3}")
    local key
    for key in "${keys[@]}"; do
        nameref_hash[${key}]="${value}"
    done
}

pactoys_merge_hash() {
    local -n nameref_target="${1}"
    local -n nameref_origin="${2}"
    local key
    for key in "${!nameref_origin[@]}"; do
        nameref_target[${key}]="${nameref_origin[${key}]}"
    done
}

pactoys_print_hash() {
    local -n nameref_hash="${1}"
    local format="${2:-list}"
    local key
    case "${format}" in
        table) format='%-30s %s\n' ;;
        list)  format='%s: %s\n'   ;;
    esac
    for key in "${!nameref_hash[@]}"; do
        printf "${format}" "${key}" "${nameref_hash[${key}]}"
    done | sort
}

pactoys_load_object() {
    local -n _pactoys_nameref_source="${1}"
    local -n _pactoys_nameref_object="${2}"
    local _pactoys_id="${3}"
    local -a _pactoys_properties=("${@:4}")
    local "${_pactoys_properties[@]}"
    local _pactoys_property
    _pactoys_nameref_object[id]="${_pactoys_id}"
    pactoys_separate "${_pactoys_nameref_source[${_pactoys_id}]}" "${_pactoys_properties[@]}"
    for _pactoys_property in "${_pactoys_properties[@]}"; do
        _pactoys_nameref_object[${_pactoys_property}]="${!_pactoys_property}"
    done
}

pactoys_filter() {
    local filter="${1}"
    local data="${2}"
    local pattern="${filter#not:}"
    [[ "${filter}" = not:* && "${data}" =~ ${pattern}     ]] && return 1
    [[ "${filter}" = not:* || "${data}" =~ ${pattern:-.*} ]]
}

pactoys_find_pattern() {
    local searched="${1}"
    local patterns=("${@:2}")
    local pattern
    for pattern in "${patterns[@]}"; do
        [[ "${searched}" =~ ${pattern} ]] && return 0
    done
    return 1
}

pactoys_find_files() {
    local -n nameref_files="${1}"
    local filename="${2}"
    local filter="${3}"
    local directories=("${@:4}")
    local directory
    nameref_files=()
    for directory in "${directories[@]:-.}"; do
        if ! test -d "${directory}"; then
            pactoys[error]="missing directory ‘${directory}’"
            return 1
        fi
    done
    if test -n "${filter}"
        then local options=(--recursive --files-with-match --extended-regexp --ignore-case --include="${filename}")
             nameref_files="$(pactoys_noiseless grep "${options[@]}" "${filter}" "${directories[@]}" | sort --ignore-case)"
        else nameref_files="$(pactoys_noiseless find "${directories[@]}" -type f -name "${filename}" | sort --ignore-case)"
    fi
    pactoys_lines_to_list nameref_files "${nameref_files}" '#./'
    return 0
}
