if !exists("g:templates_directory")
  if has("win32")
    let g:templates_directory = $HOME . "/vimfiles/templates"
  else
    let g:templates_directory = $HOME . "/.vim/templates"
  endif
endif

" Insert template file under cursor
"
" Inserts a template file named 'tname.txt' which is found in the
" g:templates_directory folder.
"
fu! templates#TemplateInsert(tname)
  let fname=g:templates_directory . "/" . a:tname . ".txt"

  if filereadable(fname)
    execute "0read " . fname
  else
    echoerr "Unkown template file " . fname
  endif
endfunction
