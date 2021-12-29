# shellcheck shell=bash
case $- in
!*i*)
  return
  ;;
esac
[[ -z "$PS1" ]] && return

alias ls="ls --color=auto --classify --dereference-command-line-symlink-to-dir --hide-control-chars --sort=version"

alias l="ls --human-readable --numeric-uid-gid -l --time-style=+'%Y-%m-%d %H:%m'"
alias la="ls --almost-all"
alias ll="l --almost-all"

alias rm="rm --interactive=once --verbose"
alias rm="rm --interactive=once --verbose"
alias rmdir="rmdir --verbose"
alias rd="rmdir --parents --ignore-fail-on-non-empty"
alias md="mkdir --mode=0700 --parents --verbose"
alias chgrp="chgrp --changes"
alias chmod="chmod --changes"
alias chown="chown --changes"
alias cp="cp -av"
alias grep="grep --color=auto"

which lsattr >/dev/null 2>&1 && alias lsattr="lsattr -a"
which chattr >/dev/null 2>&1 && alias chattr="chattr -R"

if which rsync >/dev/null 2>&1; then
  alias rsync="rsync --recursive --links --perms --times --owner --group --devices --specials --hard-links --whole-file --delete --cvs-exclude --prune-empty-dirs --compress --stats --human-readable --progress"
  alias rsync_fat="rsync --chmod='u=rwX,go=' --size-only"
fi

if which nvim >/dev/null 2>&1; then
  alias ex="nvim -E"
  alias vi="nvim"
  alias view="nvim -R"
  alias vim="nvim"
  alias vimdiff="nvim -d"
elif which vim >/dev/null 2>&1; then
  alias vi="vim"
  alias ex="vim -E"
fi

if which keychain >/dev/null 2>&1; then
  alias keychain="keychain --systemd"

  # shellcheck disable=SC2139
  alias kadd="keychain ~/.ssh/keys/**/id*~*.pub"

  # shellcheck disable=SC2139
  alias kclear="keychain --clear"
fi
