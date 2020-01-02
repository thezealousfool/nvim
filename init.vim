set history=500
filetype plugin on
filetype indent on
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

nmap <leader>w :w<cr>

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
map <leader>t<leader> :tabnext

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

command! W execute 'w !sudo tee % > /dev/null' <bar> edit! " :W sudo saves the file 


call plug#begin('~/.local/share/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

Plug 'zchee/deoplete-jedi'
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'preservim/nerdcommenter'

Plug 'sbdchd/neoformat'
let g:neoformat_basic_format_align = 1 " Enable alignment
let g:neoformat_basic_format_retab = 1 " Enable tab to spaces conversion
let g:neoformat_basic_format_trim = 1 " Enable trimmming of trailing whitespace

Plug 'davidhalter/jedi-vim'
let g:jedi#completions_enabled = 0 " disable autocompletion, cause we use deoplete for completion
let g:jedi#use_splits_not_buffers = "right" " open the go-to function in split, not another buffer

Plug 'neomake/neomake'
let g:neomake_python_enabled_makers = ['pylint']
call neomake#configure#automake('nrwi', 500)

Plug 'tmhedberg/SimpylFold'

Plug 'ntpeters/vim-better-whitespace'

call plug#end()
