" === General Settings ===
set nocompatible            " Disable vi compatibility
filetype plugin indent on   " Enable filetype detection
syntax enable              " Enable syntax highlighting
set number                 " Show line numbers
set relativenumber         " Relative line numbers
set tabstop=4              " Tab = 4 spaces
set shiftwidth=4           " Indent = 4 spaces
set expandtab              " Convert tabs to spaces
set autoindent             " Auto-indent new lines
set smartindent            " Context-aware indentation
set cursorline             " Highlight current line
set showmatch              " Highlight matching brackets
set incsearch              " Search as you type
set hlsearch               " Highlight search results
set clipboard=unnamed      " System clipboard integration (requires +clipboard)
colorscheme retrobox       " theme 

" === Smart Bracing (C/C++/Python) ===
autocmd FileType c,cpp,python inoremap {<CR> {<CR>}<Esc>O
autocmd FileType c,cpp setlocal cindent

" === Language-Specific ===
" C/C++: Newline-after-brace with proper indentation
autocmd FileType c,cpp setlocal cindent
autocmd FileType c,cpp setlocal cinoptions=':0,l1,t0,(0,W4'  " Align braces on new line
" Auto-close and indent:
autocmd FileType c,cpp inoremap {<CR> {<CR>}<Esc>O 

" Python Settings
autocmd FileType python setlocal foldmethod=indent    " Fold by indentation
autocmd FileType python setlocal textwidth=79         " PEP-8 line length

" === Key Bindings ===
nnoremap <F5> :w<CR>:!g++ % -o %< && ./%<<CR>        " Compile & run C/C++
nnoremap <F6> :w<CR>:!python3 %<CR>                  " Run Python
nnoremap <leader>c :nohlsearch<CR>                   " Clear search highlights

" === Plugins (Vim-Plug) ===
call plug#begin('~/.vim/plugged')
  " Syntax & Autocomplete
  Plug 'dense-analysis/ale'                           " Async linting (flake8, clangd)

  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'                       " Auto-install LSP servers

  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  
  " Language Support
  Plug 'vim-python/python-syntax'                     " Enhanced Python syntax
  Plug 'octol/vim-cpp-enhanced-highlight'             " Better C++ highlighting
  
  " Utilities
  Plug 'preservim/nerdtree'                           " File explorer
  Plug 'tpope/vim-commentary'                         " Toggle comments (gc)
call plug#end()

" === LSP Configuration ===
" Enable LSP for C/C++ and Python
let g:lsp_settings = {
  \ 'clangd': {'cmd': ['clangd']},
  \ 'pylsp': {'cmd': ['pyright-langserver', '--stdio']}
\ }

" Auto-start LSP when opening a file
augroup LSP
  autocmd!
  autocmd FileType c,cpp,python if (executable('clangd') || executable('pyright-langserver')) | call lsp#enable() | endif
augroup END

" Key mappings for LSP
nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gr :LspReferences<CR>
nnoremap <silent> <F2> :LspRename<CR>
nnoremap <silent> [e :LspPreviousDiagnostic<CR>
nnoremap <silent> ]e :LspNextDiagnostic<CR>

" ALE (Linting)
let g:ale_linters = {'python': ['flake8'], 'cpp': ['clangtidy']}

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>                   " Toggle file tree
