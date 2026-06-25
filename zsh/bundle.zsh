export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
export ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-$HOME/.cache/zsh}"
mkdir -p "$ZSH_CACHE_DIR/completions"

ZSH_THEME="candy"

plugins=(
  aliases
  common-aliases
  docker
  docker-compose
  git
  gradle
  history-substring-search
  jenv
  sudo
  vi-mode
  zsh-navigation-tools
)

[[ "$(uname -s)" == "Darwin" ]] && {
  plugins+=(brew eza)
  export HOMEBREW_NO_ENV_HINTS=1
  export SHELL_SESSIONS_DISABLE=1
}

[[ WORK_ENV == "true" ]] && {
  plugins+=(
    k9s
    kubectl
    mvn
    node
  )
}

if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# Load external plugins from $ZSH_CUSTOM/plugins when available
for plugin in zsh-you-should-use zsh-kubectl-prompt zsh-autosuggestions zsh-completions zsh-syntax-highlighting; do
  plugin_file="$ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh"
  [[ -f "$plugin_file" ]] && source "$plugin_file"
done

(( $+commands[jenv] )) && jenv enable-plugin export >/dev/null 2>&1

typeset -Ua path
path=(
  $HOME/.local/bin
  /opt/homebrew/bin /opt/homebrew/sbin
  /usr/local/bin /usr/local/sbin
  /usr/bin /usr/sbin
  /bin /sbin
  ~/.jenv/shims
  "${path[@]}"
)

autoload -U colors
colors

if command -v dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"
fi

_build_rprompt() {
  local parts=()
  [[ -r ~/.kube/config ]] && parts+=("K8s: %{$fg[blue]%}${ZSH_KUBECTL_PROMPT}")
  (( $+commands[jenv] )) && parts+=("JDK: %{$fg[cyan]%}$(jenv_prompt_info)")
  [[ ${#parts[@]} -gt 0 ]] && echo "(%{$reset_color%}${(j: | :)parts}%{$reset_color%})" || echo ""
}

export RPROMPT=$(_build_rprompt)
