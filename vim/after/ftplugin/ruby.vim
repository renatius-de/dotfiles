" {{{ load files
if filereadable(g:vimfiles . "/after/ftplugin/programming.vim")
    execute "source " . g:vimfiles . "/after/ftplugin/programming.vim"
endif
"}}}

" {{{ omnifunc
" This option specifies a function to be used for Insert mode omni completion
" with CTRL-X CTRL-O. |i_CTRL-X_CTRL-O| See |complete-functions| for an
" explanation of how the function is invoked and what it should return.
setlocal omnifunc=rubycomplete#Complete
"}}}

" vim: filetype=vim textwidth=80 foldmethod=marker
