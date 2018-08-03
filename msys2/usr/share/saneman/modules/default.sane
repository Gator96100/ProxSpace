# Saneman Default Module
# Copyright (C) 2016 Renato Silva
# Licensed under BSD

module[description]='Saneman default module'

declare -Ag arch_list
declare -Ag license_list

problems=([deprecated:md5sums]='warning'
          [deprecated:sha1sums]='warning'
          [mismatching:directory]='message'
          [missing:arch]='failure'
          [missing:checksums]='failure'
          [missing:license]='failure'
          [missing:pkgdesc]='warning'
          [missing:pkgname]='failure'
          [missing:pkgrel]='failure'
          [missing:pkgver]='failure'
          [missing:source]='failure'
          [missing:url]='warning'
          [unformatted:license]='message'
          [unrecognized:arch]='warning'
          [unrecognized:license]='warning'
          [unrecognized:name]='warning'
          [unrecognized:references]='failure')

arch_list=([any]='any architecture'
           [i686]='i686 architecture (32-bit)'
           [x86_64]='x86_64 architecture (64-bit)')

license_list=([AGPL]='Affero General Public License (Affero/GNU)'
              [Apache]='Apache Software License'
              [Artistic]='Artistic License'
              [BSD]='BSD-like licenses'
              [CC0]='Creative Commons Public Domain'
              [CC-BY]='Creative Commons Attribution'
              [CC-BY-NC]='Creative Commons Attribution-NonCommercial'
              [CC-BY-ND]='Creative Commons Attribution-NoDerivatives'
              [CC-BY-SA]='Creative Commons Attribution-ShareAlike'
              [CC-BY-NC-ND]='Creative Commons Attribution-NonCommercial-NoDerivatives'
              [CC-BY-NC-SA]='Creative Commons Attribution-NonCommercial-ShareAlike'
              [CDDL]='Common Development and Distribution License'
              [CeCILL]='CEA/CNRS/Inria Logiciel Libre License'
              [CeCILL-B]='CEA/CNRS/Inria Logiciel Libre License (BSD-like)'
              [CeCILL-C]='CEA/CNRS/Inria Logiciel Libre License (Components)'
              [CPL]='Common Public License'
              [EPL]='Eclipse Public License'
              [FDL]='GNU Free Documentation License'
              [GCCRLE]='GCC Runtime Library Exception'
              [GPL]='GNU General Public License'
              [ISC]='Internet Systems Consortium License'
              [LGPL]='GNU Lesser General Public License'
              [MIT]='MIT-like licenses'
              [MPL]='Mozilla Public License'
              [PHP]='PHP License'
              [PSF]='Python Software Foundation License'
              [PublicDomain]='Public domain'
              [Ruby]='Ruby License'
              [UIUC]='University of Illinois/NCSA Open Source License'
              [W3C]='W3C Software Notice and License'
              [ZLIB]='zlib, zlib/libpng and similar licenses'
              [ZPL]='Zope Public License')

_check_license() {
    local normalized="${1}"
    local category="${problem[category]}"
    local possible expected unversioned version separator
    case "${normalized}" in
        documentation:?*) normalized="${normalized#*:}" ;;
        partial:?*)       normalized="${normalized#*:}" ;;
        custom:?*)        return ${passed} ;;
        custom)           return ${passed} ;;
    esac
    test -z "${normalized}" && return ${passed}
    test -n "${license_list[${normalized}]}" && return ${passed}
    unversioned="${normalized}"
    while [[ "${unversioned}" = *[0-9.+] ]]; do
        unversioned="${unversioned%%[0-9.+]}"
    done
    version="${normalized#${unversioned}}"
    possible="${unversioned%${version:+[-_ v]}}"
    separator="${possible//[a-zA-Z]/}"
    separator="${separator:+-}"
    expected="${normalized%${separator}${version}}"
    if [[ "${category}"  = unformatted ]]
        then test -n "${license_list[${expected}]}" || test -z "${license_list_lowercase[${possible,,}]}"
        else test -n "${license_list[${possible}]}" || test -n "${license_list_lowercase[${possible,,}]}"
    fi
}

check_missing() {
    local property="${problem[property]}"
    local description="${properties[${property}]}"
    test -n "${!property}" && return ${passed}
    report "missing ${description}"
}

check_missing_checksums() {
    test -n "${checksums}" && return ${passed}
    test -z "${source}" && return ${passed}
    report 'missing source checksums'
}

check_deprecated() {
    local property="${problem[property]}"
    local description="${properties[${property}]}"
    test -z "${!property}" && return ${passed}
    report "deprecated ${description}"
    return ${failed_all}
}

check_unrecognized() {
    local normalized="${1}"
    local original="${2}"
    local property="${problem[property]}"
    local description="${properties[${property}]}"
    local -n nameref_recognized="${property}_list"
    test -z "${normalized}" && return ${passed}
    test -z "${!nameref_recognized[*]}" && return ${passed}
    test -n "${nameref_recognized[${normalized}]}" && return ${passed}
    report "unrecognized ${description} ‘${original}’"
}

check_unrecognized_name() {
    local normalized="${1}"
    local original="${2}"
    test -z "${normalized}" && return ${passed}
    [[ "${normalized}" =~ ^[a-zA-Z0-9]([a-zA-Z0-9+._-])*[a-zA-Z0-9+]*$ ]] && return ${passed}
    report "unrecognized package name ‘${original}’"
}

check_unrecognized_references() {
    local normalized="${1}"
    local original="${2}"
    local description type
    local result=${passed}
    test -z "${normalized}" && return ${passed}
    separate "${normalized}" type normalized
    [[ "${type}" = makedepends ]] && return ${passed}
    for element in "${pkgname[@]}"; do
        normalize_case element
        if [[ "${normalized}" = "${element}" ]]; then
            description="${properties[${type}]}"
            separate "${original}" type original
            report "circular reference ${original} in ${description}"
            result=${failed}
        fi
    done
    return ${result}
}

check_unrecognized_license() {
    local normalized="${1}"
    local original="${2}"
    _check_license "${normalized}" && return ${passed}
    report "unrecognized license ‘${original}’"
}

check_unformatted_license() {
    local normalized="${1}"
    local original="${2}"
    _check_license "${normalized}" && return ${passed}
    report "unformatted license ‘${original}’"
}

check_mismatching_directory() {
    local normalized="${1}"
    local original="${2}"
    local development='-(git|hg|bzr|svn|cvs)$'
    local name="${name}"
    normalize_case name
    [[ "${name}" =~ ${development} || "${normalized}" =~ ${development} ]] || return ${passed}
    [[ "${name}" =~ ${development} && "${normalized}" =~ ${development} ]] && return ${passed}
    report "mismatching directory ‘${original}’"
}
