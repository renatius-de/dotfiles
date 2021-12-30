if which nvim >/dev/null 2>&1; then
  EDITOR="nvim"
elif which vim >/dev/null 2>&1; then
  EDITOR="vim"
fi
export EDITOR="${EDITOR:-vi}"

if which nvim >/dev/null 2>&1; then
  VISUAL="nvim -R"
elif which vim >/dev/null 2>&1; then
  VISUAL="vim -R"
fi
export VISUAL="${VISUAL:-${EDITOR}}"

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
