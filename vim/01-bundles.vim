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
            execute printf('!git clone %s://github.com/Shougo/dein.vim.git',
                        \ (exists('$http_proxy') ? 'https' : 'git'))
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
call dein#add('Shougo/vimproc.vim', {'build': 'make'}) " Async execution library
call dein#add('Shougo/echodoc.vim') " Display echodoc text (function signatures)
call dein#add('editorconfig/editorconfig-vim') " Editor agnostic project settings
call dein#add('matze/vim-move') " Visually move text around.
call dein#add('scrooloose/syntastic') " Runs linters over your code
call dein#add('rhysd/committia.vim') " Show a differential when doing git commit
call dein#add('chrisbra/vim-diff-enhanced') " Better differential algorithms
call dein#add('scrooloose/nerdcommenter') " Easier commenting
call dein#add('tpope/vim-fugitive') " git wrapper
call dein#add('tpope/vim-vinegar') " Improved netrw view
call dein#add('tpope/vim-surround') " git wrapper
call dein#add('tpope/vim-repeat') " Allow repeating of plugin commands

" Fuzzy finder
call dein#add('junegunn/fzf', {'merged': 0})
call dein#add('junegunn/fzf.vim', {'depends': 'fzf'})

" Language/syntax support
call dein#add('pangloss/vim-javascript') " Javascript language support
call dein#add('mxw/vim-jsx') " Facebook jsx support
call dein#add('othree/html5.vim')
call dein#add('fatih/vim-go') " Golang language support
call dein#add('groenewege/vim-less') " Less language support
call dein#add('hail2u/vim-css3-syntax') " Css language support
call dein#add('hynek/vim-python-pep8-indent') " Better python indentation support
call dein#add('solarnz/python.vim') " Python syntax highlighting
call dein#add('vim-ruby/vim-ruby')
call dein#add('tpope/vim-git') " Git syntax highlighting
call dein#add('leafgarland/typescript-vim') " TypeScript syntax highlighting and compilation
call dein#add('Quramy/tsuquyomi') " Client for TypeScript TSServer
call dein#add('nikvdp/ejs-syntax') " EJS html templates highlighting
call dein#add('prettier/vim-prettier', {'build': 'yarn install'}) " Javascript code formatting

" Autocomplete
call dein#add('Shougo/deoplete.nvim') " Async autocomplete
call dein#add('carlitux/deoplete-ternjs', {'build': 'yarn global add tern'}) " JS autocomplete
call dein#add('mhartington/nvim-typescript')
call dein#add('zchee/deoplete-go', {'build': 'make'})

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
