
" Open the debugger terminal
function DbgOpen()
    if !exists("g:dbg_buff")
        let g:dbg_buff = term_start("lldb")
    endif
endfunction

" Close the debugger terminal
function DbgClose()
    try
        call DbgRawSendCommand("set set interpreter.prompt-on-quit false")
        call DbgRawSendCommand("exit") 
    finally 
        unlet g:dbg_buff 
    endtry
endfunction

" Send a string and a newline to the terminal
function DbgRawSendCommand(cmd)
    if exists("g:dbg_buff")
        call term_sendkeys(g:dbg_buff, a:cmd . "\r")
    else
        call s:PrintError("Debugger not loaded.")
    endif
endfunction

" Guess what does this do?
function s:PrintError(msg)
    echohl ErrorMsg | echo "ERROR: " . a:msg | echohl None
endfunction

" Set a breakpoint
function DbgRawBreak(file_path, line_no)
    call DbgRawSendCommand("b " . a:file_path . ":" . a:line_no)
endfunction

" Set a breakpoint depending on arguments.
"
" Allowed signatures are:
"   DbgBreak() - Add breakpoint @ current_file:current_line
"   DbgBreak(line_no) - Add breakpoint @ current_file:line_no
"   DbgBreak(file, line_no) - Add breakpoint @ file:line_no
function DbgBreak(...)
    if a:0 == 0
        " (No arguments)
        call DbgRawBreak(bufname(), line('.'))
    elseif a:0 == 1
        " (line_no)
        let line_no = a:1

        call DbgRawBreak(bufname(), line_no)
    elseif a:0 == 2
        " (file, line_no)
        let file = a:1
        let line_no = a:2

        call DbgRawBreak(file, line_no)
    else
        call s:PrintError("Invalid number of arguments.")
    endif
endfunction

" Step through the code
"
" Arguments:
"   into: true to "step in", false to "step over"
function DbgStep(into)
    let cmd = "s"

    if into
        let cmd += "i"
    endif

    call DbgRawSendCommand(cmd)
endfunction

command Dbgopen call DbgOpen()
command Dbgclose call DbgClose()
command -nargs=* Break call DbgBreak(<f-args>)
command Continue call DbgRawSendCommand("c")
command -bang Step call DbgStep(<f-args>)
command Locals call DbgRawSendCommand("info locals")
