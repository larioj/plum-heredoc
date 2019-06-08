function! plum#heredoc#Heredoc()
  return plum#CreateAction(
        \ 'plum#heredoc#Heredoc',
        \ function('plum#heredoc#IsHeredoc'),
        \ function('plum#term#SmartTerminal'))
endfunction

function! plum#heredoc#IsHeredoc(context)
  let context = a:context

  if context.mode !=# 'n' && context.mode !=# 'i'
    return 0
  endif

  let line = context.line

  let indent = 0
  let space = ''
  while strpart(line, indent, 1) ==# ' '
    let indent = indent + 1
    let space = space . ' '
  endwhile

  if strpart(line, indent, 2) !=# '$ ' || line !~# '<<EOF'
    return 0
  endif

  let lmax = line('$')
  let lines = []
  let lnum = line('.') 
  while lnum <= lmax
    let curline = getline(lnum)
    let lines = lines + [strpart(curline, indent)]
    let lnum = lnum + 1

    if strpart(curline, 0, indent) !=# space
      return 0
    endif

    if s:Strip(curline) ==# 'EOF'
      if strpart(curline, indent, 3) !=# 'EOF'
        return 0
      endif
      let context.match = strpart(join(lines, "\n"), 2)
      return 1
    endif
  endwhile
  
  return 0
endfunction

function! s:Strip(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction
