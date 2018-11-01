" Hasn't been made backwards compatible
if has('nvim')
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#max_list = 20
    let g:deoplete#auto_complete_delay = 200

    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return deoplete#mappings#smart_close_popup() . "\<CR>"
    endfunction
endif
