if filereadable(g:vimfiles . "/after/ftplugin/git.vim")
    execute "source " . g:vimfiles . "/after/ftplugin/git.vim"
endif

setlocal spelllang=en_gb,en_us,en
setlocal spell
setlocal splitbelow
