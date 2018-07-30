# Pactoys Library
# Copyright (C) 2016 Renato Silva
# Licensed under BSD

declare -Ag pactoys
test -n "${pactoys[module.pactoys]}" && return
pactoys[module.pactoys]=1

source "${PACTOYS_LIBRARY:-/usr/share/pactoys/library}/default.sh" || return
source "${PACTOYS_LIBRARY:-/usr/share/pactoys/library}/output.sh"  || return
source "${PACTOYS_LIBRARY:-/usr/share/pactoys/library}/recipe.sh"  || return
source "${PACTOYS_LIBRARY:-/usr/share/pactoys/library}/util.sh"    || return
