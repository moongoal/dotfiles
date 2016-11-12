" General {{{
set noswapfile
set nocompatible
set modelines=1
set modeline
set foldenable

if has("autocmd")
  autocmd BufNewFile * set ff=unix
  autocmd BufNewFile,BufReadPost *.py,*.pyw setlocal cursorcolumn tabstop=2 softtabstop=2
	autocmd BufNewFile,BufReadPost Makefile,Makefile.*,*.makefile,*.mk setlocal noexpandtab
  autocmd BufNewFile,BufReadPost *.eml setlocal fileformat=dos
endif
" }}}
" Encodings and formats {{{
if has("multi_byte")
  set encoding=utf-8
  set fileencoding=utf-8
  set fileencodings=utf-8
endif

set fileformats=unix,dos

filetype on
filetype plugin off
" }}}
" Windows specific settings {{{
" Set vim home dir
if has("win32")
  let vimdir = $HOME . "/vimfiles"
else
  let vimdir = $HOME . "/.vim"
endif
" }}}
" UI {{{
colorscheme elflord
set number
set laststatus=2
set visualbell
set mouse=
set scrolloff=8

if has("extra_search")
  set hlsearch
endif

if has("syntax")
  syntax on
  set cursorline
  highlight CursorLine gui=NONE guibg=#222222 term=NONE ctermbg=Black ctermfg=NONE cterm=NONE term=NONE
endif

if has("windows")
  hi TabLine term=NONE cterm=NONE gui=NONE ctermfg=grey ctermbg=233 guibg=#333333 guifg=grey
  hi TabLineSel term=bold cterm=bold gui=bold ctermfg=50 ctermbg=22 guifg=#11E5F0 guibg=#0E7D24
  hi TabLineFill ctermfg=darkgray guifg=darkgray

  set tabline=%!TabLine_TabLine()
endif

" GUI {{{
if has("gui_running")
  set lines=36 columns=156
  set guioptions=

  if has("unnamedplus")
    set clipboard=unnamed,unnamedplus,autoselect
  else
    set clipboard=unnamed,autoselect
  endif

  if has("gui_win32")
    set guifont=consolas_for_powerline_fixedd:h14
  else
    set guifont=Inconsolata\ 14
  endif

  hi Cursor guibg=Lime guifg=Red gui=NONE ctermbg=Green ctermfg=Red cterm=NONE
endif

if exists("&guicursor")
  set guicursor=n-v-ve-o-c-ci-cr-sm:block-blinkon0,i:block-blinkwait700-blinkon400-blinkoff250,r:hor20-blinkon400-blinkwait700-blinkoff250
endif

if has("statusline")
  set statusline=%m\ %02n\ %-32t\ %W%Y(%{&fileformat}:%{&fileencoding})%=%(%{StatusBar_GetTime()}\ %)%(%q\ %)%c,%l%(\ [0x%02.4B]%)\ %p%%
endif

if has("title")
  set titlestring=%(%f\ -\ %)VIM
endif
" }}}
" }}}
" Editing settings {{{
set tabstop=2 softtabstop=2 expandtab
set autoindent nosmartindent
set backspace=indent,eol,start
set showmatch
" }}}
" Keyboard mappings {{{
nmap <Tab> gt
nmap <C-Tab> gT
nmap <C-F4> :tabclose<CR>
imap <Up> <Nop>
imap <Down> <Nop>
nmap <C-F1> :Vexplore<CR>
" }}}
" Templates {{{
command -nargs=1 TemplateInsert :call templates#TemplateInsert(<f-args>)
" }}}
" vim: foldmethod=marker:foldlevel=0
