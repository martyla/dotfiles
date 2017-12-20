" Hasn't been made backwards compatible
if has('nvim')
    let g:deoplete#enable_at_startup = 1

    " deoplete-ternjs
    let g:deoplete#sources#ternjs#types = 1
    let g:deoplete#sources#ternjs#docs = 1
    let g:deoplete#sources#ternjs#case_insensitive = 1
endif
