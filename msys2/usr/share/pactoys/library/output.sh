# Pactoys Output Library
# Copyright (C) 2016 Renato Silva
# Licensed under BSD

declare -Ag pactoys
test -n "${pactoys[module.output]}" && return
pactoys[module.output]=1

source "${PACTOYS_LIBRARY:-/usr/share/pactoys/library}/default.sh" || return
source "${PACTOYS_LIBRARY:-/usr/share/pactoys/library}/util.sh"    || return

declare -Ag pactoys_colors=()
declare -Ag pactoys_colors_stdout=()
declare -Ag pactoys_colors_stderr=()

pactoys_terminal() {
    local device="${1:-stdout}"
    device="${device/stdin/0}"
    device="${device/stdout/1}"
    device="${device/stderr/2}"
    test -z "${pactoys[terminal.disable]}" &&
    test -t "${device}"
}

pactoys_clearline() {
    pactoys_terminal || return 0
    printf '\r\e[0K\r'
}

pactoys_warning() {
    local message="${1}"
    pactoys_clearline
    printf "${pactoys_colors_stdout[yellow]}warning:"
    printf "${pactoys_colors_stdout[normal]} %s\n" "${message}"
}

pactoys_error() {
    local message="${1}"
    pactoys_clearline
    printf "${pactoys_colors_stdout[red]}error:"
    printf "${pactoys_colors_stdout[normal]} %s\n" "${message}"
}

pactoys_terminate() {
    local message="${1:-${pactoys[error]}}"
    test -n "${message}" && pactoys_error "${message}"
    exit 1
}

pactoys_progress() {
    local message="${1}"
    local total="${2}"
    pactoys_terminal || return 0
    if test -n "${total}"
        then pactoys[progress]=$((pactoys[progress] + 1))
             printf '\r%s: %s%% (%s/%s) ' "${message}" $(((pactoys[progress] * 100) / ${total})) ${pactoys[progress]} ${total}
        else printf '\r%s... ' "${message}"
    fi
}

pactoys_progress_done() {
    unset -v 'pactoys[progress]'
    pactoys_clearline
}

pactoys_truncate() {
    local -n nameref_string="${1}"
    local length="${2:-0}"
    (( ${#nameref_string} <= length || length < 3 )) && return 0
    nameref_string="${nameref_string:0:$((length - 3))}..."
}

pactoys_print_format() {
    local format="${1}"
    local -n nameref_colors="${2}"
    local -n nameref_widths="${3}"
    local variables=("${@:4}")
    local variable value token conversion color
    local -A conversions=([c]="${nameref_colors[normal]}")
    local -A values
    for variable in "${variables[@]}"; do
        token="${variable#*:}"
        token="${token:0:1}"
        variable="${variable%:*}"
        value="${!variable}"
        color="${nameref_colors[${variable}]}"
        color="${color:-${nameref_colors[${variable}:${!variable}]}}"
        conversion="%${nameref_widths[${token}]}s"
        conversions[${token}]="${color}${conversion}"
        pactoys_truncate value "${nameref_widths[${token}]#-}"
        values[${token}]="${value}"
    done
    while [[ "${format}" = *%* ]]; do
        printf "${format%%\%*}"
        format="${format#*%}"
        test -n "${format}" || break
        token="${format:0:1}"
        printf "${conversions[${token}]}" "${values[${token}]}"
        format="${format#?}"
    done
    printf "${format}"
}

pactoys_colorize() {
    local force="${1}"
    if test -t 1 || test -n "${force}"; then pactoys_merge_hash pactoys_colors_stdout pactoys_colors; fi
    if test -t 2 || test -n "${force}"; then pactoys_merge_hash pactoys_colors_stderr pactoys_colors; fi
}

if [[ -z "${pactoys[color.simple]}" && "${TERM}" = *256color* && "${MSYSCON}" = mintty* ]]; then
    pactoys_colors[normal]='\e[0m'
    pactoys_colors[gray]='\e[38;05;244m'
    pactoys_colors[red]='\e[38;05;9m'
    pactoys_colors[green]='\e[38;05;76m'
    pactoys_colors[yellow]='\e[38;05;227m'
    pactoys_colors[blue]='\e[38;05;75m'
    pactoys_colors[purple]='\e[38;05;165m'
    pactoys_colors[cyan]='\e[38;05;51m'
    pactoys_colors[white]='\e[38;05;255m'
else
    pactoys_colors[normal]='\e[0m'
    pactoys_colors[gray]='\e[1;30m'
    pactoys_colors[red]='\e[1;31m'
    pactoys_colors[green]='\e[1;32m'
    pactoys_colors[yellow]='\e[1;33m'
    pactoys_colors[blue]='\e[1;34m'
    pactoys_colors[purple]='\e[1;35m'
    pactoys_colors[cyan]='\e[1;36m'
    pactoys_colors[white]='\e[1;37m'
fi
