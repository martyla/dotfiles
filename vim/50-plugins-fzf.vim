" fzf
nnoremap <Leader>t :Files<CR>
nnoremap <Leader>g :GitFiles<CR>

" Bind ag if available
if executable('ag')
  nnoremap <Leader>f :Ag<CR>
endif
