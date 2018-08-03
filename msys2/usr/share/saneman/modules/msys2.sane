# Saneman MSYS2 Module
# Copyright (C) 2016 Renato Silva
# Licensed under BSD

module[description]='MSYS2 packages module'

problems[unformatted:pkgdesc]='message'
problems[unrecognized:depends]='warning'

check_unrecognized_depends_mingw() {
    local normalized="${1}"
    local original="${2}"
    test -z "${normalized}" && return ${passed}
    [[ "${normalized}" = mingw-w64-* ]] && return ${passed}
    report "unix dependency ${original}"
}

check_unformatted_pkgdesc_mingw() {
    local normalized="${1}"
    local suffix='(mingw-w64)'
    test -z "${normalized}" && return ${passed}
    [[ "${normalized}" =~ ^.*" ${suffix}"$ ]] && return ${passed}
    report "missing description suffix ‘${suffix}’"
}

check_unrecognized_name_mingw() {
    local normalized="${1}"
    local original="${2}"
    local realname="${normalized#mingw-w64-}"
    check_unrecognized_name "${realname}" "${original}"
}
