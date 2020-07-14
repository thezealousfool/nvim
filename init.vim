set history=500
filetype plugin on
filetype indent on
set number
set relativenumber
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw " Don't redraw while executing macros
set showmatch " Show matching brackets
set noerrorbells
set novisualbell
set expandtab " Use spaces instead of tabs
set smarttab
set shiftwidth=2
set tabstop=2
set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines
let mapleader = " "

" Lets you undo on files even after closing and reopenning
set undodir=~/.local/.vimdid
set undofile

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" center search results
nnoremap <silent> n  nzz
nnoremap <silent> N  Nzz
nnoremap <silent> *  *zz
nnoremap <silent> #  #zz
nnoremap <silent> g* g*zz

nmap <leader>w :w<cr>
nmap <leader>q :q<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bc :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bc<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>
map <leader>tl :tabnext<cr>
map <leader>th :tabprevious<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <leader><leader> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

command! W execute 'w !sudo tee % > /dev/null' <bar> edit! " :W sudo saves the file


call plug#begin('~/.local/share/nvim/plugged')

Plug 'machakann/vim-highlightedyank' " Highlight what has been yanked

Plug 'airblade/vim-rooter' " Auto change dir to the root of the project
let g:rooter_patterns = ['.git/', 'Cargo.toml', 'package.json']

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Fuzzy file finder

Plug 'tmhedberg/SimpylFold' " Text folding
Plug 'Konfekt/FastFold'

Plug 'ntpeters/vim-better-whitespace' " Highlight trailing whitespace

Plug 'tpope/vim-fugitive' " Git client

Plug 'tpope/vim-eunuch' " UNIX shell commands inside vim

Plug 'cakebaker/scss-syntax.vim'

Plug 'mattn/emmet-vim'

Plug 'dense-analysis/ale' " Asynchronous lint engine

Plug 'ncm2/ncm2' " Autocomplete
Plug 'roxma/nvim-yarp' " Required by ncm2
Plug 'ncm2/ncm2-bufword' " Completion for words in current buffer
Plug 'ncm2/ncm2-path' " Path Completion
Plug 'ncm2/ncm2-jedi' " Python autocomplete

Plug 'rust-lang/rust.vim' " Rust

call plug#end()

" fzf
map <leader>f :Files<cr>

" fugitive
map <leader>gs :Gstatus<cr>
map <leader>gpl :Gpull<cr>
map <leader>gps :Gpush<cr>
map <leader>gd :Gdiff<cr>
map <leader>ga. :Git add .<cr>

" nunjucks
au BufNewFile,BufRead *.njk set ft=jinja

" Escape works as should in terminal mode
tnoremap <Esc> <C-\><C-n>

" ALE
let g:ale_fixers = {
  \'rust': ['rustfmt'],
  \'javascript': ['eslint'],
  \'python': ['yapf'],
  \}
let g:ale_linters = {
  \'rust': ['rls'],
  \'javascript': ['eslint'],
  \'python': ['pylint'],
  \}
let g:ale_fix_on_save = 1

" Completion
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" tab to select
" don't hijack enter key
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

" Ripgrep (install https://github.com/BurntSushi/ripgrep#installation)
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" LSP settings (mostly from nvim help)
nnoremap <silent> gd        <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gD        <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-space> <cmd>lua vim.lsp.buf.signature_help()<CR>
