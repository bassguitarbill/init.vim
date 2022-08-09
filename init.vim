set nocompatible

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

let mapleader=" "

nnoremap <leader>h  :nohlsearch<CR>       " disable highlight

nnoremap <leader>cc :source $MYVIMRC<CR>  " source config
nnoremap <leader>ec :edit   $MYVIMRC<CR>  " edit config
nnoremap <leader>sc :split  $MYVIMRC<CR>  " edit config (split)
nnoremap <leader>vc :vsplit $MYVIMRC<CR>  " edit config (v split)

nnoremap <leader>no :edit ~/notes<CR>:call FoldNotes()<CR>
nnoremap <leader>sno :split ~/notes<CR>:call FoldNotes()<CR>
nnoremap <leader>vno :vsplit ~/notes<CR>:call FoldNotes()<CR>

" {{{
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`<v`> 
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
autocmd FileType ruby niabbrev fsl #frozen_string_literal: true  " appease rubocop
autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>

augroup filetype_html
  autocmd!
  autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END

function FoldNotes()
  setlocal foldmethod=indent
  setlocal foldcolumn=4
  setlocal foldignore=
endfunction

" Plugs ------------------- {{{
call plug#begin()
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = ['coc-tsserver']

  Plug 'preservim/nerdtree'

  Plug 'tpope/vim-fugitive'

  Plug 'timonv/vim-cargo'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
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
let g:airline_theme='sol'
" }}}

