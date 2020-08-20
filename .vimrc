" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" nerdtree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" ranger
Plug 'francoiscabrol/ranger.vim'

" coding
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ap/vim-css-color'
Plug 'vim-utils/vim-man'

" js/ts/react
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'

" golang
Plug 'fatih/vim-go'

" vim
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'ryanoasis/vim-devicons' " -- has to be last

call plug#end()

" -----------------------------------------------------------------------------
" Color settings
" -----------------------------------------------------------------------------

" Enable 24-bit true colors if your terminal supports it
if (has("termguicolors"))
  " https://github.com/vim/vim/issues/993#issuecomment-255651605
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  set termguicolors
endif

" Enable syntax highlighting
syntax on

set guifont=DroidSansMono\ Nerd\ Font\ 11

" Enable gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = '0'

colorscheme gruvbox
set background=dark

" -----------------------------------------------------------------------------
" Basic Settings
"   Research any of these by running :help <setting>
" -----------------------------------------------------------------------------

let mapleader = "\<Space>"
let maplocalleader="\<Space>"

set nocompatible
set noerrorbells visualbell t_vb=
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set number
set nowrap
set noswapfile
set undodir=~/.vim/undodir
set undofile
set undolevels=1000         " use many levels of undo
set history=1000            " remember more commands and search history
set hlsearch                " highlight search terms
set ignorecase              " ignore case when searching
set incsearch               " show search matches as you type
set noshowmode
set updatetime=50
set signcolumn=yes
set splitbelow
set splitright
set autoread
set encoding=utf-8
set laststatus=2
set ruler                   " display column in status bar
set foldmethod=indent
set hidden                  " allows to hide current buffer if there are unsaved changes
set cmdheight=2             " more space for displaying messages
set title                   " change terminal title
set wildignore=*.swp,*.bak,*.pyc,*.class

set ttyfast
set mouse=a
set ttymouse=sgr

filetype plugin indent on

" -----------------------------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------------------------

" navigate around splits with a single key combo
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" cycle through splits
nnoremap <S-Tab> <C-w>w

" coc
nnoremap <silent> K :call CocAction('doHover')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)

" nerdtree
nmap <leader>n :call ToggleTree()<CR>

" ranger
let g:ranger_map_keys = 0
map <leader>d :Ranger<CR>

" fzf
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <leader>f :RG<CR>

" nerdcommenter
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" undotree
nmap <leader>u :UndotreeShow<CR>

" edit / source .vimrc
map <leader>ev :tabnew $MYVIMRC<CR>
map <leader>sv :source $MYVIMRC<CR>

" clear search highlights
map <leader><Space> :nohlsearch<CR>

" keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

" save as sudo [if you forget to open file as sudo]
cmap w!! w !sudo tee % >/dev/null

" -----------------------------------------------------------------------------
" Basic autocommands
" -----------------------------------------------------------------------------

if has("autocmd")

  " Change cursor shape
  augroup CursorShape
    au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
    au InsertEnter,InsertChange *
      \ if v:insertmode == 'i' | 
      \   silent execute '!echo -ne "\e[5 q"' | redraw! |
      \ elseif v:insertmode == 'r' |
      \   silent execute '!echo -ne "\e[3 q"' | redraw! |
      \ endif
    au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
  augroup END

  " Only show the cursor line in the active buffer.
  augroup CursorLine
      au!
      au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
      au WinLeave * setlocal nocursorline
  augroup END

  " Auto-resize splits when Vim gets resized.
  au VimResized * wincmd =

  " Update a buffer's contents on focus if it changed outside of Vim.
  au FocusGained,BufEnter * :checktime

  " Unset paste on InsertLeave.
  au InsertLeave * silent! set nopaste

  " Make sure all types of requirements.txt files get syntax highlighting.
  au BufNewFile,BufRead requirements*.txt set syntax=python

  " Ensure tabs don't get converted to spaces in Makefiles.
  au FileType make setlocal noexpandtab

  " Keep all folds open when a file is opened
  augroup OpenAllFoldsOnFileOpen
      au!
      au BufRead * normal zR
  augroup END

  au FileType yml setlocal ts=2 sts=2 sw=2 expandtab
  au FileType json syntax match Comment +\/\/.\+$+
  au BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  au BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

endif

" -----------------------------------------------------------------------------
" Plugin settings, mappings and autocommands
" -----------------------------------------------------------------------------

"#################################################################### fzf
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

"#################################################################### ripgrep
if executable('rg')
    let g:rg_derive_root='true'
    set grepprg=rg\ --vimgrep\ --smart-case\ --follow
endif

"#################################################################### vim file browser
let g:netrw_banner=0
let g:netrw_browse_split=2
let g:netrw_winsize=25

"#################################################################### indentline
let g:indentLine_char = '⦙'
let g:indentLine_setConceal = 1

"#################################################################### nerdtree
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeWinPos = "right"
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeShowHidden = 1

"" close vim if the only window open is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" [start with vim and not vim .] open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1

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


"#################################################################### coc
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

"" automatically display documentation 
"function! ShowDocIfNoDiagnostic(timer_id)
  "if (coc#util#has_float() == 0)
    "silent call CocActionAsync('doHover')
  "endif
"endfunction

"function! s:show_hover_doc()
  "call timer_start(500, 'ShowDocIfNoDiagnostic')
"endfunction

"autocmd CursorHoldI * :call <SID>show_hover_doc()
"autocmd CursorHold * :call <SID>show_hover_doc()
"" automatically display documentation

"#################################################################### vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

"#################################################################### vim-markdown

if has("autocmd")
  autocmd FileType markdown let b:sleuth_automatic=0
  autocmd FileType markdown set conceallevel=0
  autocmd FileType markdown normal zR
endif

let g:vim_markdown_frontmatter=1

"#################################################################### markdown-preview
let g:mkdp_auto_close=0
let g:mkdp_refresh_slow=1
" copied css from https://github.com/sindresorhus/github-markdown-css/blob/gh-pages/github-markdown.css
let g:mkdp_markdown_css='/home/asiri/.local/lib/github-markdown-css/github-markdown.css'

"#################################################################### vim-go
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"    " Run goimports along gofmt on each save     
let g:go_auto_type_info = 1           " Automatically get signature/type info for object under cursor     

if has("autocmd")
  au filetype go inoremap <buffer> . .<C-x><C-o>
endif
