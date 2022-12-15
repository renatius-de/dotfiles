if which nvim >/dev/null 2>&1; then
  EDITOR="nvim"
  VISUAL="nvim -R"
  FCEDIT="nvim"
elif which vim >/dev/null 2>&1; then
  EDITOR="vim"
  VISUAL="vim -R"
  FCEDIT="vim"
fi
export EDITOR="${EDITOR:-vi}"
export VISUAL="${VISUAL:-${EDITOR}}"
export FCEDIT="${FCEDIT:-${EDITOR}}"

export MANWIDTH="72"
export TAR_OPTIONS="--auto-compress --delay-directory-restore --exclude-backups --exclude-caches --no-overwrite-dir --numeric-owner --totals"
export TZ="Europe/Berlin"

export LC_ADDRESS=de_DE.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_IDENTIFICATION=en_US.UTF-8
export LC_MEASUREMENT=de_DE.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NAME=de_DE.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_PAPER=de_DE.UTF-8
export LC_TELEPHONE=de_DE.UTF-8
export LC_TIME=de_DE.UTF-8

export LANG=en_US.UTF-8
export LANGUAGE=en_GB:en_US:en

unset LC_ALL

export CDPATH=".:~"
export DIRSTACKSIZE="32"
export HISTFILE=~/.cache/zsh/history
export HISTSIZE="10000"
export LINES="200"
export LISTMAX="${LINES:200}"
export REPORTTIME="300"
export SAVEHIST="${HISTSIZE:100}"
if [[ ${TERM} == linux ]]; then
  readonly TMOUT=300
  export TMOUT
fi
unset LOGCHECK
unset MAIL
unset MAILCHECK
unset MAILPATH

typeset -U path

[[ -d /sbin ]]           && path=($path /sbin)
[[ -d /usr/sbin ]]       && path=($path /usr/sbin)
[[ -d /usr/local/sbin ]] && path=($path /usr/local/sbin)
[[ -d /bin ]]            && path=($path /bin)
[[ -d /usr/bin ]]        && path=($path /usr/bin)
[[ -d /usr/local/bin ]]  && path=($path /usr/local/bin)

# set PATH so it includes user's private bin if it exists
[[ -d ~/bin ]] && path=(~/bin $path)

# add rvm to path
[[ -d ~/.rvm/bin ]]                && path=(~/.rvm/bin $path)
[[ -d ~/.rvm/rubies/default/bin ]] && path=(~/.rvm/rubies/default/bin $path)

# add local rubygems installs
if which ruby > /dev/null 2>&1 && which gem > /dev/null 2>&1; then
    [[ -d "$(ruby -e 'puts Gem.user_dir')"/bin ]] && path=("$(ruby -e 'puts Gem.user_dir')"/bin $path)
fi
export PATH
