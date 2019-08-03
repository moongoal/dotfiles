" vim: foldmethod=marker
colorscheme evening

set nocp
set matchpairs
set number
set ruler
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set guicursor=a:block,i:blinkon500-blinkoff500-blinkwait500
set cursorline
set cursorcolumn
set ffs=unix,dos

filetype plugin on

noremap <TAB> :tabnext<CR>
noremap <C-TAB> :tabprevious<CR>

" Fonts {{{1
let s:fontsize = 14
let s:fontface = "Consolas"

function! AdjustFontSize(size_incr)
    let s:fontsize = s:fontsize + a:size_incr
    execute "set guifont=" . s:fontface . ":h" . s:fontsize
endfunction

call AdjustFontSize(0)

noremap <kPlus> :call AdjustFontSize(1)<CR>
noremap <kMinus> :call AdjustFontSize(-1)<CR>

" Auto commands {{{1
" autocmd BufNewFile,BufRead,BufEnter *.cpp,*.hpp setl autochdir
function! SwitchToHeader(fname, cmd)
    let extension = fnamemodify(a:fname, ":e")
    let header_fname = fnamemodify(a:fname, ":p:r")

    if extension == "hpp"
        let header_fname .= ".cpp"
    else
        let header_fname .= ".hpp"
    endif

    :execute ':' . a:cmd . ' ' . header_fname
endfunction

autocmd BufNewFile,BufRead,BufEnter *.cpp,*.hpp nnoremap  :call SwitchToHeader(expand("%"), "e")<CR>
autocmd BufNewFile,BufRead,BufEnter *.cpp,*.hpp nnoremap <M-s> :call SwitchToHeader(expand("%"), "vsplit")<CR>


" Tab line {{{1
function! QTabLine()
    let cur_tab_i = tabpagenr()
    let t = ''

    for i in range(tabpagenr('$'))
        if i + 1 == cur_tab_i
            let t .= '%#TabLineSel#'
        else
            let t .= '%#TabLine#'
        endif

        let t .= '%' . (i + 1) . 'T'
        let t .= ' %{QTabLabel(' . (i + 1) . ')} '
    endfor

    let t .= '%T%#TabLineFill#%= :: %{bufname("%")} '

    return t
endfunction

function! QTabLabel(tab_idx)
    let buflist = tabpagebuflist(a:tab_idx)
    let win_idx = tabpagewinnr(a:tab_idx)
    let buf = buflist[win_idx - 1]
    let bufinfo = getbufinfo(buf)[0]
    let fname = fnamemodify(bufname(buf), ':t')

    if bufinfo['changed']
        let lbefore = '* '
        let lend = ' *'
    else
        let lbefore = '[ '
        let lend = ' ]'
    endif

    let label = lbefore . fname . lend

    return label
endfunction

:set tabline=%!QTabLine()

" Status line {{{1
function! QStatusLine()
    let s = '%( %y %m %r %w %q %) %t %= %( %l,%c(0x%B) %p%% %)'

    if exists("*strftime")
        let time = strftime("%H:%M")
        let s .= ' :: ' . time
    endif

    return s
endfunction

:set statusline=%!QStatusLine()
