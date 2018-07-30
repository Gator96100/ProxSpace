command_not_found_handle () {
  local pkgs cmd=$1
  local FUNCNEST=10

  set +o verbose

  mapfile -t pkgs < <(pkgfile -bv -- "$cmd" 2>/dev/null)

  if [[ ${#pkgs[*]} -eq 1 && -n $PKGFILE_PROMPT_INSTALL_MISSING ]]; then
    local pkg=${pkgs[0]%% *}
    local response

    read -r -p "Install $pkg? [Y/n] " response
    [[ -z $response || $response = [Yy] ]] || return 0
    printf '\n'
    sudo pacman -S --noconfirm -- "$pkg"
    return 0
  fi

  if (( ${#pkgs[*]} )); then
    printf '%s may be found in the following packages:\n' "$cmd"
    printf '  %s\n' "${pkgs[@]}"
    return 0
  else
    printf "bash: %s: command not found\n" "$cmd" >&2
    return 127
  fi
}
