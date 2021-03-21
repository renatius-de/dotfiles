" only do any confiuration if the plugin is available and loaded
if ! exists("loaded_matchit") || &cp
  finish
endif

" If you
"   :let b:match_ignorecase=1
" then matchit.vim acts as if 'ignorecase' is set: for example, "end" and "END"
" are equivalent. If you
"   :let b:match_ignorecase=0
" then matchit.vim treats "end" and "END" differently. (There will be no
" b:match_infercase option unless someone requests it.)
let b:match_ignorecase=1
