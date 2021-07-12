# Global aliases
alias -g G='|& egrep --ignore-case'
alias -g N='&> /dev/null'

# remap the buildin commads
alias which='whence -vas'
alias where='whence -cas'

# no spell correction for cp, mv, rm, mkdir, rmdir and adding default options
alias cp='nocorrect cp'
alias mv='nocorrect mv'
alias ln='nocorrect ln'
alias mkdir='nocorrect mkdir'

# shellcheck disable=SC2139
which keychain >/dev/null 2>&1 && alias kadd="keychain --timeout $((60 * 12)) ~/.ssh/keys/**/id*~*.pub"
