setlocal diffopt+=iwhite
setlocal endofline
setlocal foldlevel=0
setlocal foldlevelstart=0
setlocal foldmethod=marker
setlocal formatoptions=cronb1
setlocal textwidth=120
if v:version >= 704
    setlocal formatoptions+=j
endif
if bufname('') =~# '^\%(' . (v:version < 702 ? 'command-line' : '\[Command Line\]') . '\|option-window\)$'
    setlocal nofoldenable
else
    setlocal foldcolumn=4
endif
let g:vimsyn_folding='afmpqrt'
