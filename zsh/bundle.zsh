if [[ -r ~/.zsh/plugin/antigen/antigen.zsh ]]; then
    # shellcheck disable=SC1090
    source ~/.zsh/plugin/antigen/antigen.zsh

    # load the oh-my-zsh's library.
    antigen use oh-my-zsh

    # bundles from the default repo (robbyrussell's oh-my-zsh).
    antigen bundle brew
    which docker >/dev/null 2>&1 && antigen bundle docker
    which docker-compose >/dev/null 2>&1 && antigen bundle docker-compose
    which git >/dev/null 2>&1 && antigen bundle git
    which gradle >/dev/null 2>&1 && antigen bundle gradle
    which helm >/dev/null 2>&1 && antigen bundle helm
    antigen bundle history-substring-search
    which keychain >/dev/null 2>&1 && antigen bundle keychain
    which kubectl >/dev/null 2>&1 && antigen bundle kubectl
    which kubectl >/dev/null 2>&1 && antigen bundle kubectx
    antigen bundle macos
    which mvn >/dev/null 2>&1 && antigen bundle mvn
    antigen bundle nvm
    antigen bundle rvm
    which sbt >/dev/null 2>&1 && antigen bundle sbt
    antigen bundle sdk
    antigen bundle ssh-agent
    which terraform >/dev/null 2>&1 && antigen bundle terraform
    antigen bundle themes
    which tig >/dev/null 2>&1 && antigen bundle tig
    which tmux >/dev/null 2>&1 && antigen bundle tmux
    which tmuxinator >/dev/null 2>&1 && antigen bundle tmuxinator
    antigen bundle vi-mode

    # add bundles from ush users
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle zsh-users/zsh-completions
    antigen bundle zsh-users/zsh-syntax-highlighting

    # bundles from misc repos
    antigen bundle lukechilds/zsh-nvm

    antigen theme candy

    # tell antigen that you're done.
    antigen apply
fi
