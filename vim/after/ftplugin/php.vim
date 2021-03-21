" {{{ load files
if filereadable(g:vimfiles . "/after/ftplugin/programming.vim")
    execute "source " . g:vimfiles . "/after/ftplugin/programming.vim"
endif
"}}}

" {{{ dictionary
" List of file names, separated by commas, that are used to lookup words for
" keyword completion commands |i_CTRL-X_CTRL-K|. Each file should contain a
" list of words. This can be one word per line, or several words per line,
" separated by non-keyword characters (whitespace is preferred). Maximum line
" length is 510 bytes.
" When this option is empty, or an entry "spell" is present, spell checking is
" enabled the currently active spelling is used. |spell| To include a comma in
" a file name precede it with a backslash. Spaces after a comma are ignored,
" otherwise spaces are included in the file name. See |option-backslash| about
" using backslashes. This has nothing to do with the |Dictionary| variable
" type.
execute 'setlocal dictionary-=' . g:vimfiles . '/bundle/PHPDictionary/PHP.dict'
execute 'setlocal dictionary^=' . g:vimfiles . '/bundle/PHPDictionary/PHP.dict'
"}}}

" {{{ omnifunc
" This option specifies a function to be used for Insert mode omni completion
" with CTRL-X CTRL-O. |i_CTRL-X_CTRL-O| See |complete-functions| for an
" explanation of how the function is invoked and what it should return.
setlocal omnifunc=phpcomplete#CompletePHP
"}}}

" {{{ suffixesadd
" Comma separated list of suffixes, which are used when searching for a file for
" the "gf", "[I", etc. commands.
set suffixesadd+=.php
"}}}

" vim: filetype=vim textwidth=80 foldmethod=marker
