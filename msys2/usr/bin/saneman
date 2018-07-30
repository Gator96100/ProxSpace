#!/bin/bash

usage() { tee <<done-usage

    Saneman 2016.6.24
    Copyright (C) 2016 Renato Silva
    Licensed under BSD

    Usage: ${program} [options] [DIRECTORY...]

    --id=PATTERN           Filter by problem id
    --level=PATTERN        Filter by problem level
    --match=PATTERN        Filter by problem match

    --list-modules         List loaded modules
    --list-problems        List problem definitions
    --list=PROPERTY        List recognized property values

    --maintainer           Filter recipes by maintainer detected from git
    --module=NAMES         Specify loaded modules separated by comma
    --recipe=NAME          Recipe name instead of PKGBUILD
    --strict               Increase level severity

    --format=VALUE         Use list, table or custom output format:
                           %c  reset color
                           %d  directory name
                           %i  problem id
                           %l  problem level
                           %m  problem message
                           %n  package internal name
                           %p  package display name
                           %r  recipe path
    --table                Same as --format=table
    --width=VALUES         Width for format variables, specified as
                           name:value pairs separated by comma

    --color                Force enabling colors
    --ignore-case          Disable case sensitivity
    --no-color             Force disabling colors
    --no-terminal          Force disabling terminal handling
    --verbose              Enable verbose output

done-usage
exit 1; }

read_arguments() {
    arguments=("${@}")
    program="$(basename "${0}")"
    handler_prefix='check'
    format_tokens='cdilmnpr'
    default_format='list'
    default_width='l:10,p:60'
    for element in "${arguments[@]}"; do
        case "${element}" in
            --format=*)      option_format="${element#*=}"   ;;
            --id=*)          option_id="${element#*=}"       ;;
            --level=*)       option_level="${element#*=}"    ;;
            --list=*)        option_list="${element#*=}"     ;;
            --match=*)       option_match="${element#*=}"    ;;
            --module=*)      option_module="${element#*=}"   ;;
            --recipe=*)      option_recipe="${element#*=}"   ;;
            --width=*)       option_width+=("${element#*=}") ;;
            --ignore-case)   option_ignore_case='true'       ;;
            --list-modules)  option_list_modules='true'      ;;
            --list-problems) option_list_problems='true'     ;;
            --maintainer)    option_maintainer='true'        ;;
            --no-color)      option_no_color='true'          ;;
               --color)      option_color='true'             ;;
            --no-terminal)   pactoys[terminal.disable]=1     ;;
            --strict)        option_strict='true'            ;;
            --table)         option_format='table'           ;;
            --verbose)       option_verbose='true'           ;;
            -*)              usage                           ;;
             *)              directories+=("${element//\\/\/}")
        esac
    done
    configure_colors
    option_format
    option_width
}

option_format() {
    format="${option_format:-${default_format}}"
    case "${format}" in
        list)  format='%l:%c %p:%c %m' format_pending='%l: %p';    return 0 ;;
        table) format='%l%c %p%c %m'   format_pending="${format}"; return 0 ;;
    esac
    format_pending="${format}"
    [[ "${format}" =~ ^(.*%[^${format_tokens}].*|[^%]+|.*%)$ ]] || return 0
    terminate "unrecognized format ‘${format}’"
}

option_width() {
    declare -Ag widths
    if [[ "${option_format}" = table ]]
        then local width_pairs="${default_width}"
        else local width_pairs
    fi
    if test -n "${option_width}"; then
        local width_pattern="[${format_tokens}]:-?[0-9]+"
        if [[ "${option_width}" =~ ^${width_pattern}(,${width_pattern})*$ ]]
            then width_pairs="${width_pairs},${option_width}"
            else terminate "unrecognized width ‘${option_width}’"
        fi
    fi
    for element in ${width_pairs//,/ }; do
        element="${element/:/:-}"
        element="${element/:--/:}"
        widths[${element%:*}]="${element#*:}"
    done
}

configure_colors() {
    declare -Ag colors_pending
    declare -Ag colors_ignored
    local message_color
    test -n "${option_no_color}" && return 0
    message_color="${option_verbose:+normal}"
    message_color="${message_color:-blue}"
    colors[id]="${colors[normal]}"
    colors[message]="${colors[normal]}"
    colors[package]="${colors[white]}"
    colors[name]="${colors[package]}"
    colors[recipe]="${colors[package]}"
    colors[directory]="${colors[package]}"
    colors[level:failure]="${colors[red]}"
    colors[level:warning]="${colors[yellow]}"
    colors[level:success]="${colors[green]}"
    colors[level:message]="${colors[${message_color}]}"
    merge_hash pactoys_colors colors
    colorize "${option_color}"
    init_hash colors_pending "${colors_stdout[normal]}" level:pending id message package name recipe directory
    init_hash colors_ignored "${colors_stdout[gray]}"   level:ignored id message package name recipe directory
}

load_module() {
    local path="${1}"
    local -A module=()
    local name filter
    name="${path##*/}"
    name="${name%.sane}"
    filter="^(${option_module:-.*})\$"
    filter="${filter/#^(not:/not:^(}"
    filter "${filter//,/|}" "${name}" || return 0
    silent source "${path}" || return 1
    modules[${name}]="${module[description]:-No description}"
}

load_modules() {
    local directory="${SANEMAN_MODULES:-/usr/share/saneman/modules}"
    local module filename
    progress 'Loading modules'
    load_module "${directory}/default.sane" || terminate 'failed loading default module'
    for module in "${directory}"/*.sane; do
        filename="${module##*/}"
        [[ "${filename}" != default.sane && -f "${module}" ]] || continue
        load_module "${module}" || warning "failed loading module ‘${module}’"
    done
    progress_done
    test -n "${!modules[*]}" || terminate 'missing loadable modules'
}

list_recognized() {
    test -n "${option_list_modules}"  && print_hash modules  table && return 0
    test -n "${option_list_problems}" && print_hash problems table && return 0
    test -n "${option_list}" || return 1
    test -n "${properties[${option_list}]}" || terminate "unrecognized property ‘${option_list}’"
    print_hash "${option_list}_list" table
    return 0
}

normalize_case() {
    local -n nameref_value="${1}"
    test -n "${option_ignore_case}" || return 0
    nameref_value="${nameref_value,,}"
}

normalize_lists() {
    local property recognized
    for property in "${!properties[@]}"; do
        local -n nameref_list="${property}_list"
        local -n nameref_lowercase="${property}_list_lowercase"
        test -n "${!nameref_list[*]}" || continue
        declare -Ag "${property}_list_lowercase"
        for recognized in "${!nameref_list[@]}"; do
            nameref_lowercase[${recognized,,}]="${nameref_list[${recognized}]}"
        done
        test -n "${option_ignore_case}" || continue
        merge_hash nameref_list nameref_lowercase
    done
}

merge_properties() {
    local -n nameref_name="${1}"
    local -a properties=("${@:2}")
    local property value
    nameref_name=()
    for property in "${properties[@]}"; do
        local -n nameref_property="${property}"
        for value in "${nameref_property[@]}"; do
            nameref_name+=("${property}::${value}")
        done
    done
}

load_problem() {
    local id="${1}"
    local -n nameref_problem="${2}"
    load_object problems nameref_problem "${id}" level
    nameref_problem[category]="${id%:*}"
    nameref_problem[property]="${id#*:}"
}

filter_problem() {
    local id="${1}"
    local level="${2}"
    local match="${3}"
    filter "${option_id}"    "${id}"    || return 1
    filter "${option_level}" "${level}" || return 1
    filter "${option_match}" "${match}" || test -z "${match}"
}

report() {
    local message="${1}"
    clearline
    if [[ "${message}" = status:* ]]; then
        local level="${message#status:}"
        local id="${level}"
        case "${level}" in
            success) test -n "${option_verbose}" || return 0 ;;
            ignored) test -n "${option_verbose}" || return 0 ;;
            pending) terminal || return 0
        esac
        message="${level/pending/checking}"
        message="${message/success/ok}"
        message="${message/ignored/ok}"
    else
        local id="${problem[id]}"
        local level="${problem[level]}"
        [[ "${level}" = failure ]] && program_result=1
    fi
    case "${level}" in
        pending) print_format "${format_pending} " colors_pending widths directory id level message name package recipe ;;
        ignored) print_format "${format}\n"        colors_ignored widths directory id level message name package recipe ;;
        *)       print_format "${format}\n"        colors_stdout  widths directory id level message name package recipe
    esac
    [[ "${level}" = success ]]
}

recipe_paths() {
    declare -g recipes
    local recipe_name="${option_recipe:-PKGBUILD}"
    local maintainer="${option_maintainer}"
    progress 'Searching for recipes'
    find_recipes recipes "${recipe_name}" "${maintainer}" "${directories[@]}" || terminate
    lines_to_list excludes "$(noiseless cat ./.saneman.ignore)"
    progress_done
}

register_handlers() {
    local -n nameref_problem="${1}"
    local category="${nameref_problem[category]}"
    local property="${nameref_problem[property]}"
    local result=1
    local handler
    for handler in ${category}{,_${property}}{,_{mingw,unix}}; do
        handler=${handler_prefix}_${handler}
        if test -n "${handlers[${handler}]}"; then
            result=0
            continue
        fi
        if silent declare -F "${handler}"; then
            handlers[${handler}]='true'
            result=0
        fi
    done
    return ${result}
}

register_problems() {
    local -A problem
    local id level
    for id in "${!problems[@]}"; do
        load_problem "${id}" problem
        if  [[ ! "${problem[level]}" =~ ^(message|warning|failure)$
            || ! "${problem[id]}" = "${problem[id],,}"
            || ! "${problem[id]}" =~ ^[:_a-z0-9]+$ ]]; then
            warning "failed loading problem ‘${id}’"
            unset "problems[${id}]"
            continue
        fi
        level="${option_strict:+strict:}${problem[level]}"
        level="${level/#strict:message/warning}"
        level="${level/#strict:warning/failure}"
        level="${level#strict:}"
        if ! filter_problem "${id}" "${level}"; then
            unset "problems[${id}]"
            continue
        fi
        problems[${id}]="${level}"
        if ! register_handlers problem; then
            warning "missing handlers for ‘${id}’"
            unset "problems[${id}]"
            continue
        fi
    done
    test -n "${!problems[*]}" || terminate 'missing loadable problems'
    test -n "${!handlers[*]}" || terminate 'missing loadable handlers'
}

process_problems() {
    local package_type
    local -A problem
    local id handler checked result
    for id in "${!problems[@]}"; do
        load_problem "${id}" problem
        local level="${problem[level]}"
        local category="${problem[category]}"
        local property="${problem[property]}"
        local -n nameref_property="${property}"
        recipe_type package_type pkgname arch
        for handler in ${category}{_${property},}{_${package_type},}; do
            handler=${handler_prefix}_${handler}
            if test -n "${handlers[${handler}]}"; then
                for checked in "${nameref_property[@]:-}"; do
                    result=${result:-0}
                    local original="${checked}"
                    normalize_case checked
                    filter_problem "${id}" "${level}" "${checked}" || continue
                    ${handler} "${checked}" "${original}" || result=${?}
                    if test ${result} -eq ${failed_all}; then
                        result=${failed}
                        break
                    fi
                done
                break
            fi
        done
    done
    return ${result:-1}
}

process_recipes() {
    local package recipe location ${!properties[@]}
    local -A problem
    progress 'Initializing'
    normalize_lists
    register_problems
    progress_done
    recipe_paths
    for recipe in "${recipes[@]}"; do
        recipe_location "${recipe}" location
        recipe_folder "${recipe}" package
        report status:pending
        silent recipe_info "${recipe}" ${!properties[@]}
        package_name "${recipe}" "${pkgbase}" "${pkgname}" package
        if find_pattern "${location}" "${excludes[@]}"; then
            report status:ignored
            continue
        fi
        name="${pkgbase:-${pkgname}}"
        recipe_folder "${recipe}" directory
        merge_properties checksums {md5,sha{1,224,256,384,512},whirlpool}sums
        merge_properties references depends makedepends provides conflicts replaces
        process_problems && report status:success
    done
}

declare -A modules
declare -A handlers
declare -A problems
declare -A properties

declare passed=0
declare failed=1
declare failed_all=2

properties=([name]='internal name'
            [directory]='directory name'
            [references]='package references'
            [checksums]='checksums'
            [pkgbase]='generic name'
            [pkgname]='name'
            [pkgver]='version'
            [pkgrel]='release number'
            [pkgdesc]='description'
            [url]='URL'
            [license]='license'
            [arch]='architecture'
            [source]='source'
            [depends]='runtime dependencies'
            [makedepends]='build dependencies'
            [provides]='provided packages'
            [conflicts]='conflicted packages'
            [replaces]='replaced packages'
            [md5sums]='MD5 checksums'
            [sha1sums]='SHA-1 checksums'
            [sha224sums]='SHA-224 checksums'
            [sha256sums]='SHA-256 checksums'
            [sha384sums]='SHA-384 checksums'
            [sha512sums]='SHA-512 checksums'
            [whirlpoolsums]='Whirlpool checksums')

source pactoys || exit

import clearline
import colorize
import colors
import colors_stdout
import print_format
import progress
import progress_done
import terminal
import terminate
import warning

import init_hash
import filter
import find_pattern
import lines_to_list
import load_object
import merge_hash
import noiseless
import print_hash
import separate
import silent

import find_recipes
import package_name
import recipe_folder
import recipe_info
import recipe_location
import recipe_type

if [[ "${BASH_SOURCE}" = "${0}" ]]; then
    program_result=0
    read_arguments "${@}"
    load_modules
    list_recognized || process_recipes
    exit ${program_result}
fi
