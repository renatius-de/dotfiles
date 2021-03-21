" {{{ load files
if filereadable(g:vimfiles . "/after/ftplugin/html.vim")
    execute 'source ' . g:vimfiles . '/after/ftplugin/html.vim'
endif
"}}}

" vim: filetype=vim textwidth=80 foldmethod=marker
