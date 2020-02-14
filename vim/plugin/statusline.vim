fu StatusLine()
    let left = "%([%M%R%H%W] %q %f%)"
    let right = "%<%([%{&ff}] 0x%00B @ %l,%c (%p%%)%) %(%y%)"

    return left . "%=" . right
endfunction

set statusline=%!StatusLine()
