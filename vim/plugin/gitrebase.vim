function! s:RebaseLog()
    let line = getline('.')
    let hash = matchstr(line,'\(^\w\+\s\)\@<=\w*')

    vnew
    setlocal bufhidden=wipe
    setlocal buftype=nofile
    setlocal cursorline
    setlocal foldcolumn=0
    setlocal nobuflisted
    setlocal nonumber
    setlocal noswapfile
    setlocal nowrap

    let output = system(printf('git log -p %s^1..%s', hash, hash))

    silent put=output
    silent normal ggdd
    setlocal nomodifiable
    setfiletype git

    nmap <silent><buffer> L <C-w>q
endf

function! s:RebaseAction(name)
    exec 's/^\w\+/'.a:name.'/'
endf

function! s:InitGitRebase()
    nmap <silent><buffer> L :call <SID>RebaseLog()<CR>
    nmap <silent><buffer> P :call <SID>RebaseAction('pick')<CR>
    nmap <silent><buffer> e :call <SID>RebaseAction('edit')<CR>
    nmap <silent><buffer> f :call <SID>RebaseAction('fixup')<CR>
    nmap <silent><buffer> s :call <SID>RebaseAction('squash')<CR>
    nmap <silent><buffer> r :call <SID>RebaseAction('reword')<CR>

    nmap <script><silent><buffer> H :call <SID>showHelp()<CR>
endf

fun! s:showHelp()
    redraw
    echo " Git rebase helper:"
    echo "   L   - view commit log"
    echo "   P   - pick"
    echo "   e   - edit"
    echo "   s   - squash"
    echo "   r   - reword"
    echo "   D   - delete"
endf

augroup GitRebase
    autocmd!
    autocmd filetype gitrebase :call s:InitGitRebase()
augroup END

" vim: filetype=vim textwidth=80 foldmethod=marker
