call plug#begin('~/.vim/plugged')
Plug 'Yggdroot/LeaderF'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'honza/vim-snippets'
Plug 'preservim/nerdcommenter'
Plug 'thaerkh/vim-workspace'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ahonn/resize.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'rking/ag.vim'
Plug 'sheerun/vim-polyglot'
Plug 'm-pilia/vim-ccls'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
call plug#end()

" GUI Setting
if has("gui_running")
	au GUIEnter * simalt ~x
	set guioptions-=m
	set guioptions-=T
	set guioptions-=L
	set guioptions-=r
	set guioptions-=b
	set showtabline=0
endif

so ~/.vim/nhx/cocconfig.vim
"so ~/.vim/nhx/defxconfig.vim

" Configs
set nowrap
set linebreak
set background=dark
set guifont=Courier_new:h10:b:cDEFAULT
set number
set cursorline
set tabstop=4
set shiftwidth=4
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set hlsearch
set incsearch
set ignorecase
set helplang=cn
set fileformat=unix
set foldenable
set foldmethod=marker
set mouse=v
set scrolloff=3
set termguicolors
set expandtab
set smartindent
set completeopt=longest,menuone
set ruler
set whichwrap=h,l
set backspace=2
set encoding=utf-8
"set fileencodings=utf-8
"set rnu

" Other Configs
colorscheme molokai
"let g:rehash256 = 1
"let g:molokai_original = 1
let &colorcolumn="80,120"
syntax on
filetype plugin indent on

" Leader setting
let mapleader=","

" Plugin Setting


" NERDTree
let g:NERDTreeWinPos="left"
let g:NERDTreeWinSize=50
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

" AsyncRun
let g:asyncrun_open=6
let g:asynctasks_term_rows = 15
let g:asynctasks_term_cols = 80
let g:asynctasks_term_pos = 'bottom'

" Resize windown
let g:resize_size = 10

" LeaderF
let g:Lf_UseMemoryCache = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_WildIgnore = {
            \ 'dir': ".ccls-cache"
            \ }

" Ag 
let g:ag_prg = "rg --vimgrep"

" Keymap
nnoremap <F2> :NERDTreeToggle<cr>
nnoremap <F3> :LeaderfSelf<cr>

noremap ; :
nnoremap ,ek :e ~/.vim/nhx/keymap.vim<cr>
nnoremap ,ev :e ~/.vimrc<cr>
nnoremap ,sv :source ~/.vimrc<cr>
nnoremap ,sw :Ag <cword><cr>
