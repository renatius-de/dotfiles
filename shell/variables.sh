# shellcheck shell=bash
case $- in
!*i*)
  return
  ;;
esac
[[ -z "$PS1" ]] && return

if [[ ${TERM} == linux ]]; then
  TMOUT=300
  readonly TMOUT
  export TMOUT
else
  unset TMOUT
fi
