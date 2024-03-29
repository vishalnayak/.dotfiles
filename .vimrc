let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" vim-plug needs and plugins {{{
call plug#begin('~/.vim/plugged')

" Plugins go here

" Fast file switching
Plug 'kien/ctrlp.vim'

" Go support
Plug 'fatih/vim-go'

" Search using The Silver Searcher
Plug 'rking/ag.vim'

" Graphical undo tree browsing
Plug 'sjl/gundo.vim'

" A whole bunch of color schemes
Plug 'flazz/vim-colorschemes'

" ctags-based tag bar
Plug 'majutsushi/tagbar'

" Allows pressing F12 to toggle mouse capture in terminal, great for copying
Plug 'nvie/vim-togglemouse'

" Info line
Plug 'bling/vim-airline'

" Syntax checking support (using gofmt for instance)
" Doesn't play nicely with vim-go lately
" Plug 'scrooloose/syntastic'

" Enhancements for when running in tmux
Plug 'edkolev/tmuxline.vim'

" Allows using vim to generate prompt lines
Plug 'edkolev/promptline.vim'

" Navigation bar to browse the files
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Show diff information in the gutter
Plug 'airblade/vim-gitgutter'

" Go completion support
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

" Git handling inside vim
Plug 'tpope/vim-fugitive'

" Let tab do smart things with omnicomplete
Plug 'ervandew/supertab'

" Don't run folding logic when not needed, fixes ultra slow omnicomplete
Plug 'Konfekt/FastFold'

" Better view/session restoring/saving
Plug 'kopischke/vim-stay'

" Use silver searcher for finding
Plug 'rking/ag.vim'

" Smart tabularizing; also needed for vim-markdown
Plug 'godlygeek/tabular'

" Better Markdown handling
Plug 'plasticboy/vim-markdown'

" Map useful stuff to []
Plug 'tpope/vim-unimpaired'

" HCL formatting
Plug 'fatih/vim-hclfmt'

" Automatic session management
Plug 'tpope/vim-obsession'

" Better JSON support
Plug 'elzr/vim-json'

" Task support
Plug 'joonty/vim-do'

call plug#end()
" }}}


" Misc global settings {{{
syntax enable                       " enable syntax processing
set tw=79                           " enable automatic text wrapping for 79 characters
set modeline                        " turn on modeline processing
set modelines=4                     " look at beginning or end of file
set hidden                          " allow buffers to live in the background with changes
set history=1000                    " remember a lot of history
set title                           " change the terminal's title
set visualbell                      " don't beep
set noerrorbells                    " don't beep
if !has('nvim')
    set viminfo='100,<100,%,n~/.viminfo " extend amount of saved info, only for regular vim
endif
set nowrapscan
set number

" enable copy pasting across applications
set clipboard=unnamedplus,unnamed,autoselect

" fix the backspace problem
set backspace=indent,eol,start
" }}}


" Whitespace settings {{{
set wrap                " wrap lines
set linebreak           " only wrap at characters in 'breakat'
set nolist              " list disables linebreak
set whichwrap&          " don't have left/right move to new lines
set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set shiftwidth=4        " without this it does two tab stops recently, not sure why
" }}}


" UI settings {{{
set number                " show line numbers
"set relativenumber        " show other line numbers relative to the current
set cursorline            " highlight current line
set showcmd               " show command in bottom bar
set wildmenu              " visual autocomplete for command menu
set lazyredraw            " redraw only when we need to
set showmatch             " highlight matching [{()}]
set pastetoggle=<F2>      " use F2 to switch into paste mode
set mouse=a               " allow capturing the mouse for scrolling

filetype plugin indent on " load filetype-specific and plugin-specific indent files

if has('gui_running')
    set guioptions-=T     " Remove the toolbar
    set lines=40          " 40 lines of text instead of 24
else
    if &term == 'xterm' || &term == 'screen' || &term == 'screen-256color'
        set t_Co=256      " enable 256 colors
    endif
endif

set list                  " show whitespace
set listchars=tab:\|\     " use pipes for tab

colorscheme badwolf       " awesome colorscheme
" }}}


" Search settings {{{
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase          " ignore case when searching
set smartcase           " but be smart about capitalization

" turn off search highlight with leader + space
nnoremap <leader><space> :nohlsearch<CR>
" }}}


" Folding settings {{{
set nofoldenable         " plugin updates broke folding, so turning off for now
"set foldenable          " enable folding
"set foldlevelstart=10   " open most folds by default
"set foldlevel=10        " open most folds by default

" space open/closes folds
nnoremap <space> za

"set foldmethod=syntax   " Use syntax folding, dangerous without FastFold!
" }}}


" Movement settings {{{

" move vertically by visual line rather than real line numbers
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
vnoremap B ^
nnoremap E $
vnoremap E $

" highlight last inserted text
nnoremap gV `[v`]

" Make 'jk' exit from insert mode
inoremap jk <Esc>
inoremap jK <Esc>
inoremap Jk <Esc>
inoremap JK <Esc>
" }}}


" Leader settings {{{
" For whatever reason, 'let mapleader=...' is *not* working for me;
" nmap/vmap work just fine
nmap , \
vmap , \

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" open ag.vim
nnoremap <leader>a :Ag
" }}}


" Spelling settings {{{
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell
" }}}


" CtrlP {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" Or, with hidden files
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" }}}


" Tagbar {{{
" Use leader + tt for toggle
nnoremap <silent> <leader>tt :TagbarToggle<CR>
"}}}

" NERDTree {{{
nnoremap <leader>n :NERDTreeToggle<CR>
" }}}


" vim-go {{{
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_interfaces = 1
let g:go_fmt_command = "goimports"
"let g:go_list_type = "quickfix"
"let g:go_fmt_fail_silently = 1
augroup gogroup
  autocmd!
  autocmd FileType go nmap <Leader>gb <Plug>(go-build)
  autocmd FileType go nmap <Leader>gt <Plug>(go-test)
  autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
  autocmd FileType go nmap <Leader>gdb <Plug>(go-doc-browser)
  autocmd FileType go nmap <Leader>gdv <Plug>(go-doc-vertical)
  autocmd FileType go nmap <Leader>gdsc <Plug>(go-describe)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <Leader>e <Plug>(go-rename)
augroup END
" }}}


" Airline {{{
set laststatus=2    " always show the status line

" prevents a long delay when switching into insert mode when using vim-airline
set ttimeoutlen=50
" }}}


" Syntastic {{{
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_check_on_wq = 0
"let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
""let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
""let g:syntastic_always_populate_loc_list = 1
""let g:syntastic_auto_loc_list = 1
" }}}


" SuperTab {{{
" Let SuperTab try to do the right thing at the right time when you hit Tab
let g:SuperTabDefaultCompletionType = "context"
" }}}


" vim-stay {{{
" Suggested by the author for portability of view files
set viewoptions=cursor,folds,slash,unix
" }}}


" vim-markdown {{{
" Highlight YAML frontmatter
let g:vim_markdown_frontmatter = 1
" Highlight JSON frontmatter
let g:vim_markdown_json_frontmatter = 1
" Stop folding, I trigger it too often accidentally
let g:vim_markdown_folding_disabled = 1
" Use 2, not 4, spaces on new item for indentation
let g:vim_markdown_new_list_item_indent = 2
augroup markdowngroup
  autocmd!
  autocmd FileType markdown set tabstop=4
  autocmd FileType markdown set shiftwidth=4
  autocmd FileType markdown set expandtab
  " Try to fix badness around Markdown and bullets
  " https://github.com/plasticboy/vim-markdown/issues/232#issuecomment-246173676
  autocmd FileType markdown set formatoptions-=q | set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*\[-*+]\\s\\+
augroup END

" }}}


" Tmux {{{
" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}


" Backups {{{
" enable backups, but use tmp folders rather than using <file>~
"set backup
"set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"set backupskip=/tmp/*,/private/tmp/*
"set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"set writebackup
"
set nobackup
" }}}


" vim:foldmethod=marker:foldlevel=0

