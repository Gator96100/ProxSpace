#!/bin/bash

usage() { tee <<done-usage

    Makepatch 2016.6.24
    Copyright (C) 2016 Renato Silva
    Licensed under BSD

    Usage: ${name} init DIRECTORY
        Prepare for creating or modifying patches, by moving the original source
        DIRECTORY to patches and applying any existing patches. The consolidate
        function from PKGBUILD is executed before patching, if defined.

    Usage: ${name} diff NUMBER
        Show the current diff for the given zero-padded patch NUMBER.

    Usage: ${name} refresh [PATCH]...
        Refresh the given PATCH files or all patches with their current diff,
        and update the package recipe checksums.

done-usage
exit 1; }

msg2() {
    local message="${1}"
    local arguments=("${@:2}")
    printf "${message}\n" "${arguments[@]}"
}

status(){
    local message="${1}"
    printf "${colors_stdout[blue]}::"
    printf "${colors_stdout[white]} %s" "${message}"
    printf "${colors_stdout[normal]}\n"
}

validate_number() {
    local number="${1}"
    [[ "${number}" -gt 0 && "${number}" =~ ^[0-9]+$ ]] && return 0
    terminate "invalid patch number ${number}"
}

init() {
    local directory="${1}"
    local patches=(*.patch)
    test -d "${directory}" || terminate "missing directory ${directory}"
    silent mkdir patches   || terminate 'failed creating patches directory'
    if test -f "${patches}"; then
        if [[ "${patches}" =~ ^[0-9]+[-_] ]]
            then local patch_number="${patches%%[-_]*}"
                 local current="${patch_number//[0-9]/0}"
            else local current='000'
        fi
    else
        patches=()
    fi
    unset -f consolidate
    silent source PKGBUILD
    if is_function consolidate; then
        status 'Consolidating sources'
        cd "${directory}"
        consolidate || terminate 'failed consolidating sources'
        silent cd -
    fi
    silent mv "${directory}" "patches/${current}" &&
    for patch in "${patches[@]}"; do
        status "Applying ${patch}"
        local number="${patch%%[-_]*}"
        validate_number "${number}"
        cd patches
        cp -r "${current}" "${number}"
        cd "${number}"
        patch -p1 -i "../../${patch}" || terminate "failed applying ${patch}"
        find -name '*.orig' -delete
        current="${number}"
        cd ../..
    done
}

diff() {
    local current="${1}"
    validate_number "${current}"
    local previous=$((current - 1))
    previous="$(printf "%0${#current}s" "${previous}")"
    test -d "patches/${current}"  || terminate "missing files for ${current}"
    test -d "patches/${previous}" || terminate "missing files for ${previous}"
    cd patches
    local diff="$(command diff -aurN "${previous}" "${current}" | sed -r 's/^([+-]{3}.*)\t.*/\1/')"
    local result=${?}
    cd ..
    if test -t 1
        then echo "${diff}" | colordiff
        else echo "${diff}"
    fi
    return ${result}
}

refresh() {
    local patches=("${@}")
    if test -z "${patches}"; then
        for patch in *.patch; do
            test -f "${patch}" && patches+=("${patch}")
        done
        test -n "${patches}" || terminate 'no patches found'
    fi
    for patch in "${patches[@]}"; do
        test -f "${patch}" || terminate "missing file ${patch}"
        status "Refreshing ${patch}"
        local number="${patch%%[-_]*}"
        diff "${number}" > "${patch}" || return
    done
    status 'Updating checksums'
    updpkgsums --nocolor
}

pactoys_options='color.simple'
source pactoys || exit

import colorize
import colors_stdout
import is_function
import silent
import terminate

command="${1}"
arguments=("${@:2}")
name="$(basename "${0}")"
colorize

[[ "${command}" =~ ^(init|diff|refresh)$ ]] || usage
[[ "${command}" =~ ^(init|diff)$ && -z "${arguments}" ]] && usage
"${command}" "${arguments[@]}"
