" ========================================================================== "
"                                 .VIMRC                                     "
" ========================================================================== "

" --- General Settings ---
set nocompatible            " Disable legacy vi compatibility
filetype plugin indent on   " Enable filetype detection and plugins
syntax on                   " Enable syntax highlighting
set hidden                  " Switch buffers without saving

" --- UI & Display ---
set number                  " Show line numbers
set relativenumber          " Relative line numbers for easier jumping
set cursorline              " Highlight the current line
set showmatch               " Highlight matching brackets
set termguicolors           " Better color support for modern terminals
set scrolloff=8             " Keep context visible when scrolling
set sidescrolloff=8

" --- The 'jk' Escape Mapping ---
" Essential for muscle memory: exit insert mode with 'jk'
inoremap jk <Esc>
vnoremap jk <Esc>
" Exit command mode with 'jk'
cnoremap jk <C-c>

" --- Clipboard Logic (Fixed for Neovim) ---
" Removed 'autoselect' to prevent E474 error in Neovim
set clipboard=unnamedplus,unnamed

" --- Editor Behavior & Indentation ---
set expandtab               " Use spaces instead of tabs
set shiftwidth=4            " 1 tab = 4 spaces
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set wrap                    " Soft wrap lines

" --- Search ---
set ignorecase              " Ignore case in search...
set smartcase               " ...unless there is a capital letter
set incsearch               " Real-time search
set hlsearch                " Highlight matches
" Clear search highlights with Esc
nnoremap <esc> :noh<return><esc>

" --- File Handling & Undo ---
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set undofile                " Maintain undo history across sessions

" --- Custom Keymaps ---
let mapleader = " "         " Match your init.lua leader

" Fast saving and quitting
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>

" Move lines up and down (Alt+j/k)
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

" --- Neovim Compatibility Overrides ---
if has('nvim')
    " Prevent duplicate mapping issues or plugin conflicts
    set completeopt=menu,menuone,noselect
endif
