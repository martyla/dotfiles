" fzf
set wildignore+=**/bower_components/**
set wildignore+=**/node_modules/**
set wildignore+=**/build/**
set wildignore+=*.pyc

function! GFilesFallback()
  let prefix = get(g:, 'fzf_command_prefix', '')
  let output = system('git rev-parse --is-inside-work-tree')
  if output =~ 'true'
    exec "normal :" . prefix . "GFiles --exclude-standard --cached --others\<CR>"
  else
    exec "normal :" . prefix . "Files\<CR>"
  endif
  return 0
endfunction

nnoremap <Leader>t :call GFilesFallback()<CR>
nnoremap <C-p> :call GFilesFallback()<CR>
nnoremap <Leader>j :History<CR>
nnoremap <Leader>b :Buffer<CR>
