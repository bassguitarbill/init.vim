set nocompatible
set showmatch               " show matching
set ignorecase              " case insensitive
set hlsearch                " highlight search
set incsearch               " incremental search

syntax on

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

set backspace=indent,eol,start

set tabstop=8
set softtabstop=4
set shiftwidth=2
set expandtab
set smarttab

set autoindent

set number relativenumber
set nu rnu

set wildmode=longest,list   " get bash-like tab completions
"set cc=80                  " set an 80 column border for good coding style
set ttyfast                 " Speed up scrolling in Vim
set clipboard=unnamedplus   " using system clipboard

let mapleader=" "

nnoremap <leader>h  :nohlsearch<CR>       " disable highlight

nnoremap <leader>cc :source $MYVIMRC<CR>  " source config
nnoremap <leader>ec :edit   $MYVIMRC<CR>  " edit config
nnoremap <leader>sc :split  $MYVIMRC<CR>  " edit config (split)
nnoremap <leader>vc :vsplit $MYVIMRC<CR>  " edit config (v split)

nnoremap <leader>no     :call EditNotes(":edit")<CR>
nnoremap <leader>sno    :call EditNotes(":split")<CR>
nnoremap <leader>vno    :call EditNotes(":vsplit")<CR>

let s:notes_location=$HOME . "/notes"
function EditNotes(command)
  execute a:command . " " . s:notes_location
  setlocal foldmethod=indent
  setlocal foldcolumn=4
  setlocal foldignore=
endfunction

nnoremap <leader>b :ls<CR>:b<Space>

" {{{
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`<v`>l
nnoremap H 0
nnoremap L $
" }}}

" Cruel Mappings ========== {{{
let cruel=0 " someday...
if cruel
  inoremap jk <esc>
  inoremap <esc> <nop>
  inoremap <Up> <nop>
  inoremap <Down> <nop>
  inoremap <Left> <nop>
  inoremap <Right> <nop>
  nnoremap <Up> <nop>
  nnoremap <Down> <nop>
  nnoremap <Left> <nop>
  nnoremap <Right> <nop>
endif
" }}}

" VimScript settings {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevelstart=1
augroup END
" }}}

" JavaScript and TypeScript settings ---------- {{{
augroup filetype_js_ts
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType javascript iabbrev <buffer> iff if ()<Left>
  autocmd FileType javascript iabbrev <buffer> fn function()<Left>
  "autocmd FileType javascript iabbrev <buffer> function NOPEDONTDOIT
  autocmd FileType react iabbrev rct import React from 'react';<CR>import PropTypes from 'prop-types';<CR><CR>export default function
" autocmd BufNewFile *.jsx import React from 'react';<CR>import PropTypes from 'prop-types';<CR><CR>export default function

  autocmd FileType typescript nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType typescript iabbrev <buffer> iff if ()<Left>
  autocmd FileType typescript iabbrev <buffer> fn function()<Left>
augroup END
" }}}

autocmd FileType rust nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType ruby nnoremap <buffer> <localleader>c I#<esc>
autocmd FileType ruby iabbrev fsl #frozen_string_literal: true  " appease rubocop
autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>

augroup filetype_html
  autocmd!
  autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END

" Plugs ------------------- {{{
call plug#begin()
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " Turns Vim into an IDE
  let g:coc_global_extensions = ['coc-tsserver']

  Plug 'tpope/vim-fugitive' " Git integration
  Plug 'tpope/vim-rails'    " Hotkeys for Rails

  Plug 'preservim/nerdtree' " Directory viewer

  Plug 'timonv/vim-cargo'   " Cargo for Rust

  Plug 'vim-airline/vim-airline' " Pretty statusline
  Plug 'bassguitarbill/vim-airline-themes' " Prettier statusline

  Plug 'ctrlpvim/ctrlp.vim' " Fuzzy finder

  Plug 'edkolev/tmuxline.vim' " Style tmux to look like airline
call plug#end()
" }}}

" Coc Customization ------------ {{{
highlight FgCocErrorFloatBgCocFloating guifg=#800000
highlight FgCocErrorFloatBgCocFloating ctermfg=88 " DarkRed
highlight FgCocHintFloatBgCocFloating guifg=#000000
highlight FgCocHintFloatBgCocFloating ctermfg=18 " DarkBlue

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
" }}}

" Theming ========== {{{
let g:airline_theme='luna'
" }}}

