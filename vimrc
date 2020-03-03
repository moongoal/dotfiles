" General
colorscheme desert

set number
set cursorline
set nocp
set notimeout
set laststatus=2
set foldmethod=syntax
set shortmess+=I

" Highlighting
hi Pmenu guibg='SlateBlue' guifg='Yellow'
hi PmenuSel guibg='LightYellow' guifg='LightRed'
hi TabLine guibg='LightGrey' guifg='Black'
hi TabLineSel guifg='LightGreen' guibg='Blue'
hi TabLineFill guifg='Grey'

" Editing
set softtabstop=4
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
set smartindent
set hlsearch
set ff=unix ffs=unix,dos
set fencs=ucs-bom,utf8,default,latin1
set makeencoding=utf-8
set foldnestmax=0

" GUI
if has("gui_running")
    set mousehide
    set guioptions=cgk\!
    set guifont=Inconsolata:h16:W500:cANSI:qDRAFT
    set guicursor=a:block-blinkon1000-blinkoff0,i:block-blinkon500-blinkoff500
    au GUIEnter * simalt ~x
endif

" Sessions
set ssop=folds,globals,localoptions,resize,sesdir,slash,tabpages,terminal,unix

" Plugins
filetype plugin on
packadd! async
packadd vim-lsp

" Additional configs
runtime! config/**/*.vim
