[[ $- != *i* ]] && return

unalias -a
umask 0077

[[ -r ~/.shell/export ]] && source ~/.shell/export

for sh in ~/.shell/*.sh; do
    [[ -r "${sh}" ]] && source "${sh}" || true
done
unset sh

# vim:filetype=sh textwidth=80
