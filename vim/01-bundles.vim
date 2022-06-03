filetype off

if &compatible
    set nocompatible
endif

" Install the bundles after we have installed dein
let s:install_plugins = 0

let s:plugin_dir = expand('~/.vim/bundle')

" Install dein.vim
if has('vim_starting')
    " Clone and or Load dein.vim
    if isdirectory('bundle/repos/github.com/Shougo/dein.vim')
        set runtimepath^=bundle/repos/github.com/Shougo/dein.vim
    elseif finddir('dein.vim', '.;') != ''
        execute 'set runtimepath^=' . finddir('dein.vim', '.;')
    elseif &runtimepath !~ '/dein.vim'
        if !isdirectory(s:plugin_dir.'/repos/github.com/Shougo/dein.vim')
            execute printf('!git clone https://github.com/Shougo/dein.vim.git')
                        \ s:plugin_dir.'/repos/github.com/Shougo/dein.vim'
            let s:install_plugins = 1
        endif
        execute 'set runtimepath^=' . s:plugin_dir.'/repos/github.com/Shougo/dein.vim'
    endif
endif

call dein#begin(s:plugin_dir)

" Allow dein to update itself
call dein#add('Shougo/dein.vim')

" Functionality
call dein#add('Shougo/echodoc.vim') " Display echodoc text (function signatures)
call dein#add('editorconfig/editorconfig-vim') " Editor agnostic project settings
call dein#add('matze/vim-move') " Visually move text around.
call dein#add('mbbill/undotree') " Undo tree visualization
call dein#add('vim-syntastic/syntastic') " Runs linters over your code
call dein#add('rhysd/committia.vim') " Show a differential when doing git commit
call dein#add('scrooloose/nerdcommenter') " Easier commenting
call dein#add('tpope/vim-fugitive') " git wrapper
call dein#add('tpope/vim-vinegar') " Improved netrw view
call dein#add('tpope/vim-surround') " manipulate surrounding symbols
call dein#add('tpope/vim-repeat') " Allow repeating of plugin commands
call dein#add('airblade/vim-gitgutter') " Git changes in gutter
call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})

" Fuzzy finder
call dein#add('junegunn/fzf', {'merged': 0})
call dein#add('junegunn/fzf.vim', {'depends': 'fzf'})

" Language/syntax support
call dein#add('pangloss/vim-javascript') " Javascript language support
call dein#add('mxw/vim-jsx') " Facebook jsx support
call dein#add('othree/html5.vim')
call dein#add('fatih/vim-go') " Golang language support
call dein#add('hail2u/vim-css3-syntax') " Css language support
call dein#add('solarnz/python.vim') " Python syntax highlighting
call dein#add('hashivim/vim-terraform') " Terraform tools and hilighting
call dein#add('HerringtonDarkholme/yats.vim') " TypeScript syntax highlighting
call dein#add('nikvdp/ejs-syntax') " EJS html templates highlighting
call dein#add('rust-lang/rust.vim') " Rust support

" Themes
call dein#add('itchyny/lightline.vim') " The best statusbar plugin.
call dein#add('chriskempson/base16-vim') " The base16 color scheme for vim

call dein#end()

if has('vim_starting') && s:install_plugins == 1
    call dein#install()
endif

set encoding=utf-8
filetype plugin indent on
syntax on
