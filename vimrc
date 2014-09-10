" Set vim home dir
if has("win32")
  let vimdir = $HOME . "/vimfiles"
else
  let vimdir = $HOME . "/.vim"
endif

" System settings
set encoding=utf-8
set ff=unix
set noswapfile
autocmd BufNewFile * :set ff=unix

" Appearance settings
set number
colorscheme desert
syntax on
set laststatus=2
set visualbell
set cursorline
set hlsearch

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
set tabstop=2 expandtab
set autoindent smartindent

" Keyboard mappings
"* TABS
nmap <Tab> gt
nmap <C-Tab> gT
nmap <C-F4> :tabclose<CR>

"* NERDTree
nmap <C-F1> :NERDTreeToggle<CR>

" Templates
execute "source " . vimdir . "/templates.vim"

" Documentation
execute "helptags " . vimdir . "/doc"

" Configuration files
let g:NERDTreeBookmarksFile = vimdir . "/NERDTreeBookmarks"
