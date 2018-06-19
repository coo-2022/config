set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'https://github.com/altercation/vim-colors-solarized.git'
Plugin 'bling/vim-airline'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/Yggdroot/LeaderF.git'
Plugin 'https://github.com/majutsushi/tagbar.git'
call vundle#end()            " required
filetype plugin indent on    " required
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" GUI Configs
if has("gui_running") 
    au GUIEnter * simalt ~x " 窗口启动时自动最大化 
    set guioptions-=m " 隐藏菜单栏 
    set guioptions-=T " 隐藏工具栏 
    set guioptions-=L " 隐藏左侧滚动条 
    set guioptions-=r " 隐藏右侧滚动条 
    set guioptions-=b " 隐藏底部滚动条 
"    set showtabline=0 " 隐藏Tab栏 
endif 

" Configs
set number
set ts=4
set expandtab
set guifont=courier_new:h10
set autoread
set hlsearch
set incsearch
set ignorecase
set showmatch
set scrolloff=3
set background=dark
set helplang=cn
set nowrap
set whichwrap=h,l
set cindent

" Other Config
syntax enable
colorscheme solarized
filetype plugin indent on

" Tagbar Setting
let g:tagbar_left = 1

" Cscope

" mapleader
let mapleader=","
" KEY MAP
nnoremap <space> :
noremap <F2> :NERDTreeToggle<cr>
noremap <F3> :TagbarToggle<cr>
noremap <F4> :LeaderfMru<cr>
noremap <F7> :LeaderfFile<cr>
nmap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <leader>a :cs find a <C-R>=expand("<cword>")<CR><CR>


