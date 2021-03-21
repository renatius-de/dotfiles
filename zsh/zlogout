# source the default .zlogout, especially interesting in Gentoo Linux systems
[[ -r /etc/zsh/zlogout ]] && source /etc/zsh/zlogout || true
[[ -r /etc/zlogout ]]     && source /etc/zlogout     || true

# clean maybe broken zcompdump file
[[ -e ~/.zcompdump ]]          && rm -f ~/.zcompdump
[[ -e ~/.cache/zsh/compinit ]] && rm -f ~/.cache/zsh/compinit

# finally run commands
setopt null_glob
[[ -r ~/.shell/logout ]]  && source ~/.shell/logout  || true

# vim: filetype=zsh textwidth=80 foldmethod=marker
