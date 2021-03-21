# {{{ system configuration
# language settings (read in /etc/environment before /etc/default/locale as
# the latter one is the default on Debian nowadays)
# no xsource() here because it's only created in zshrc! (which is good)
[[ -r /etc/environment ]] && source /etc/environment || true

# source the default .zshenv, especialy interisting in Gentoo Linux systems
[[ -r /etc/zsh/zshenv ]] && source /etc/zsh/zshenv || true
[[ -r /etc/zshenv ]]     && source /etc/zshenv     || true
[[ -r ~/.shell/export ]] && source ~/.shell/export || true
#}}}

# {{{ load colors
if [[ $- = *i* ]]; then
    autoload -Uz colors zsh/terminfo
    [[ $terminfo[colors] -ge 8 ]] && colors

    NO_COLOR=%{$reset_color%}

    BLINK=%{$terminfo[blink]%}
    INVERSE=%{$terminfo[inverse]%}
    UNDERLINE=%{$terminfo[underline]%}
    BOLD=%{$bold_color%}

    for color in BLACK BLUE CYAN DEFAULT GREEN GREY MAGENTA RED WHITE YELLOW
    do
        builtin eval ${color}=%{$fg[${(L)color}]%}
        builtin eval BACK_${color}=%{$bg[${(L)color}]%}

        builtin eval BOLD_${color}=%{${BOLD}$fg[${(L)color}]%}
        builtin eval BACKBOLD${color}=%{${BOLD}$bg[${(L)color}]%}
    done

    # colors for ls, etc.
    if [[ -x /usr/bin/dircolors ]]; then
        builtin eval $(dircolors -b)
    fi
fi
#}}}

# vim: filetype=zsh textwidth=80 foldmethod=marker
