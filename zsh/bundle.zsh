if [[ -r ~/.zsh/plugin/antigen.zsh ]]; then
    source ~/.zsh/plugin/antigen.zsh

    # load the oh-my-zsh's library.
    antigen use oh-my-zsh

    # bundles from the default repo (robbyrussell's oh-my-zsh).
    antigen bundle direnv
    antigen bundle django
    antigen bundle docker
    antigen bundle editor
    antigen bundle extract
    antigen bundle gpg-agent
    antigen bundle gradle
    antigen bundle history-substring-search
    antigen bundle keychain
    antigen bundle mvn
    antigen bundle nmap
    antigen bundle pass
    antigen bundle rvm
    antigen bundle sbt
    antigen bundle sdk
    antigen bundle ssh-agent
    antigen bundle sudo
    antigen bundle systemd
    antigen bundle themes
    antigen bundle tmux
    antigen bundle tmuxinator
    antigen bundle ubuntu
    antigen bundle vagrant
    antigen bundle vi-mode
    antigen bundle zsh_reload

    # add bundles from ush users
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle zsh-users/zsh-completions
    antigen bundle zsh-users/zsh-history-substring-search
    antigen bundle zsh-users/zsh-syntax-highlighting

    # bundles from misc repos
    antigen bundle jreese/zsh-titles
    antigen bundle lukechilds/zsh-nvm

    antigen theme candy-kingdom

    # tell antigen that you're done.
    antigen apply
fi
