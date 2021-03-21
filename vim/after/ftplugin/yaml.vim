" {{{ load files
if filereadable(g:vimfiles . "/after/ftplugin/programming.vim")
    execute "source " . g:vimfiles . "/after/ftplugin/programming.vim"
endif
"}}}

setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" vim: filetype=vim textwidth=80 foldmethod=marker
