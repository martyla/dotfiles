filetype off

" Setup NeoBundle settings
let g:neobundle#enable_tail_path = 1
let g:neobundle#install_process_timeout = 480

" Install the bundles after we have installed neo bundle
let s:install_neo_bundles = 0

let s:neobundle_dir = expand('~/.vim/bundle')

" Install NeoBundle - The hard way, without using submodules!
if has('vim_starting')

    " Clone and or Load NeoBundle
    if isdirectory('neobundle.vim')
        set runtimepath^=neobundle.vim
    elseif finddir('neobundle.vim', '.;') != ''
        execute 'set runtimepath^=' . finddir('neobundle.vim', '.;')
    elseif &runtimepath !~ '/neobundle.vim'
        if !isdirectory(s:neobundle_dir.'/neobundle.vim')
            execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
                        \ (exists('$http_proxy') ? 'https' : 'git'))
                        \ s:neobundle_dir.'/neobundle.vim'
            let s:install_neo_bundles = 1
        endif

        execute 'set runtimepath^=' . s:neobundle_dir.'/neobundle.vim'
    endif

endif

call neobundle#begin(s:neobundle_dir)

" Allow NeoBundle to update itself O.o
NeoBundleFetch 'Shougo/neobundle.vim'

" Functionality
NeoBundle 'editorconfig/editorconfig-vim' " Editor agnostic project settings
NeoBundle 'matze/vim-move' " Visually move text around.
NeoBundle 'tpope/vim-git' " Git syntax highlighting
NeoBundle 'tpope/vim-vinegar' " Improves netrw
NeoBundle 'scrooloose/syntastic' " Runs linters over your code
NeoBundle 'solarnz/arcanist.vim' " Arcanist syntax highlighting
NeoBundle 'solarnz/committia.vim' " Show a differential when doing git commit
NeoBundle 'chrisbra/vim-diff-enhanced' " Better differential algorithms

NeoBundle 'junegunn/fzf'
NeoBundle 'junegunn/fzf.vim'

" Themes
NeoBundle 'itchyny/lightline.vim' " The best statusbar plugin.
NeoBundle 'chriskempson/base16-vim' " The base16 color scheme for vim

" Language plugins
NeoBundle 'pangloss/vim-javascript' " Javascript language support
NeoBundle 'othree/html5.vim'
NeoBundle 'fatih/vim-go' " Golang language support
NeoBundle "groenewege/vim-less" " Less language support
NeoBundle "hail2u/vim-css3-syntax" " Css language support
NeoBundle 'hynek/vim-python-pep8-indent' " Better python indentation support
NeoBundle 'solarnz/python.vim' " Python syntax highlighting
NeoBundle 'vim-ruby/vim-ruby'

call neobundle#end()

if has('vim_starting') && s:install_neo_bundles == 1
    NeoBundleInstall
endif

set encoding=utf-8
filetype plugin indent on
syntax on
