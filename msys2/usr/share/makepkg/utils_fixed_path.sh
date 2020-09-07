if [[ -n "$MSYSTEM" ]]; then
  readonly -a UTILS_NAME=('bsdtar'
                          'bzip2'
                          'bzr'
                          'cat'
                          'ccache'
                          'distcc'
                          'git'
                          'gpg'
                          'gzip'
                          'hg'
                          'lzip'
                          'lzop'
                          'openssl'
                          'svn'
                          'tput'
                          'uncompress'
                          'xargs'
                          'xz'
                          'zstd'
                         )

  for wrapper in ${UTILS_NAME[@]}; do
    eval "
    ${wrapper}"'() {
      local UTILS_PATH="/usr/bin/"
      if ! type -p ${UTILS_PATH}${FUNCNAME[0]} >/dev/null; then
        error "$(gettext "Cannot find the %s binary required for makepkg.")" "${UTILS_PATH}${FUNCNAME[0]}"
        exit 1
      fi
      ${UTILS_PATH}${FUNCNAME[0]} "$@"
    }'
  done
fi
