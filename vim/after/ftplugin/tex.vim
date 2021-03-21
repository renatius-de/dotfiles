" {{{ load files
if filereadable(g:vimfiles . "/after/ftplugin/programming.vim")
    execute "source " . g:vimfiles . "/after/ftplugin/programming.vim"
endif
"}}}

" {{{ softtabstop
" Number of spaces that a <Tab> counts for while performing editing operations,
" like inserting a <Tab> or using <BS>. It "feels" like <Tab>s are being
" inserted, while in fact a mix of spaces and <Tab>s is used. This is useful to
" keep the 'ts' setting at its standard value of 8, while being able to edit
" like it is set to 'sts'. However, commands like "x" still work on the actual
" characters.
" When 'sts' is zero, this feature is off.
" 'softtabstop' is set to 0 when the 'paste' option is set.
" See also ins-expandtab. When 'expandtab' is not set, the number of spaces is
" minimized by using <Tab>s.
" The 'L' flag in 'cpoptions' changes how tabs are used when 'list' is set.
setlocal softtabstop=2
"}}}

" {{{ shiftwidth
" Number of spaces to use for each step of (auto)indent. Used for |'cindent'|,
" |>>|, |<<|, etc.
setlocal shiftwidth=2
"}}}

" {{{ textwidth
" Maximum width of text that is being inserted. A longer line will be broken
" after whitespace to get this width. A zero value disables this. 'textwidth'
" is set to 0 when the 'paste' option is set. When 'textwidth' is zero,
" 'wrapmargin' may be used. See also 'formatoptions' and |ins-textwidth|. When
" 'formatexpr' is set it will be used to break the line.
" NOTE: This option is set to 0 when 'compatible' is set.
setlocal textwidth=120
"}}}

" {{{ replace german umlauts
imap ä ä
imap Ä Ä
imap ü ü
imap Ü Ü
imap ö ö
imap Ö Ö
imap ß ß
"}}}

" vim: filetype=vim textwidth=80 foldmethod=marker
