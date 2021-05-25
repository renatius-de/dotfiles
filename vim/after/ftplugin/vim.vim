if filereadable(g:vimfiles . "/after/ftplugin/programming.vim")
    execute "source " . g:vimfiles . "/after/ftplugin/programming.vim"
endif
setlocal foldlevel=0
setlocal foldlevelstart=0
setlocal foldmethod=marker
if bufname('') =~# '^\%(' . (v:version < 702 ? 'command-line' : '\[Command Line\]') . '\|option-window\)$'
    setlocal nofoldenable
else
    setlocal foldcolumn=4
endif
let g:vimsyn_folding='afmpqrt'
