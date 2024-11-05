let mapleader=" "

set autoindent
set smartindent
set smarttab
set expandtab
set shiftround
set nojoinspaces
set nofoldenable
set tabstop=4
set softtabstop=4
set shiftwidth=4
set ruler
set scrolloff=10

" Allow changing buffers without saving
set hidden

" Set key shortcuts
set bs=2

nnoremap <Leader>q :q <CR>
nnoremap <Leader>Q :wq<CR>

" Tabs
" nnoremap <Leader><Left> :tabprev <CR>
" nnoremap <Leader>h :tabprev <CR>
" nnoremap <Leader>l :tabnext <CR>
" nnoremap <Leader><Right> :tabnext <CR>
" nnoremap <Leader>n :tabnew <CR>

" Switch to alternate file
nnoremap <Tab> <C-^><CR>

" Easier window movement keys
nnoremap tn :split <CR>
nnoremap tv :vsplit <CR>

nnoremap th :wincmd h <CR>
nnoremap tj :wincmd j <CR>
nnoremap tk :wincmd k <CR>
nnoremap tl :wincmd l <CR>

" Disable the arrow keys
noremap    <Up>     <NOP>
noremap    <Down>   <NOP>
noremap    <Left>   <NOP>
noremap    <Right>  <NOP>
inoremap   <Up>     <NOP>
inoremap   <Down>   <NOP>
inoremap   <Left>   <NOP>
inoremap   <Right>  <NOP>
vnoremap   <Up>     <NOP>
vnoremap   <Down>   <NOP>
vnoremap   <Left>   <NOP>
vnoremap   <Right>  <NOP>

" Easy shortcut to switch back to normal mode
inoremap hh <esc>

noremap      <F1>    <ESC>
inoremap     <F1>    <ESC>
vnoremap     <F1>    <ESC>
nnoremap     <F1>    <ESC>

" Clear highlight
noremap <Leader>m :noh <CR>

" Fix netrw local rebinding of keys (`tn`)
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call FixNetrw()
augroup end

function! FixNetrw()
    noremap <buffer> tn :split<CR>
endfunction

" Disable mouse for neovmim
if has('nvim')
    set mouse=""
endif
