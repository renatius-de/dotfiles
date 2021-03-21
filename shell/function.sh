# {{{ test for an interactive shell
case $- in
    !*i*) return
        ;;
esac
[[ -z "$PS1" ]] && return
#}}}

# {{{ reload configuration
function reload() {
    if [ -n ${ZSH_NAME} ]; then
        while (( $# )); do
            unfunction $1
            autoload -U $1
            shift
        done

        [[ -r ~/.profile ]]  && source ~/.profile
        [[ -r ~/.zshenv ]]   && source ~/.zshenv
        [[ -r ~/.zprofile ]] && source ~/.zprofile
        [[ -r ~/.zshrc ]]    && source ~/.zshrc

        return 0
    elif [ -n ${BASH} ]; then
        [[ -r ~/.profile ]]      && source ~/.profile
        [[ -r ~/.bash_profile ]] && source ~/.bash_profile
        [[ -r ~/.bashrc ]]       && source ~/.bashrc

        return 0
    fi
}
#}}}

# vim: filetype=sh foldmethod=marker textwidth=0
