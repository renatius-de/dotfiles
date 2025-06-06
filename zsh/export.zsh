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

if which nvim >/dev/null 2>&1; then
  EDITOR="nvim"
  VISUAL="nvim -R"
elif which vim >/dev/null 2>&1; then
  EDITOR="vim"
  VISUAL="vim -R"
fi
export EDITOR="${EDITOR:-vi}"
export VISUAL="${VISUAL:-${EDITOR}}"

export MANWIDTH="120"
export TZ="Europe/Berlin"

if [[ -r /Library/Java/JavaVirtualMachines/amazon-corretto-21.jdk/Contents/Home ]]; then
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-21.jdk/Contents/Home
elif [[ -r /Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home ]]; then
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home
fi
