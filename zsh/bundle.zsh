typeset -gr ANTIGEN_DEFAULT_FILE="/opt/homebrew/share/antigen/antigen.zsh"
typeset -gr ANTIGEN_THEME="candy"
typeset -gra ANTIGEN_COMMON_BUNDLES=(
  aliases
  common-aliases
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
  /bin
  /usr/bin
  /usr/local/bin

  /sbin
  /usr/sbin
  /usr/local/sbin

  /opt/homebrew/bin
  /opt/homebrew/sbin

  ~/.jenv/shims
)
typeset -gr OH_MY_ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-${HOME}/.antigen/bundles/robbyrussell/oh-my-zsh/cache}"
typeset -gr OH_MY_ZSH_COMPLETIONS_DIR="${OH_MY_ZSH_CACHE_DIR}/completions"
ANTIGEN_FILE="${ANTIGEN_FILE:-$ANTIGEN_DEFAULT_FILE}"

is_macos() {
  [[ "$(uname -s)" == "Darwin" ]]
}

antigen_load_bundles() {
  local bundle
  for bundle in "$@"; do
    antigen bundle "$bundle"
  done
}

ensure_omz_cache() {
  mkdir -p "$OH_MY_ZSH_COMPLETIONS_DIR"
}

java_environment_enable_export() {
  if command -v jenv >/dev/null 2>&1; then
    jenv enable-plugin export >/dev/null 2>&1
  fi
}

antigen_setup() {
  local antigen_file="$1"
  # shellcheck disable=SC1090
  source "$antigen_file"
  antigen use oh-my-zsh

  if is_macos; then
    antigen_load_bundles "${ANTIGEN_DARWIN_BUNDLES[@]}"
    export HOMEBREW_NO_ENV_HINTS=1
    export SHELL_SESSIONS_DISABLE=1
  fi

  antigen_load_bundles "${ANTIGEN_COMMON_BUNDLES[@]}"
  antigen_load_bundles "${ANTIGEN_EXTRA_BUNDLES[@]}"
  antigen theme "$ANTIGEN_THEME"
  antigen apply
}

typeset -Ua path
path_prepend() {
  local dir
  for dir in "$@"; do
    dir=${dir:A}
    [[ ! -d "$dir" ]] && continue
    path=("$dir" "${path[@]}")
  done
}

if [[ -r "$ANTIGEN_FILE" ]]; then
  antigen_setup "$ANTIGEN_FILE"
fi

autoload -U colors;
colors
function right_prompt() {
  local prompt

  prompt="%{$reset_color%}("
  [[ -r ~/.kube/config ]] && prompt+="%{$reset_color%}K8s: %{$fg[blue]%}${ZSH_KUBECTL_PROMPT}"
  [[ -r ~/.kube/config ]] && which docker > /dev/null 2>&1 && prompt+=" %{$fg[yellow]%}| "
  which docker > /dev/null 2>&1 && prompt+="%{$reset_color%}JDK: %{$fg[cyan]%}$(jenv_prompt_info)"
  prompt+="%{$reset_color%})"

  echo ${prompt}
}
export RPROMPT='$(right_prompt)'

ensure_omz_cache
java_environment_enable_export
path_prepend "${CUSTOM_PATH_DIRECTORIES[@]}"

typeset -ga __TEMP_FUNCS=(
  java_environment_enable_export
  ensure_omz_cache
  is_macos
  antigen_load_bundles
  antigen_setup
  path_prepend
)
unfunction "${__TEMP_FUNCS[@]}"
