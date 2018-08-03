#!/bin/bash

help_and_exit() {
    echo "
    Pacboy 2016.6.24
    Copyright (C) 2015, 2016 Renato Silva
    Licensed under BSD

    This is a pacman wrapper for MSYS2 which handles the package prefixes
    automatically, and provides human-friendly commands for common tasks.

    Usage:
        $(basename "$0") [command] [arguments]
        Arguments will be passed to pacman or pkgfile after translation:

        For 64-bit MSYS2, name:i means i686-only
        For 64-bit MSYS2, name:x means x86_64-only
        For MSYS shell, name:m means mingw-w64
        For all shells, name: disables any translation for name
        For all shells, repository::name means repository/name

    Commands:
        sync        Shorthand for --sync or --upgrade
        update      Shorthand for --sync --refresh --sysupgrade
        refresh     Shorthand for --sync --refresh
        find        Shorthand for --sync --search
        packages    Shorthand for --sync --list
        files       Shorthand for --query --list [--file]
        info        Shorthand for --query --info [--file]
        origin      Shorthand for --query --owns or pkgfile
        remove      Shorthand for --remove --recursive
        debug       Verbose output for the above commands
    "
    exit 1
}

parse_mingw_argument() {
    [[ "${command}"  = sync     && -n "${file_argument}" ]] && { raw_argument=(${argument}); return; }
    [[ "${command}"  = files    && -n "${file_argument}" ]] && { raw_argument=(${argument}); return; }
    [[ "${command}"  = info     && -n "${file_argument}" ]] && { raw_argument=(${argument}); return; }
    [[ "${command}"  = origin   ]] && { raw_argument=(${argument}); return; }
    [[ "${command}"  = find     ]] && { raw_argument=(${argument}); return; }
    [[ "${command}"  = packages ]] && { raw_argument=(${argument}); return; }
    [[ "${MSYSTEM}" != MINGW*   ]] && { raw_argument=(${argument}); return; }
    [[ "${machine}" != x86_64   ]] && { raw_argument=(mingw-w64-${architecture}-${argument}); return; }
    [[ "${command}"  = files    ]] && { raw_argument=(mingw-w64-${architecture}-${argument}); return; }
    [[ "${command}"  = info     ]] && { raw_argument=(mingw-w64-${architecture}-${argument}); return; }
    raw_argument=(mingw-w64-x86_64-${argument} mingw-w64-i686-${argument})
}

realname() {
    test -f "${1}" && { echo "${1}"; return; }
    pacman -Q "${1}"     > /dev/null 2>&1 && { echo "${1}";     return; }
    pacman -Q "${1}-git" > /dev/null 2>&1 && { echo "${1}-git"; return; }
    pacman -Q "${1}-svn" > /dev/null 2>&1 && { echo "${1}-svn"; return; }
    pacman -Q "${1}-hg"  > /dev/null 2>&1 && { echo "${1}-hg";  return; }
    pacman -Q "${1}-cvs" > /dev/null 2>&1 && { echo "${1}-cvs"; return; }
    pacman -Q "${1}-bzr" > /dev/null 2>&1 && { echo "${1}-bzr"; return; }
    echo "${1}"
}

status() {
    if [[ -t 1 ]]; then
        local blue='\e[1;34m'
        local white='\e[1;37m'
        local normal='\e[0m'
    fi
    echo -e "${blue}::${white}" "${@}...${normal}"
}

execute() {
    [[ -n "${debug}" && $(type -t "${1}") != function ]] && status Executing "${@}"
    if [[ -z "${exclude_lines}" ]]
        then "${@}"
        else "${@}" | grep --invert-match "${exclude_lines}"
    fi
}

packages() {
    local repository="${1}"
    for package in $(pacman --sync --list --quiet ${repository}); do
        case "${package}" in
            mingw-w64-x86_64-*) package="${package/mingw-w64-x86_64-/}" ;;
            mingw-w64-i686-*)   package="${package/mingw-w64-i686-/}" ;;
            *)                  package="${package}:"
        esac
        echo "${package}"
    done
}

refresh_cache() {
    local package="${1}"
    local repositories=("${@:2}")
    local repository
    for file in /var/cache/${package}/*; do
        test -e "${file}" || break
        for repository in "${repositories[@]}"; do
            [[ "${file}" =~ ^"/var/cache/${package}/${repository}." ]] && break
            unset repository
        done
        test -z "${repository}" && rm "${file}"
    done
}

refresh_database_checksum() {
    local repository="${1}"
    local checksum_file="/var/cache/pacboy/${repository}.checksum"
    local updated_checksum=($(sha256sum "/var/lib/pacman/sync/${repository}.db"))
    local current_checksum="$(cat "${checksum_file}" 2> /dev/null)"
    echo "${updated_checksum}" > "${checksum_file}"
    [[ "${current_checksum}" != "${updated_checksum}" ]]
}

refresh_package_names() {
    local repositories=("${@}")
    for repository in "${repositories[@]}"; do
        if ! refresh_database_checksum "${repository}"
            then echo " ${repository} is up to date"
            else echo " updating ${repository}..."
                 packages "${repository}" | sort | uniq > "/var/cache/pacboy/${repository}.packages"
        fi
    done
}

refresh_databases() {
    execute ${pacman} --sync --refresh "${@}" || exit
    test -n "${help_tip}" && exit
    local repositories=()
    for database in /var/lib/pacman/sync/*.db; do
        database="${database##*/}"
        repositories+=("${database%.db}")
    done

    status 'Updating package content databases'
    refresh_cache 'pkgfile' "${repositories[@]}"
    execute pkgfile --update || exit

    status 'Updating package name databases'
    refresh_cache 'pacboy' "${repositories[@]}"
    refresh_package_names "${repositories[@]}"
}

arguments=()
raw_arguments=()
pacman='pacman --color auto'
machine=$(uname -m)
case "${MSYSTEM}" in
    MINGW32) architecture='i686' ;;
    MINGW64) architecture='x86_64' ;;
    *)       architecture="${machine}"
esac
test -z "${1}" && help_and_exit

for argument in "${@}"; do
    case "${argument}" in
        help)  help_and_exit ;;
        debug) debug='true'
               continue ;;
    esac
    if [[ -n "${command}" ]]; then
        arguments+=("${argument}")
        continue
    fi
    case "${argument}" in
        sync)        command="${argument}"; raw_command="${pacman} --sync" ;;
        update)      command="${argument}"; raw_command="${pacman} --sync --sysupgrade" ;;
        refresh)     command="${argument}"; raw_command='refresh_databases' ;;
        find)        command="${argument}"; raw_command="${pacman} --sync --search" ;;
        packages)    command="${argument}"; raw_command="${pacman} --sync --list" ;;
        files)       command="${argument}"; raw_command="${pacman} --query --list" ;;
        info)        command="${argument}"; raw_command="${pacman} --query --info" ;;
        remove)      command="${argument}"; raw_command="${pacman} --remove --recursive" ;;
        origin)      command="${argument}"; raw_command='pkgfile' ;;
        *)           arguments+=("${argument}")
    esac
done

for argument in "${arguments[@]}"; do
    if [[ "${argument}" = *::* ]]; then
        repository="${argument%::*}/"
        argument="${argument##*::}"
    fi
    case "${command}" in
        sync)   test -f "${argument}" && { file_argument='true'; raw_command="${pacman} --upgrade"; } ;;
        origin) test -f "${argument}" && { file_argument='true'; raw_command="${pacman} --query --owns"; } ;;
        files)  test -f "${argument}" && { file_argument='true'; raw_command="${raw_command} --file"; } ;;
        info)   test -f "${argument}" && { file_argument='true'; raw_command="${raw_command} --file"; } ;;
    esac
    case "${argument}" in
    *\\*) raw_argument=("${argument}") ;;
     */*) raw_argument=("${argument}") ;;
      -*) raw_argument=("${argument}") ;;
      *:) raw_argument=("${argument%:}") ;;
     *:i) raw_argument=(mingw-w64-i686-${argument%:i}) ;;
     *:x) raw_argument=(mingw-w64-x86_64-${argument%:x}) ;;
     *:m) raw_argument=(mingw-w64-x86_64-${argument%:m} mingw-w64-i686-${argument%:m}) ;;
       *) parse_mingw_argument ;;
    esac
    [[ $argument =~ ^(-h|-[^-].*h|--help$) ]] && help_tip='true'
    for raw_argument in "${raw_argument[@]}"; do
        [[ "${command}" =~ ^files|info|remove$ ]] && raw_argument=$(realname "${raw_argument}")
        raw_arguments+=("${repository}${raw_argument}")
    done
    unset file_argument
    unset repository
done

case "${command}" in
    update) test -z "${help_tip}" && refresh_databases ;;
    files)  exclude_lines='/$' ;;
esac
test -n "${help_tip}" && echo "did you mean '$(basename "$0") help'?"
test -z "${raw_command}" && raw_command="${pacman}"
execute ${raw_command} "${raw_arguments[@]}"
