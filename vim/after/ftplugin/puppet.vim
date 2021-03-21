" {{{ load files
if filereadable(g:vimfiles . "/after/ftplugin/programming.vim")
    execute "source " . g:vimfiles . "/after/ftplugin/programming.vim"
endif
"}}}

" {{{ suffixesadd
" Comma separated list of suffixes, which are used when searching for a file for
" the "gf", "[I", etc. commands.
set suffixesadd+=.php
"}}}

" vim: filetype=vim textwidth=80 foldmethod=marker
