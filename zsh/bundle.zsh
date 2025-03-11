if [[ -r ~/.zsh/plugin/antigen/antigen.zsh ]]; then
    # shellcheck disable=SC1090
    source ~/.zsh/plugin/antigen/antigen.zsh

    # load the oh-my-zsh's library.
    antigen use oh-my-zsh

    # bundles from the default repo (robbyrussell's oh-my-zsh).
    antigen bundle asdf
    antigen bundle history-substring-search
    antigen bundle themes
    antigen bundle vi-mode

    if [ "$(uname)" = "Darwin" ];then
      antigen bundle macos
      antigen bundle brew
    fi

    # add bundles from ush users
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle zsh-users/zsh-completions
    antigen bundle zsh-users/zsh-syntax-highlighting

    antigen theme candy

    # tell antigen that you're done.
    antigen apply
fi

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
