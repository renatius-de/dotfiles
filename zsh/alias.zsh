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

if which docker-compose > /dev/null 2>&1; then
  alias dc="docker compose"
  alias dcsprune="docker system prune --all --force --volumes"

  alias dcb="dc build"
  alias dcdn="dc down --remove-orphans --volumes"
  alias dcl="dc logs --timestamps"
  alias dclf="dcl --follow"
  alias dcps="dc ps --all"
  alias dcup="dc up --build --detach --quiet-pull --remove-orphans --wait"
fi

if which mvn > /dev/null 2>&1; then
  alias mvn="mvn --errors --fail-fast --update-snapshots"

  alias mvna="mvn clean install"
  alias mvnac="mvn -DskipTests -DskipITs clean install"
  alias mvnad="mvna -P dev"
  alias mvnadc="mvnac -P dev"
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
