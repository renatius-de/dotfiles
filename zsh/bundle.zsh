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
  git-flow
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
  plugins+=(brew)
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
  [ -f "$plugin_file" ] && source "$plugin_file"
done

command -v jenv >/dev/null 2>&1 && jenv enable-plugin export >/dev/null 2>&1

CUSTOM_PATH_DIRECTORIES=(
  /bin /usr/bin /usr/local/bin
  /sbin /usr/sbin /usr/local/sbin
  /opt/homebrew/bin /opt/homebrew/sbin
  ~/.jenv/shims
)

typeset -Ua path
for dir in "${CUSTOM_PATH_DIRECTORIES[@]}"; do
  [[ -d "$dir" ]] && path=("$dir" "${path[@]}")
done

autoload -U colors; colors
right_prompt() {
  local prompt="%{$reset_color%}("
  [[ -r ~/.kube/config ]] && prompt+="%{$reset_color%}K8s: %{$fg[blue]%}${ZSH_KUBECTL_PROMPT}"
  command -v jenv >/dev/null 2>&1 && [[ -r ~/.kube/config ]] && prompt+=" %{$fg[yellow]%}| "
  command -v jenv >/dev/null 2>&1 && prompt+="%{$reset_color%}JDK: %{$fg[cyan]%}$(jenv_prompt_info)"
  prompt+="%{$reset_color%})"
  echo $prompt
}
export RPROMPT='$(right_prompt)'
