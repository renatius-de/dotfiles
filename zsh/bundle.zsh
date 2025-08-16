# Antigen-Setup mit gebündelten, gut strukturierten Bundles
ANTIGEN_FILE="${ANTIGEN_FILE:-${ZDOTDIR:-$HOME}/.zsh/plugin/antigen/antigen.zsh}"

if [[ -r "$ANTIGEN_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$ANTIGEN_FILE"

  antigen use oh-my-zsh

  load_antigen_bundles() {
    local b
    for b in "$@"; do
      antigen bundle "$b"
    done
  }

  local -a COMMON_BUNDLES=(
    history-substring-search
    jenv
    themes
    pyenv
    vi-mode
  )
  load_antigen_bundles "${COMMON_BUNDLES[@]}"

  if [[ "$(uname -s)" == "Darwin" ]]; then
    load_antigen_bundles brew macos
    export HOMEBREW_NO_ENV_HINTS=1
  fi

  load_antigen_bundles \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    zsh-users/zsh-syntax-highlighting

  antigen theme candy
  antigen apply
fi
