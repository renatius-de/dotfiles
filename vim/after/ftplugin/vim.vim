" {{{ load files
if filereadable(g:vimfiles . "/after/ftplugin/programming.vim")
    execute "source " . g:vimfiles . "/after/ftplugin/programming.vim"
endif
"}}}

" {{{ foldlevel
" Sets the fold level: Folds with a higher level will be closed. Setting this
" option to zero will close all folds. Higher numbers will close fewer folds.
setlocal foldlevel=0
"}}}

" {{{ foldlevelstart
" Sets 'foldlevel' when starting to edit another buffer in a window. Useful to
" always start editing with all folds closed (value zero), some folds closed
" (one) or no folds closed (99).
setlocal foldlevelstart=0
"}}}

" {{{ foldmethod
" Folding via syntax is used for this filetype.
setlocal foldmethod=marker
"}}}

" {{{ foldcolumn
" VIM's command window ('q:') and the :options window also set filetype=vim.
" We do not want folding in these enabled by default, though, because some
" malformed :if, :function, ... commands would fold away everything from the
" malformed command until the last command.
if bufname('') =~# '^\%(' . (v:version < 702 ? 'command-line' : '\[Command Line\]') . '\|option-window\)$'
    " With this, folding can still be enabled easily via any zm, zc, zi, ...
    " command.
    setlocal nofoldenable
else
    " Fold settings for ordinary windows.
    setlocal foldcolumn=4
endif
"}}}

" {{{ vim plugin
" Some folding is now supported with syntax/vim.vim
let g:vimsyn_folding='afmpqrt'
"}}}

" vim: filetype=vim textwidth=80 foldmethod=marker
