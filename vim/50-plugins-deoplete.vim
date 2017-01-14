" Hasn't been made backwards compatible
if has('nvim')
    let g:deoplete#enable_at_startup = 1

    " <TAB>/<s-TAB> completion
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
endif
