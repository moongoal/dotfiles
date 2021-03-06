if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': { server_info->['clangd'] },
            \ 'whitelist': ['c', 'cpp', 'cxx'],
            \ })
        autocmd FileType c,cpp setlocal omnifunc=lsp#complete
    augroup end
endif
