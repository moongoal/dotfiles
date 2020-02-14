" General
colorscheme desert

set number
set cursorline
set nocp
set laststatus=2

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

" GUI
if has("gui_running")
    set mousehide
    set guioptions="cegtk"
    set guifont=Inconsolata:h16:W500:cANSI:qDRAFT
    set guicursor=a:block-blinkon1000-blinkoff0,i:block-blinkon500-blinkoff500
    au GUIEnter * simalt ~x
endif

" Plugins
filetype plugin on
packadd! async
packadd vim-lsp

" Additional configs
runtime! config/**/*.vim
