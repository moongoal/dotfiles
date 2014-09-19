" Set vim home dir
if has("win32")
  let vimdir = $HOME . "/vimfiles"
else
  let vimdir = $HOME . "/.vim"
endif

" System settings
if has("multi_byte")
  set encoding=utf-8
  set fileencodings=utf-8
endif

filetype on
filetype plugin on

set noswapfile
set nocompatible

if has("autocmd")
  autocmd BufNewFile * set ff=unix
  autocmd BufNewFile,BufReadPre,FilterReadPre,FileReadPre *.py setlocal cursorcolumn
endif

" Appearance settings
set number
colorscheme desert
set laststatus=2
set visualbell

if has("extra_search")
  set hlsearch
endif

if has("syntax")
  syntax on
  set cursorline
endif

"* GUI
if has("gui_running")
  set lines=36 columns=156
  set guioptions=
  
  if has("gui_gtk")
    set guifont=Inconsolata\ 14
  elseif has("gui_win32")
    set guifont=consolas_for_powerline_fixedd:h14
  endif

  execute "source " . vimdir . "/airline-config.vim"
  let g:airline_powerline_fonts=1
endif

if exists("&guicursor")
  set guicursor=n-v-ve-o-c-ci-cr-sm:block-blinkon0,i:block-blinkwait700-blinkon400-blinkoff250,r:hor20-blinkon400-blinkwait700-blinkoff250
endif

" Editing settings
set tabstop=2 softtabstop=2 expandtab
set autoindent nosmartindent
set backspace=indent,eol,start
set showmatch

" Keyboard mappings
nmap <Tab> gt
nmap <C-Tab> gT
nmap <C-F4> :tabclose<CR>
imap <Up> <Nop>
imap <Down> <Nop>
nmap <C-F1> :VExplore<CR>

" Templates
execute "source " . vimdir . "/templates.vim"

" Documentation
execute "helptags " . vimdir . "/doc"
