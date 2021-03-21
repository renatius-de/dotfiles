" {{{ load files
if filereadable(g:vimfiles . "/after/ftplugin/programming.vim")
    execute "source " . g:vimfiles . "/after/ftplugin/programming.vim"
endif
"}}}

" {{{ foldmethod
" The kind of folding used for the current window.
setlocal foldmethod=indent
"}}}

" {{{ matchpairs
" Characters that form pairs. The |%| command jumps from one to the other.
" Currently only single byte character pairs are allowed, and they must be
" different. The characters must be separated by a colon. The pairs must be
" separated by a comma.
setlocal matchpairs+=<:>
"}}}

" {{{ omnifunc
" This option specifies a function to be used for Insert mode omni completion
" with CTRL-X CTRL-O. |i_CTRL-X_CTRL-O| See |complete-functions| for an
" explanation of how the function is invoked and what it should return.
setlocal omnifunc=xmlcomplete#CompleteTags
"}}}

" {{{ shiftwidth
" Number of spaces to use for each step of (auto)indent. Used for |'cindent'|,
" |>>|, |<<|, etc.
set shiftwidth=2
"}}}

" {{{ softtabstop
" Number of spaces that a <Tab> counts for while performing editing
" operations, like inserting a <Tab> or using <BS>. It "feels" like <Tab>s are
" being inserted, while in fact a mix of spaces and <Tab>s is used. This is
" useful to keep the 'ts' setting at its standard value of 8, while being able
" to edit like it is set to 'sts'. However, commands like "x" still work on
" the actual characters.
set softtabstop=2
"}}}

" vim: filetype=vim textwidth=80 foldmethod=marker
