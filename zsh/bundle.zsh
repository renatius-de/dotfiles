export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
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
  k9s
  kubectl
  mvn
  vi-mode
  zsh-navigation-tools
)

if [[ "$(uname -s)" == "Darwin" ]]; then
  plugins+=(brew eza)
  export HOMEBREW_NO_ENV_HINTS=1
  export SHELL_SESSIONS_DISABLE=1
fi

external_plugins=(
  zsh-you-should-use
  zsh-kubectl-prompt
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

for plugin in "${external_plugins[@]}"; do
  plugin_file="$ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh"
  [[ -f "$plugin_file" ]] && source "$plugin_file"
done

command -v jenv >/dev/null 2>&1 && jenv enable-plugin export >/dev/null 2>&1

typeset -Ua path
path=(
  /opt/homebrew/bin /opt/homebrew/sbin
  /usr/local/bin /usr/local/sbin
  /usr/bin /usr/sbin
  /bin /sbin
  ~/.jenv/shims
  "${path[@]}"
)

autoload -U colors; colors

right_prompt() {
  local prompt="%{$reset_color%}("
  if [[ -r ~/.kube/config ]]; then
    prompt+="%{$reset_color%}K8s: %{$fg[blue]%}${ZSH_KUBECTL_PROMPT}"
  fi
  if command -v jenv >/dev/null 2>&1; then
    [[ -r ~/.kube/config ]] && prompt+=" %{$fg[yellow]%}| "
    prompt+="%{$reset_color%}JDK: %{$fg[cyan]%}$(jenv_prompt_info)"
  fi
  prompt+="%{$reset_color%})"
  echo "$prompt"
}

export RPROMPT='$(right_prompt)'
