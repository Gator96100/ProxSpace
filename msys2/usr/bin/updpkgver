#!/bin/bash

usage() { tee <<done-usage

    Update Package Version 2016.6.24
    Copyright (C) 2016 Renato Silva
    Licensed under BSD

    Usage: ${program} [options] [DIRECTORY...]

    --bump=SPEC       Search count for each version level instead of ${default_bump}
    --commit          Commit updates to git repository
    --maintainer      Filter recipes by maintainer detected from git
    --makepkg=TYPE    Force building with mingw or unix makepkg
    --no-build        Skip building and integrating updates
    --recipe=NAME     Recipe name instead of PKGBUILD
    --report          Report analysis and integration results
    --reset           Remove pending updates
    --status          List pending updates
    --versioned       Include versioned names in update

    --color           Force enabling colors
    --no-color        Force disabling colors
    --no-terminal     Force disabling terminal handling
    --verbose         Enable verbose output

done-usage
exit 1; }

read_arguments() {
    arguments=("${@}")
    program="$(basename "${0}")"
    indent="$(printf %3s)"
    package_length='60'
    default_bump='5.10'
    for element in "${arguments[@]}"; do
        case "${element}" in
            --bump=*)      option_bump="${element#*=}"     ;;
            --makepkg=*)   option_makepkg="${element#*=}"  ;;
            --recipe=*)    option_recipe="${element#*=}"   ;;
            --commit)      option_commit='true'            ;;
            --maintainer)  option_maintainer='true'        ;;
            --no-build)    option_no_build='true'          ;;
            --no-color)    option_no_color='true'          ;;
               --color)    option_color='true'             ;;
            --no-terminal) pactoys[terminal.disable]=1     ;;
            --report)      option_report='true'            ;;
            --reset)       option_reset='true'             ;;
            --status)      option_status='true'            ;;
            --versioned)   option_versioned='true'         ;;
            --verbose)     option_verbose='true'           ;;
            -*)            usage                           ;;
             *)            directories+=("${element//\\/\/}")
        esac
    done
    configure_colors
    option_bump
    option_commit
    option_makepkg
    recipe_paths
}

option_bump() {
    local specification="${option_bump:-${default_bump}}"
    [[ "${specification}" =~ ^[1-9][0-9]*(\.[1-9][0-9]*)*$ ]] || terminate "unrecognized bump format ‘${specification}’"
    for element in ${specification//./ }; do
        max_bump+=($((element)))
    done
}

option_commit() {
    test -n "${option_commit}" || return 0
    silent which git || terminate 'git required for committing updates'
    test -d .git     || terminate 'current directory is not a git repository'
    for element in "${directories[@]}"; do
        silent git ls-files --error-unmatch "${element}" || terminate "untracked directory ‘${element}’"
    done
}

option_makepkg() {
    case "${option_makepkg}" in
        unix)  static_makepkg='makepkg' ;;
        mingw) static_makepkg='makepkg-mingw' ;;
        *?)    terminate "unrecognized makepkg type ‘${option_makepkg}’"
    esac
}

configure_colors() {
    test -n "${option_no_color}" && return 0
    colorize "${option_color}"
}

recipe_paths() {
    declare -g recipes
    local recipe_name="${option_recipe:-PKGBUILD}"
    local maintainer="${option_maintainer}"
    progress 'Searching for recipes'
    find_recipes recipes "${recipe_name}" "${maintainer}" "${directories[@]}" || terminate
    lines_to_list excludes "$(noiseless cat ./.updpkgver.ignore)"
    progress_done
}

message() {
    local arguments=("${@}")
    clearline
    printf "${indent}"
    printf "${arguments[@]}"
}

header(){
    local title="${1}"
    printf "${colors_stdout[blue]}::"
    printf "${colors_stdout[white]} %s" "${title}"
    printf "${colors_stdout[normal]}\n\n"
}

status() {
    local status="${1}"
    local package="${2}"
    local current_version="${3}"
    local updated_version="${4}"
    case "${status}" in
        checking) terminal || return 0
                  message "%-${package_length}s %-15s %s "  "${package}" "${current_version}" "${updated_version}" ;;
        success)  message "%-${package_length}s %-15s %s\n" "${package}" "${current_version}" "${updated_version}" ;;
        building) message "%-${package_length}s %-15s"      "${package}" "${current_version}" ;;
        failure)  clearline
    esac
}

report() {
    local title="${1}"
    local elements=("${@:2}")
    local -A package
    test -n "${elements}" || return 0
    header "${title}"
    for element in "${elements[@]}"; do
        restore package "${element}"
        local arguments=("${package[name]}" "${package[version]}" ${package[new_version]})
        message "%-${package_length}s ${package[new_version]:+%-15s }%s\n" "${arguments[@]}"
    done
    echo
}

collect() {
    local -n nameref_list="${1}"
    local total="${2}"
    local recipe="${3}"
    local package="${4}"
    local current_version="${5}"
    local updated_version="${6}"
    truncate package "${package_length}"
    nameref_list+=("${recipe}"::"${package}"::"${current_version}"::"${updated_version}")
    [[ "${total}" = none ]] && return 0
    progress 'Analyzing recipes' "${total}"
}

restore() {
    local -n nameref_package="${1}"
    local item="${2}"
    local recipe name version new_version
    separate "${item}" recipe name version new_version
    nameref_package['name']="${name}"
    nameref_package['recipe']="${recipe}"
    nameref_package['version']="${version}"
    nameref_package['new_version']="${new_version}"
}

recipe_filename() {
    local recipe="${1}"
    local -n nameref_filename="${2}"
    nameref_filename="${recipe##*/}"
}

temporary_recipe() {
    local name="${1}"
    local location="${2}"
    cp "${name}" "${name}.TMP"
    trap "rm -f '${name}.TMP' '${location}/${name}.TMP'" EXIT
}

bump_version() {
    local -n nameref_version="${1}"
    local component_level="${2}"
    local result current zero component
    for component in ${nameref_version//./ }; do
        current=$((current + 1))
        component="${zero:-${component}}"
        if test ${current} -eq ${component_level}; then
            component=$((component + 1))
            zero=0
        fi
        result="${result}${result:+.}${component}"
    done
    nameref_version="${result}"
}

replace_version() {
    local recipe="${1}"
    local version="${2}"
    sed --in-place --regexp-extended "s/^pkgver=.*/pkgver=${version}/" "${recipe}"
    sed --in-place --regexp-extended 's/^pkgrel=.*/pkgrel=1/' "${recipe}"
}

download_available() {
    local location="${1}"
    local version="${2}"
    local response="$(wget --quiet --spider --server-response --no-hsts "${location}" 2>&1)"
    local divergent_redirect application_content text_content inline_content content_length  request_success
    while IFS= read -r line; do
        case "${line}" in
            *location:*"${version}"*)      continue                   ;;
            *location:*)                   divergent_redirect='true'  ;;
            *content-length:*)             content_length='true'      ;;
            *content-disposition:*inline*) inline_content='true'      ;;
            *content-type:*application*)   application_content='true' ;;
            *content-type:*text*)          text_content='true'        ;;
            *http/*200*ok*)                request_success='true'     ;;
        esac
    done <<< "${response,,}"
    test -n "${request_success}"     || return 1
    test -z "${divergent_redirect}"  || return 1
    test -n "${application_content}" && return 0
    test -n "${content_length}"      && return 0
    test -n "${inline_content}"      && return 0
    test -z "${text_content}"
}

downloadable_url() {
    local location="${1}"
    [[ "${location}" =~ ^https:// ]] && return 0
    [[ "${location}" =~ ^http://  ]] && return 0
    [[ "${location}" =~ ^ftp://   ]] && return 0
    return 1
}

downloadable_urls() {
    local recipe="${1}"
    local -n nameref_list="${2}"
    local source location
    silent recipe_info "${recipe}" source
    for element in "${source[@]}"; do
        location="${element#*::}"
        downloadable_url "${location}" && nameref_list+=("${location}")
    done
}

unreferenced_version() {
    local current_recipe="${1}"
    local updated_recipe="${2}"
    local current_urls updated_urls
    local index=0
    downloadable_urls "${current_recipe}" current_urls
    downloadable_urls "${updated_recipe}" updated_urls
    while [[ ${index} -lt ${#current_urls[@]} ]]; do
        [[ "${current_urls[index]}" != "${updated_urls[index]}" ]] && return 1
        index=$((index + 1))
    done
    return 0
}

check_version() {
    local recipe="${1}"
    local locations pkgver
    silent recipe_info "${recipe}" pkgver
    downloadable_urls "${recipe}" locations
    for element in "${locations[@]}"; do
        download_available "${element}" "${pkgver}" || return 1
    done
    return 0
}

reset_recipes() {
    for element in "${recipes[@]}"; do
        test -f "${element}.NEW" || continue
        rm -v "${element}.NEW"
    done
}

pending_updates() {
    local package pkgbase pkgname current_version updated_version
    progress 'Checking status'
    for recipe in "${recipes[@]}"; do
        test -f "${recipe}.NEW" || continue
        silent recipe_info "${recipe}"     pkgver:current_version pkgbase pkgname
        silent recipe_info "${recipe}.NEW" pkgver:updated_version
        package_name "${recipe}" "${pkgbase}" "${pkgname}" package
        collect pending none "${recipe}" "${package}" "${current_version}" "${updated_version}"
    done
    progress_done
    test -n "${pending}" && echo
    report 'Pending updates' "${pending[@]}"
}

detect_version() {
    local directory="${1}"
    local name="${2}"
    local pkgver="${3}"
    local realname="${name#mingw-w64-}"
    [[ "${name}"     =~ .*-(git|hg|bzr|svn|cvs)$                      ]] && return 2
    [[ "${realname}" =~ .*[0-9].* && -z "${option_versioned}"         ]] && return 3
    [[ "${pkgver}"   =~ ^([0-9]|[1-9][0-9]+)(\.([0-9]|[1-9][0-9]+))*$ ]] || return 4
    [[ "${pkgver}"   =~ ^[0-9]{1,2}(\.[0-9]{1,2})*$                   ]] || return 5
    ! find_pattern "${directory}" "${excludes[@]}"
}

detect_versions() {
    local package pkgbase pkgname pkgver directory
    for recipe in "${recipes[@]}"; do
        recipe_location "${recipe}" directory
        recipe_info "${recipe}" pkgbase pkgname pkgver
        package_name "${recipe}" "${pkgbase}" "${pkgname}" package
        detect_version "${directory}" "${pkgbase:-${pkgname}}" "${pkgver}"
        case ${?} in
            1) collect ignored_excluded    ${#recipes[@]} "${recipe}" "${package}" "${pkgver}" ;;
            2) collect ignored_development ${#recipes[@]} "${recipe}" "${package}" "${pkgver}" ;;
            3) collect ignored_versioned   ${#recipes[@]} "${recipe}" "${package}" "${pkgver}" ;;
            4) collect ignored_strange     ${#recipes[@]} "${recipe}" "${package}" "${pkgver}" ;;
            5) collect ignored_large       ${#recipes[@]} "${recipe}" "${package}" "${pkgver}" ;;
            *) collect updatable           ${#recipes[@]} "${recipe}" "${package}" "${pkgver}"
        esac
    done
    progress_done
    test -n "${updatable}" || test -n "${option_report}" && echo
}

report_versions() {
    report 'Updatable versions'  "${updatable[@]}"
    report 'Large versions'      "${ignored_large[@]}"
    report 'Strange versions'    "${ignored_strange[@]}"
    report 'Versioned names'     "${ignored_versioned[@]}"
    report 'Development names'   "${ignored_development[@]}"
    report 'Excluded names'      "${ignored_excluded[@]}"
}

check_update() {
    local package="${1}"
    local version="${2}"
    local recipe="${3}"
    local current_version="${version}"
    local recipe_name recipe_directory component component_level unreferenced_version
    recipe_filename "${recipe}" recipe_name
    recipe_location "${recipe}" recipe_directory
    cd "${recipe_directory}"
    if test -f "${recipe_name}.NEW"; then
        silent recipe_info "${recipe_name}.NEW" pkgver:version
        status success "${package}" "${current_version}" "${version}"
        current_version="${version}"
    fi
    for component in ${current_version//./ }; do
        component_level=$((component_level + 1))
        local bump_count=0
        while true; do
            bump_count=$((bump_count + 1))
            test ${bump_count} -gt ${max_bump[component_level - 1]:-${max_bump[-1]}} && break
            bump_version version ${component_level}
            status checking "${package}" "${current_version}" "${version}"
            temporary_recipe "${recipe_name}" "${recipe_directory}"
            replace_version "${recipe_name}.TMP" "${version}"
            if unreferenced_version "${recipe_name}" "${recipe_name}.TMP"; then
                collect unreferenced none "${recipe}" "${package}" "${current_version}" "${version}"
                unreferenced_version='true'
                status failure
                break
            fi
            if check_version "${recipe_name}.TMP"; then
                status success "${package}" "${current_version}" "${version}"
                current_version="${version}"
                cp "${recipe_name}.TMP" "${recipe_name}.NEW"
            else
                status failure
            fi
        done
        test -z "${unreferenced_version}" || break
        version="${current_version}"
    done
    rm "${recipe_name}.TMP"
    if test -f "${recipe_name}.NEW"; then
        silent recipe_info "${recipe_name}"     pkgver:version
        silent recipe_info "${recipe_name}.NEW" pkgver:current_version
        collect updates none "${recipe}" "${package}" "${version}" "${current_version}"
    fi
    silent cd -
}

check_updates() {
    local -A package
    test -n "${updatable}" || return 0
    header 'Checking updates'
    for element in "${updatable[@]}"; do
        restore package "${element}"
        check_update "${package[name]}" "${package[version]}" "${package[recipe]}"
    done
    test -z "${updates}" && message 'no updates detected\n'
    echo
    test -n "${option_report}" && report 'Unreferenced versions' "${unreferenced[@]}"
}

makepkg_command() {
    local -n nameref_command="${1}"
    local recipe_name="${2}"
    local type pkgname arch
    if test -n "${static_makepkg}"; then
        nameref_command="${static_makepkg}"
        return
    fi
    silent recipe_info "${recipe_name}" pkgname arch
    recipe_type type pkgname arch
    if [[ "${type}" = mingw ]]
        then nameref_command='makepkg-mingw'
        else nameref_command='makepkg'
    fi
}

make_package() {
    local makepkg="${1}"
    local recipe_name="${2}"
    local options='--noconfirm --skippgpcheck --nocheck --syncdeps --rmdeps --clean --cleanbuild --force --log'
    ${makepkg} -p "${recipe_name}" ${options}
}

build_filter() {
    local pattern="${1}"
    sed --unbuffered --regexp-extended -e 's/\.+$//' -e "s/^${pattern}/${indent}::/" | grep --color=never "^${indent}::"
}

build_status() {
    local status="${1}"
    local package="${2}"
    local version="${3}"
    local makepkg="${4}"
    if test -z "${option_verbose}"; then
        case "${status}" in
            started) status building "${package}" "${version}" ;;
            success) echo 'success' ;;
            failure) echo 'failed' ;;
        esac
    else
        case "${status}" in
            started) echo "==> Building ${package} ${version} with ${makepkg}" ;;
            success) echo '==> SUCCESS'
        esac
    fi
}

build_update() {
    local -n nameref_package="${1}"
    local recipe_name recipe_directory makepkg silent
    recipe_filename "${nameref_package[recipe]}" recipe_name
    recipe_location "${nameref_package[recipe]}" recipe_directory
    cd "${recipe_directory}"
    makepkg_command makepkg "${recipe_name}"
    build_status started "${nameref_package[name]}" "${nameref_package[new_version]}" "${makepkg}"
    test -z "${option_verbose}" && silent='silent'
    if (${silent} updpkgsums "${recipe_name}.NEW" &&
        ${silent} make_package "${makepkg}" "${recipe_name}.NEW" &&
        mv "${recipe_name}.NEW" "${recipe_name}")
        then build_status success
        else build_status failure
    fi
    silent cd -
}

build_updates() {
    local -A package
    test -n "${updates}" || return 0
    header 'Building packages'
    for element in "${updates[@]}"; do
        restore package "${element}"
        if test -z "${option_verbose}"
            then build_update package
            else build_update package 2>&1 | build_filter '==>'
        fi
        if test -f "${package[recipe]}.NEW"
            then failed+=("${element}")
            else updated+=("${element}")
        fi
        test -n "${option_verbose}" && echo
    done
    test -z "${option_verbose}" && echo
}

commit_updates() {
    local message='Automatic package updates by updpkgver.\n'
    local files recipe_name recipe_directory
    local -A package
    if test -n "${option_no_build}"; then
        for element in "${updates[@]}"; do
            restore package "${element}"
            recipe_filename "${package[recipe]}" recipe_name
            recipe_location "${package[recipe]}" recipe_directory
            cd "${recipe_directory}"
            if (silent updpkgsums "${recipe_name}.NEW" &&
                mv "${recipe_name}.NEW" "${recipe_name}")
                then updated+=("${element}")
                else failed+=("${element}")
            fi
            silent cd -
        done
    fi
    test -n "${updated}" || return 0
    for element in "${updated[@]}"; do
        restore package "${element}"
        files+=("${package[recipe]}")
        message+="\n* Update ${package[name]} to ${package[new_version]}."
    done
    silent git commit --file <(printf "${message}") "${files[@]}" || terminate 'failed committing updates'
}

pactoys_options='color.simple'
source pactoys || exit

import clearline
import colorize
import colors_stdout
import progress
import progress_done
import terminal
import terminate
import truncate

import find_pattern
import lines_to_list
import noiseless
import separate
import silent

import find_recipes
import package_name
import recipe_info
import recipe_location
import recipe_type

if [[ "${BASH_SOURCE}" = "${0}" ]]; then
    read_arguments "${@}"
    test -n "${option_reset}"     && { reset_recipes;   exit; }
    test -n "${option_status}"    && { pending_updates; exit; }

    detect_versions
    test -n "${option_report}"    && report_versions

    check_updates
    test -z "${option_no_build}"  && build_updates
    test -n "${option_commit}"    && commit_updates
    test -n "${option_report}"    && report 'Failed packages'  "${failed[@]}"
    test -n "${option_report}"    && report 'Updated packages' "${updated[@]}"
fi
