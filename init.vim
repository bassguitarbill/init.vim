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

" disable highlight
nnoremap <leader>h  :nohlsearch<CR>
" display a list of open buffers
nnoremap <leader>b :ls<CR>:b<Space>
nnoremap H 0    "   warp to the beginning of the line
nnoremap L $    "   warp to the end of the line

" === === Vim Config commands === === {{{
nnoremap <leader>cc :source $MYVIMRC<CR>  " source config
nnoremap <leader>ec :edit   $MYVIMRC<CR>  " edit config
nnoremap <leader>sc :split  $MYVIMRC<CR>  " edit config (split)
nnoremap <leader>vc :vsplit $MYVIMRC<CR>  " edit config (v split)
" }}}

" === === Edit Notes commands === === {{{
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
" }}}

" === === Quote selected words === === {{{
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`<v`>l
" }}}

" https://github.com/neovim/neovim/issues/20029#issuecomment-1233530819
vnoremap <leader>rcd <esc>`<O# rubocop:disable xyzzy<esc>`>o# rubocop:enable xyzzy<esc>V`<k<Cmd>let &undolevels = &undolevels<CR>:s/xyzzy/

" === === Cruel Mappings === === {{{
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

" === === VimScript settings === === {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevelstart=1
  autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>
augroup END
" }}}

" === === JavaScript and TypeScript settings === === {{{
augroup filetype_js_ts
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType javascript iabbrev <buffer> iff if ()<Left>
  autocmd FileType javascript iabbrev <buffer> fn function()<Left>
  "autocmd FileType javascript iabbrev <buffer> function NOPEDONTDOIT
  autocmd FileType javascriptreact iabbrev rct import React from 'react';<CR>import PropTypes from 'prop-types';<CR><CR>export default function
" autocmd BufNewFile *.jsx import React from 'react';<CR>import PropTypes from 'prop-types';<CR><CR>export default function

  autocmd FileType typescript nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType typescript iabbrev <buffer> iff if ()<Left>
  autocmd FileType typescript iabbrev <buffer> fn function()<Left>
augroup END
" }}}

" === === Rust settings === === {{{
augroup filetype_rust
  autocmd!
  autocmd FileType rust nnoremap <buffer> <localleader>c I//<esc>
augroup END
" }}}

" === === Ruby settings === === {{{
augroup filetype_ruby
  autocmd!
  autocmd FileType ruby nnoremap <buffer> <localleader>c I#<esc>
  autocmd FileType ruby iabbrev fsl # frozen_string_literal: true
  autocmd FileType ruby nnoremap <buffer> <leader>rsp :call RunRSpec()<CR>
augroup END
function RunRSpec()
  compiler rspec
  make
  copen
endfunction
" }}}

" === === HTML settings === === {{{
augroup filetype_html
  autocmd!
  autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END
" }}}

" === === Plugs === === {{{
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
  Plug 'edkolev/promptline.vim' " Style zsh to look like airline

  Plug 'powerline/powerline-fonts'
  let g:tmuxline_powerline_separators = 1

  Plug 'ngmy/vim-rubocop'
  if stridx(getcwd(), "nitro-web") >= 0
    let g:vimrubocop_rubocop_cmd='bin/rubocop '
  endif

  Plug 'vimwiki/vimwiki'
call plug#end()
" }}}

" === === Vimwiki Customization === ==={{{
function! VimwikiLinkHandler(link)
  " TODO check if the file is local before trying to open it
  execute 'edit ' . a:link
  nnoremap <buffer> <BS> :e #<CR>
  return 1
endfunction

let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.nested_syntaxes = {'ruby': 'ruby'}
let g:vimwiki_list = [wiki]
"}}}

" === === Coc Customization === === {{{
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

" === === Theming === === {{{
let g:airline_theme='luna'
" }}}

