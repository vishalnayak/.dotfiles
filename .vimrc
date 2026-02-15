" --- High-Vibrancy Go Config ---
set nocompatible
filetype plugin indent on
syntax on

" Ensure 24-bit color
set termguicolors
set background=dark

" High-Contrast Go Overrides
highlight GoFunction guifg=#7aa2f7 gui=bold
highlight GoMethod guifg=#bb9af7 gui=italic
highlight GoStruct guifg=#ff9e64 gui=bold
highlight GoInterface guifg=#7dcfff gui=italic

" Muscle Memory & UI
inoremap jk <Esc>
vnoremap jk <Esc>
cnoremap jk <C-c>

set number
set relativenumber
set cursorline
set expandtab
set shiftwidth=4
set tabstop=4

let mapleader = " "
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
