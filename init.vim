set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set ignorecase              " case insensitive
set mouse=v                 " middle-click paste with
set hlsearch                " highlight search
set incsearch               " incremental search

set tabstop=8
set softtabstop=4
set shiftwidth=2
set expandtab
set smarttab

set autoindent
" set foldmethod=indent

set number relativenumber
set nu rnu

set wildmode=longest,list   " get bash-like tab completions
"set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
"set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

function FoldNotes()
  set foldmethod=indent
  set foldcolumn=4
  set foldignore=
endfunction

call plug#begin()
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'edkolev/tmuxline.vim'
call plug#end()

let g:airline_theme='sol'

