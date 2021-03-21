set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

if filereadable("/usr/bin/python2")
    let g:python2_host_prog = "/usr/bin/python2"
elseif filereadable("/usr/local/bin/python2")
    let g:python2_host_prog = "/usr/local/bin/python2"
endif

if filereadable("/usr/bin/python3")
    let g:python3_host_prog = "/usr/bin/python3"
elseif filereadable("/usr/local/bin/python3")
    let g:python3_host_prog = "/usr/local/bin/python3"
endif

source expand("~/.dotfiles/vim/config/vimrc")

" vim: filetype=vim textwidth=80 foldmethod=marker
