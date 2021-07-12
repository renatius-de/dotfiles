if [[ -r ~/.zsh/plugin/antigen.zsh ]]; then
    # shellcheck disable=SC1090
    source ~/.zsh/plugin/antigen.zsh

    # load the oh-my-zsh's library.
    antigen use oh-my-zsh

    # bundles from the default repo (robbyrussell's oh-my-zsh).
    antigen bundle docker
    antigen bundle editor
    antigen bundle gpg-agent
    antigen bundle history-substring-search
    antigen bundle keychain
    antigen bundle pass
    antigen bundle rvm
    antigen bundle sdk
    antigen bundle ssh-agent
    antigen bundle themes
    antigen bundle tmuxinator
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
