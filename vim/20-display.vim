set background=dark

try
    set t_Co=256                      " Make vim aware of 256 colorspace
    let base16colorspace=256          " Enable base16 256 colorspace
    colorscheme base16-default
catch /^Vim\%((\a\+)\)\=:E185/
    " Well, not much I can do at the moment
endtry

set autoindent

set showmatch
set matchpairs=(:),{:},[:],<:>

"Show line numbers
set number
set relativenumber

"Extra highlighting settings
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
highlight ExtraWhiteSpace ctermbg=52
set spell spelllang=en_gb
set hlsearch

" Always show the status bar at the bottom of the window
set laststatus=2
set incsearch

set list lcs=trail:·,tab:»·

let &t_SI = "\e]50;CursorShape=1\x7"
let &t_EI = "\e]50;CursorShape=0\x7"