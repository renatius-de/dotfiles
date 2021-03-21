" {{{ load files
if filereadable(g:vimfiles . "/after/ftplugin/git.vim")
    execute "source " . g:vimfiles . "/after/ftplugin/git.vim"
endif
"}}}

" {{{ spell
" When on spell checking will be done.
setlocal spelllang=en_us,en_gb,en
setlocal spell
"}}}

" {{{ splitbelow
" When on, splitting a window will put the new window below the current one.
setlocal splitbelow
"}}}

" vim: filetype=vim textwidth=80 foldmethod=marker
