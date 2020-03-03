let s:known_extensions = #{ h: 'c', c: 'h', hpp: 'cpp', cpp: 'hpp' }

" Switch from source to header (and vice versa)
"
" Arguments:
"   newtab - If true the header/source will be opened in a new tab
"
" Remarks:
"   This function only works for extensions listed within
"   `s:known_extensions`.
function s:SwitchToHeader(newtab)
    let ext = expand('%:e')
    let hext = get(s:known_extensions, ext, v:null)

    if hext == v:null
        echohl ErrorMsg | echo "Unrecognised extension" | echohl None
    else
        let cmd = a:newtab ? "tabnew" : "edit"
        let cmd .= ' ' . expand('%:r') . '.' . hext
        echo cmd
        exec cmd
    endif
endfunction

nnoremap <silent> <TAB> :tabnext<CR>
nnoremap <silent> <C-TAB> :tabprev<CR>
nnoremap <Leader>B :e %:h<CR>

" Project management
nmap <Leader>pb :ProjectBuild<CR>
nmap <Leader>pt :ProjectTest<CR>
nmap <Leader>pc :ProjectConfigure<CR>
nmap <Leader>pC :ProjectClean<CR>

" LSP-specific commands
augroup key_bindings_lsp
    autocmd!
    autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp nmap <buffer><Leader>d :LspDocumentDiagnostics<CR>
    autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp nmap <buffer><Leader>s :LspSignatureHelp<CR>
    autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp nmap <Leader>f :LspDocumentFormat<CR>
    autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp nmap <Leader>h :SwitchToHeader<CR>
    autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp nmap <Leader>H :SwitchToHeader!<CR>
augroup END

" File navigation
command -bang SwitchToHeader call s:SwitchToHeader(<bang> v:false)
