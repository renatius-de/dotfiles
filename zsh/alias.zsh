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

if which docker > /dev/null 2>&1; then
  alias dprune="docker system prune --all --force --volumes ; docker builder prune --all --force"
fi

which kubectl > /dev/null 2>&1 && alias k="kubectl"

if which mvn > /dev/null 2>&1; then
  alias mvn="umask 0022 && chmod -R u+rwX,go+rX ~/.m2 * ; mvn --errors --fail-fast --update-snapshots"

  alias mvna="mvn clean install"
  alias mvnac="mvn -DskipTests -DskipITs clean install"

  alias mvni="mvn -pl integration-test -P integration-test clean verify"
  alias mvndu="mvn -pl integration-test -P integration-test docker:start docker:volume-create"
  alias mvndd="mvn -pl integration-test -P integration-test docker:stop docker:remove docker:volume-remove"
fi

if which nvim > /dev/null 2>&1; then
  alias vi="nvim"
  alias view="nvim -R"
  alias vim="nvim"
  alias vimdiff="nvim -d"
elif which vim >/dev/null 2>&1; then
  alias vi="vim"
  alias ex="vim -E"
fi
