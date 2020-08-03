syntax on

set nocompatible
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set encoding=UTF-8
set noshowmode
set updatetime=50
set splitbelow

filetype off

call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
"Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'mbbill/undotree'
Plug 'ap/vim-css-color'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" leader
let mapleader=" "

" gruvbox
colorscheme gruvbox
set background=dark

" lightline
set laststatus=2

" devicons
set guifont=DroidSansMono\ Nerd\ Font\ 11

" ripgrep
if executable('rg')
    let g:rg_derive_root='true'
endif

" ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_use_caching=0

" vim file browser
let g:netrw_banner=0
let g:netrw_browse_split=2
let g:netrw_winsize=25

" indentline
let g:indentLine_char = '⦙'

" gitgutter
set signcolumn=yes

" nerdtree
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeWinPos = "right"

"" close vim if the only window open is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" [start with vim and not vim .] open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"" sync open file with NERDTree
""" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! CheckIfCurrentBufferIsFile()
  return strlen(expand('%')) > 0
endfunction

""" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && CheckIfCurrentBufferIsFile() && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

""" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

function! ToggleTree()
  if CheckIfCurrentBufferIsFile()
    if IsNERDTreeOpen()
      NERDTreeClose
    else
      NERDTreeFind
    endif
  else
    NERDTree
  endif
endfunction

nmap <C-n> :call ToggleTree()<CR>

" nerdcommenter
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" undotree
nmap <leader>u :UndotreeShow<CR>

" general settings
filetype plugin indent on

" file indents
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

