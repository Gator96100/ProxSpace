# Pactoys Default Library
# Copyright (C) 2016 Renato Silva
# Licensed under BSD

declare -Ag pactoys
test -n "${pactoys[module.default]}" && return
pactoys[module.default]=1

_pactoys_imported() {
    local type="${1}"
    local name="${2}"
    test -n "${pactoys[import.${type}.${name}]}"
}

_pactoys_register_import() {
    local type="${1}"
    local name="${2}"
    pactoys[import.${type}.${name}]=1
}

_pactoys_import_object() {
    local name="${1}"
    local internal="pactoys_${name}"
    _pactoys_imported object "${name}" && return 0
    pactoys_is_variable "${name}" && ! pactoys_interactive && return 1
    pactoys_is_variable "${internal}" || return 1
    declare -ng "${name}=${internal}" || return 1
    _pactoys_register_import object "${name}"
    return 0
}

_pactoys_import_function() {
    local name="${1}"
    local internal="pactoys_${name}"
    _pactoys_imported function "${name}" && return 0
    pactoys_is_function "${name}" && ! pactoys_interactive && return 1
    pactoys_is_function "${internal}" || return 1
    eval "${name}() { ${internal} \"\${@}\"; }" || return 1
    _pactoys_register_import function "${name}"
    return 0
}

_pactoys_import() {
    local names=("${@}")
    local name result=0
    for name in "${names[@]}"; do
        local internal="pactoys_${name}"
        local object=1
        local function=1
        if pactoys_is_variable "${internal}"; then
            _pactoys_import_object "${name}"
            object=${?}
        fi
        if pactoys_is_function "${internal}"; then
            _pactoys_import_function "${name}"
            function=${?}
        fi
        test $((object + function)) -lt 2 && continue
        printf 'pactoys: failed importing ‘%s’\n' "${name}" >&2
        result=1
    done
    return ${result}
}

import() {
    local arguments=("${@}")
    _pactoys_import "${@}" || pactoys_interactive || exit
}

pactoys_is_variable() {
    local name="${1}"
    pactoys_silent declare -p "${name}"
}

pactoys_is_function() {
    local name="${1}"
    pactoys_silent declare -F "${name}"
}

pactoys_interactive() {
    [[ "${-}" = *i* ]]
}

pactoys_silent() {
    local command=("${@}")
    "${command[@]}" >/dev/null 2>&1
}

pactoys_noiseless() {
    local command=("${@}")
    "${command[@]}" 2>/dev/null
}

for pactoys_option in ${pactoys_options//,/ }; do
    pactoys[${pactoys_option}]=1
done
unset pactoys_option
