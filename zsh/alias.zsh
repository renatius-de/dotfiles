alias which="whence -vas"
alias where="whence -cas"

alias cp="nocorrect cp"
alias ln="nocorrect ln"
alias mkdir="nocorrect mkdir"
alias mv="nocorrect mv"

alias ls="ls -@FG"
alias l="ls -hln"
alias la="ls -A"
alias ll="l -A"

alias rm="rm -iv"
alias md="mkdir -m 0700 -pv"
alias rd="rmdir -p"

alias grep="grep --color=auto"

# shellcheck disable=SC2154
if (( $+commands[docker] )); then
  alias dspruea="docker system prune --all --force --volumes ; docker builder prune --all --force"
  alias dbpru="docker builder prune"
fi

# shellcheck disable=SC2154
if (( $+commands[mvn] )); then
  alias mvnpitcv="mvn -pl integration-test -P integration-test clean verify"
  alias mvnpitdu="mvn -pl integration-test -P integration-test docker:start docker:volume-create"
  alias mvnpitdd="mvn -pl integration-test -P integration-test docker:stop docker:remove docker:volume-remove"
fi

# shellcheck disable=SC2154
if (( $+commands[nvim] )); then
  alias vi="nvim"
  alias view="nvim -R"
  alias vim="nvim"
  alias vimdiff="nvim -d"
fi
