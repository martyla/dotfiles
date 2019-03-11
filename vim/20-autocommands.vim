" Auto resize windows when host resize (C-w =)
autocmd VimResized * wincmd =

augroup nopastemode
    autocmd InsertLeave * :set nopaste
augroup end

" Supress readonly message
au BufEnter * set noro
