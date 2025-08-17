typeset -gr ANTIGEN_DEFAULT_FILE="/opt/homebrew/share/antigen/antigen.zsh"
typeset -gr ANTIGEN_THEME="candy"

typeset -gra ANTIGEN_COMMON_BUNDLES=(
  docker-compose
  gradle
  history-substring-search
  jenv
  k9s
  kubectl
  minikube
  mvn
  themes
  vi-mode
  zsh-navigation-tools
)
typeset -gra ANTIGEN_DARWIN_BUNDLES=(
  brew
  macos
)
typeset -gra ANTIGEN_EXTRA_BUNDLES=(
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
)

ANTIGEN_FILE="${ANTIGEN_FILE:-$ANTIGEN_DEFAULT_FILE}"

if [[ -r "$ANTIGEN_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$ANTIGEN_FILE"

  antigen use oh-my-zsh

  antigen_load_bundles() {
    local bundle
    for bundle in "$@"; do
      antigen bundle "$bundle"
    done
  }

  antigen_load_bundles "${ANTIGEN_COMMON_BUNDLES[@]}"

  if [[ "$(uname -s)" == "Darwin" ]]; then
    antigen_load_bundles "${ANTIGEN_DARWIN_BUNDLES[@]}"
    export HOMEBREW_NO_ENV_HINTS=1
  fi

  antigen_load_bundles "${ANTIGEN_EXTRA_BUNDLES[@]}"
  antigen theme "$ANTIGEN_THEME"
  antigen apply
fi
