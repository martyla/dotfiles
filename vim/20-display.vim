set background=dark

try
    set t_Co=256                      " Make vim aware of 256 colorspace
    let base16colorspace=256          " Enable base16 256 colorspace
    colorscheme base16-monokai
catch
    " If it fails then ignore it
endtry

" Update the title automatically to reflect file name
set title

" Automatically refresh unchanged files
set autoread
au CursorHold * checktime
au FocusGained,BufEnter * :checktime " autoread when changing buffers

set autoindent

" Use system clipboard
set clipboard=unnamed

set showmatch
set matchpairs=(:),{:},[:],<:>

"Show line numbers
set number
set relativenumber

"Extra highlighting settings
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
highlight ExtraWhiteSpace ctermbg=52
set nospell
set hlsearch

" Always show the status bar at the bottom of the window
set laststatus=2
set incsearch

set list lcs=trail:·,tab:»·

" 80 & 100 col display (vim 7.3+)
if exists('+colorcolumn')
  set colorcolumn=80,100
endif

let &t_SI = "\e]50;CursorShape=1\x7"
let &t_EI = "\e]50;CursorShape=0\x7"

" Already showing the mode in powerline
set noshowmode
" Extra space for echodoc / language bar
set cmdheight=2
set updatetime=300 " better ux
set shortmess+=c " Supress omni complete messages
