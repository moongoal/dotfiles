fu TabLine()
    let tl = ''
    let current_tab_page = tabpagenr()

    " Draw tab labels
    for t in range(tabpagenr('$'))
        if t + 1 == current_tab_page
            " Current tab page
            let tl .= '%#TabLineSel#'
        else
            " Other tab page
            let tl .= '%#TabLine#'
        endif

        " Tab number to return on click
        let tl .= '%' . (t + 1) . 'T'
        
        " Draw tab label
        let tl .= ' %{TabLine_DrawLabel(' . (t + 1) . ')} '
    endfor

    " Draw background
    let tl .= '%#TabLineFill#%T'

    return tl
endfunction

fu TabLine_DrawLabel(n)
    let label = ''
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let bufid = buflist[winnr - 1]
    let buf_name = bufname(bufid)
    let buf_modified = getbufvar(bufid, "&mod")
    let buf_name_tail = fnamemodify(buf_name, ':t')
    let tab_pg_nr = tabpagenr()

    if a:n == tab_pg_nr
        let label .= '['
    endif

    if buf_modified
        let label .= '*'
    endif

    if buf_name_tail == ""
        let label .= "/UNNAMED/"
    else
        let label .= buf_name_tail
    endif

    if buf_modified
        let label .= '*'
    endif

    if a:n == tab_pg_nr
        let label .= ']'
    endif
 
    return label
endfunction

set tabline=%!TabLine()
hi TabLineModified gui=italic
