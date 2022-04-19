call plug#begin('~/.config/nvim/plugged')
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'honza/vim-snippets'
Plug 'preservim/nerdcommenter'
Plug 'thaerkh/vim-workspace'
Plug 'Shougo/defx.nvim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ahonn/resize.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'rking/ag.vim'
Plug 'lfv89/vim-interestingwords'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'neovim/nvim-lspconfig'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ojroques/nvim-lspfuzzy'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'dense-analysis/ale'
call plug#end()

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
set mouse=a

colorscheme onedark
" let &colorcolumn="80,120"
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
let g:asyncrun_open=20
let g:asynctasks_term_rows = 15
let g:asynctasks_term_cols = 80
let g:asynctasks_term_focus = 0
let g:asynctasks_term_pos = 'bottom'

" Resize windown
let g:resize_size = 10

" LeaderF
let g:Lf_UseMemoryCache = 1
let g:Lf_WindowPosition = 'bottom'
let g:Lf_PreviewInPopup = 1
let g:Lf_WindowHeight = 0.3
let g:Lf_WildIgnore = {
            \ 'dir': ".ccls-cache"
            \ }
let g:Lf_RecurseSubmodules = 1

" highlight cxx
let g:lsp_cxx_hl_use_text_props = 1

" Ag
let g:ag_prg = "rg --vimgrep"

" Fugitive
function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        Git
        20wincmd_
    endif
endfunction
command ToggleGStatus :call ToggleGStatus()
nmap <F9> :ToggleGStatus<CR>

" Quickfix
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nnoremap <silent> <F10> :call ToggleQuickFix()<cr>

" ALE
" let g:ale_disable_lsp = 1
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_on_enter = 0

" AsyncTasks
let g:asynctasks_extra_config = [
    \ '~/.config/tasks/tasks.ini',
    \ ]

lua << EOF
require'lspconfig'.clangd.setup{on_attach}
require'lspconfig'.rust_analyzer.setup{}
require('lspfuzzy').setup {
    save_last = true
    }
EOF

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "go" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indentation = {
      enable = true,
  },
  folding = {
      enable = true,
      },
}
EOF

" LSP Config
nnoremap <silent><leader>s <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent><leader>r <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent><leader>d <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent><leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent><leader>f <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent><leader>b <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" KeyMap
let mapleader=","
nnoremap ; :
nnoremap <leader>ek :vsplit ~/.vim/nhx/keymap.vim<cr>
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
nnoremap <leader>sk :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>gd :Gdiffsplit<cr>
nnoremap <C-p> :LeaderfFile<cr>
nnoremap <leader>sf :NERDTreeFind<cr>
nnoremap <C-J> ]c
nnoremap <C-K> [c
nnoremap <leader>sw :Leaderf rg -w <C-R>=expand("<cword>")<cr><cr>
nnoremap <silent><F5> :CocList tasks<cr>
nnoremap <silent><F3> :Leaderf --recall<cr>

nnoremap <F6> :LeaderfFunction<cr>
nnoremap <F4> :LeaderfMru<cr>
nnoremap <F2> :NERDTreeToggle<cr>
inoremap <C-J> <ESC>
nnoremap <silent> <F12> :TagbarToggle<cr> 
nnoremap <silent> <C-N> :tabnext<cr>

nnoremap <silent> <F8> :call InterestingWords('n')<cr>
vnoremap <silent> <F8> :call InterestingWords('v')<cr>
nnoremap <silent> <backspace> :call UncolorAllWords()<cr>
nnoremap <silent> <A-h> <C-W>h<cr>
nnoremap <silent> <A-l> <C-W>l<cr>
nnoremap <silent> <A-j> <C-W>j<cr>
nnoremap <silent> <A-k> <C-W>k<cr>

if has("nvim")
    nnoremap - :CocCommand clangd.switchSourceHeader<cr>
    nnoremap <A-n> :tabnext<cr>
    nnoremap <A-p> :tabprev<cr>
    nnoremap <A-t> :tabnew<cr>
    nnoremap <A-r> :CocCommand document.showIncomingCalls<cr>
else
    nnoremap - :CocCommand clangd.switchSourceHeader<cr>
    nnoremap <ESC>n :tabnext<cr>
    nnoremap <ESC>p :tabprev<cr>
    nnoremap <ESC>t :tabnew<cr>
    nnoremap <ESC>r :CclsCallHierarchy<cr>
    nnoremap <ESC>c :CclsCalleeHierarchy<cr>
endif

" Coc
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>"
