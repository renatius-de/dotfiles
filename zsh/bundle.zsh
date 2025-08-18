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
)
typeset -gra ANTIGEN_EXTRA_BUNDLES=(
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
)
typeset -gr OH_MY_ZSH_CACHE_DIR="$HOME/.antigen/bundles/robbyrussell/oh-my-zsh/cache"
typeset -gr OH_MY_ZSH_COMPLETIONS_DIR="$OH_MY_ZSH_CACHE_DIR/completions"
# shellcheck disable=SC2155
typeset -gr IS_MAC_OS="$([[ $(uname -s) == "Darwin" ]] && echo 1 || echo 0)"

ANTIGEN_FILE="${ANTIGEN_FILE:-$ANTIGEN_DEFAULT_FILE}"

load_antigen_bundles() {
  local bundle
  for bundle in "$@"; do
    antigen bundle "$bundle"
  done
}

ensure_ohmyzsh_cache_dirs() {
  if [[ -d "$OH_MY_ZSH_CACHE_DIR" ]] && [[ ! -d "$OH_MY_ZSH_COMPLETIONS_DIR" ]]; then
    mkdir -m 0700 "$OH_MY_ZSH_COMPLETIONS_DIR"
  fi
}

setup_antigen() {
  # shellcheck disable=SC1090
  source "$ANTIGEN_FILE"
  antigen use oh-my-zsh

  if [[ "$IS_MAC_OS" -eq 1 ]]; then
    load_antigen_bundles "${ANTIGEN_DARWIN_BUNDLES[@]}"
    export HOMEBREW_NO_ENV_HINTS=1
  fi

  load_antigen_bundles "${ANTIGEN_COMMON_BUNDLES[@]}"
  load_antigen_bundles "${ANTIGEN_EXTRA_BUNDLES[@]}"

  antigen theme "$ANTIGEN_THEME"
  antigen apply
}

if [[ -r "$ANTIGEN_FILE" ]]; then
  setup_antigen
fi

ensure_ohmyzsh_cache_dirs
