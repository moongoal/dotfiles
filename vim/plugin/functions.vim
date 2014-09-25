" Status bar
fu! StatusBar_GetTime()
  if !has("gui_running")
    return strftime("%R")
  else
    return ""
  endif
endf

" Tab line
fu! TabLine_TabLine()
  let line = "%#TabLineFill# "
  let cur_tab = tabpagenr()
  let last_tab = tabpagenr('$')

  for i in range(last_tab)
    if i + 1 == cur_tab
      let line .= "%#TabLineSel#"
    else
      let line .= "%#TabLine#"
    endif

    let line .= TabLine_TabElement(i + 1) . " "
  endfor

  let line .= "%#TabLineFill#%=%<" . bufname(tabpagebuflist(cur_tab)[tabpagewinnr(cur_tab) - 1]) . " "
  return line
endf

fu! TabLine_TabElement(tabpagenr)
  let fname = fnamemodify(bufname(tabpagebuflist(a:tabpagenr)[tabpagewinnr(a:tabpagenr) - 1]), ":t")
  let label = ""

  if strlen(fname) == 0
    let label = "[Buffer " . a:tabpagenr . "]"
  else
    let label = fname
  endif

  return label
endf
