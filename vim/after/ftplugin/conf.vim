" {{{ foldmethod
" The kind of folding used for the current window.
setlocal foldmethod=marker
"}}}

" {{{ textwidth
" Maximum width of text that is being inserted. A longer line will be broken
" after whitespace to get this width. A zero value disables this. 'textwidth'
" is set to 0 when the 'paste' option is set. When 'textwidth' is zero,
" 'wrapmargin' may be used. See also 'formatoptions' and |ins-textwidth|.
" When 'formatexpr' is set it will be used to break the line.
setlocal textwidth=80
"}}}

" vim: filetype=vim textwidth=80 foldmethod=marker
