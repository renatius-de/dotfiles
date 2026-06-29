# Core shortcuts
alias which='whence -cas'
alias cp='nocorrect cp'
alias ln='nocorrect ln'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias grep='grep --color=auto'
alias path='printf "%s\n" "${path[@]}"'

# Navigation helpers
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias l='ls -hln'
alias la='ls -A'
alias ll='ls -hAl'

# Safety helpers
alias rm='rm -iv'
alias md='mkdir -m 0700 -pv'
alias rd='rmdir -p'

# Detect alternative ls implementation
if (( $+commands[eza] )); then
  alias ls='eza -@G'
else
  alias ls='ls -@FG'
fi

# Editor shortcuts
if (( $+commands[nvim] )); then
  alias vi='nvim'
  alias view='nvim -R'
  alias vim='nvim'
  alias vimdiff='nvim -d'
fi

# Docker helpers
if (( $+commands[docker] )); then
  alias dr='docker container run --interactive --rm --tty'
  alias dcr='docker compose run --interactive --quiet-pull --rm'
  alias dipru='docker image prune -a --filter "until=$((24 * 30))h"'
fi

# Maven helpers
if (( $+commands[mvn] )); then
  alias mvnpitcv='mvn -pl integration-test -P integration-test clean verify'
  alias mvnpitdu='mvn -pl integration-test -P integration-test docker:start docker:volume-create'
  alias mvnpitdd='mvn -pl integration-test -P integration-test docker:stop docker:remove docker:volume-remove'
fi

# k9s helpers
if (( $+commands[k9s] )); then
  alias k9s='k9s --all-namespaces --crumbsless --logoless --splashless'
fi
