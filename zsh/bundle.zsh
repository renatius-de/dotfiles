typeset -gr ANTIGEN_DEFAULT_FILE="/opt/homebrew/share/antigen/antigen.zsh"
typeset -gr ANTIGEN_THEME="candy"
typeset -gra ANTIGEN_COMMON_BUNDLES=(
  aliases
  docker
  docker-compose
  gradle
  history-substring-search
  jenv
  k9s
  kubectl
  mvn
  themes
  vi-mode
  zsh-navigation-tools
)
typeset -gra ANTIGEN_DARWIN_BUNDLES=(
  brew
)
typeset -gra ANTIGEN_EXTRA_BUNDLES=(
  MichaelAquilina/zsh-you-should-use
  superbrothers/zsh-kubectl-prompt

  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
)
typeset -gra CUSTOM_PATH_DIRECTORIES=(
  ~/.jenv/shims

  /opt/homebrew/sbin
  /opt/homebrew/bin

  /usr/local/sbin
  /usr/sbin
  /sbin

  /usr/local/bin
  /usr/bin
  /bin
)
typeset -gr OH_MY_ZSH_CACHE_DIR="$HOME/.antigen/bundles/robbyrussell/oh-my-zsh/cache"
typeset -gr OH_MY_ZSH_COMPLETIONS_DIR="${OH_MY_ZSH_CACHE_DIR}/completions"
ANTIGEN_FILE="${ANTIGEN_FILE:-$ANTIGEN_DEFAULT_FILE}"

is_darwin() {
  [[ "$(uname -s)" == "Darwin" ]]
}

load_antigen_bundles() {
  local bundle
  for bundle in "$@"; do
    antigen bundle "$bundle"
  done
}

ensure_oh_my_zsh_cache() {
  mkdir -p "$OH_MY_ZSH_COMPLETIONS_DIR"
}

enable_java_environment_export() {
  if command -v jenv >/dev/null 2>&1; then
    jenv enable-plugin export
  fi
}

setup_antigen() {
  local antigen_file="$1"
  # shellcheck disable=SC1090
  source "$antigen_file"
  antigen use oh-my-zsh

  if is_darwin; then
    load_antigen_bundles "${ANTIGEN_DARWIN_BUNDLES[@]}"
    export HOMEBREW_NO_ENV_HINTS=1
    export SHELL_SESSIONS_DISABLE=1
  fi

  load_antigen_bundles "${ANTIGEN_COMMON_BUNDLES[@]}"
  load_antigen_bundles "${ANTIGEN_EXTRA_BUNDLES[@]}"

  antigen theme "$ANTIGEN_THEME"
  antigen apply
}

if [[ -r "$ANTIGEN_FILE" ]]; then
  setup_antigen "$ANTIGEN_FILE"
fi


typeset -Ua path
prepend_to_path() {
  local dir
  for dir in "$@"; do
    dir=${dir:A}
    [[ ! -d "$dir" ]] && return

    path=("$dir" ${path[@]})
  done
}

ensure_oh_my_zsh_cache
enable_java_environment_export
prepend_to_path "${CUSTOM_PATH_DIRECTORIES[@]}"

autoload -U colors
colors
RPROMPT='%{$reset_color%} (K: %{$fg[cyan]%}${ZSH_KUBECTL_PROMPT}%{$reset_color%}'
RPROMPT+=' | '
RPROMPT+='%{$reset_color%}J: %{$fg[cyan]%}$(jenv_prompt_info)%{$reset_color%})'
export RPROMPT

unfunction enable_java_environment_export
unfunction ensure_oh_my_zsh_cache
unfunction is_darwin
unfunction load_antigen_bundles
unfunction setup_antigen
unfunction prepend_to_path
