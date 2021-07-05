let mapleader=","
nnoremap ; :
nnoremap <leader>ek :vsplit ~/.vim/nhx/keymap.vim<cr>
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sk :source ~/.vimrc<cr>
nnoremap <leader>r  :AsyncTask run-llt<cr>
nnoremap <leader>b  :AsyncTask build-llt<cr>
nnoremap <leader>gd :Gdiffsplit<cr>
nnoremap <F7> :LeaderfFile<cr>
nnoremap <leader>sf :NERDTreeFind<cr>
nnoremap <F9> :Gstatus<cr>:10wincmd-<cr>
nnoremap <C-J> ]c
nnoremap <C-K> [c
nnoremap <leader>sw :Leaderf rg -w <C-R>=expand("<cword>")<cr><cr>
nnoremap <F3> :Leaderf --recall<cr>

nnoremap <backspace> :nohl<cr>
nnoremap <F6> :LeaderfFunction<cr>
nnoremap <F4> :LeaderfMru<cr>
nnoremap <F2> :NERDTreeToggle<cr>
inoremap <C-J> <ESC>
nnoremap <F8> *<S-N>
nnoremap <silent> <F12> :TagbarToggle<cr> 

if has("nvim")
    nnoremap - :CocCommand clangd.switchSourceHeader<cr>
    nnoremap <A-n> :tabnext<cr>
    nnoremap <A-p> :tabprev<cr>
    nnoremap <A-t> :tabnew<cr>
    nnoremap <A-r> :CclsCallHierarchy<cr>
    nnoremap <A-c> :CclsCalleeHierarchy<cr>
else
    nnoremap - :CocCommand clangd.switchSourceHeader<cr>
    nnoremap <ESC>n :tabnext<cr>
    nnoremap <ESC>p :tabprev<cr>
    nnoremap <ESC>t :tabnew<cr>
    nnoremap <ESC>r :CclsCallHierarchy<cr>
    nnoremap <ESC>c :CclsCalleeHierarchy<cr>
endif
