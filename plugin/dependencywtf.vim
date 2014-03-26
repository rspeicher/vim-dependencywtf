function! DependencyWTF()
  let l:line = getline('.')

  if expand('%:t') == 'Gemfile'
    call l:gemfileWTF(l:line)
  endif
endfunction

function! l:openURL(url)
  execute "silent !open " . a:url
endfunction

" {{{ Gemfile
function! l:gemfileWTF(line)
  let gemName = l:gemName(a:line)
  if gemName != ""
    call l:openURL("https://rubygems.org/gems/" . gemName)
    return
  endif
endfunction

function! l:gemName(line)
  return matchstr(a:line, '\vgem ("|'')\zs(\w|-)+')
endfunction
" }}}

"vim:fdm=marker:fmr={{{,}}}
