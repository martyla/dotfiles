" fzf
set wildignore+=**/bower_components/**
set wildignore+=**/node_modules/**
set wildignore+=**/build/**
set wildignore+=*.pyc

" If git directory, use `git ls-files` as source, else fallback to vanilla fzf
function! GFilesFallback()
  let prefix = get(g:, 'fzf_command_prefix', '')
  let output = system('git rev-parse --is-inside-work-tree')
  if output =~ 'true'
    call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --cached --others | uniq'}))
    else
    call fzf#run(fzf#wrap())
  endif
  return 0
endfunction

nnoremap <Leader>t :call GFilesFallback()<CR>
nnoremap <C-p> :call GFilesFallback()<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>b :Buffer<CR>

" Enable ripgrep as well on `Rg`
if executable('rg')
  command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

  nnoremap <Space> :Rg<CR>
endif
