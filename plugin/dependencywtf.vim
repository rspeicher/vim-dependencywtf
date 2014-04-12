function! DependencyWTF()
  let l:line = getline('.')

  if expand('%:t') == 'Gemfile'
    call l:gemfileWTF(l:line)
  elseif expand('%:e') == 'gemspec'
    call l:gemspecWTF(l:line)
  elseif &filetype == "vim"
    call l:vimWTF(l:line)
  endif
endfunction

function! l:openURL(url)
  if exists("g:dependencywtf_testing")
    echo a:url
  else
    execute "silent !open " . a:url
  endif
endfunction

" {{{ Gemfile
function! l:gemfileWTF(line)
  let gemName = l:gemNameFromGemfile(a:line)
  if gemName != ""
    call l:openURL("https://rubygems.org/gems/" . gemName)
  endif
endfunction

function! l:gemNameFromGemfile(line)
  return matchstr(a:line, '\vgem ("|'')\zs(\w|-)+\ze("|'')')
endfunction
" }}}

" {{{ gemspec
function! l:gemspecWTF(line)
  let gemName = l:gemNameFromGemspec(a:line)
  if gemName != ""
    call l:openURL("https://rubygems.org/gems/" . gemName)
  endif
endfunction

function! l:gemNameFromGemspec(line)
  return matchstr(a:line, '\v.*add_(development_)?dependency ("|'')\zs(\w|-)+\ze("|'')')
endfunction
" }}}

" {{{ Vundle
function! l:vimWTF(line)
  let bundle = l:bundleName(a:line)

  " TODO: Support for 'git://' style
  if bundle != ""
    if match(bundle, '/') == -1
      call l:openURL("https://github.com/vim-scripts/" . bundle)
    else
      call l:openURL("https://github.com/" . bundle)
    endif
  endif
endfunction

function! l:bundleName(line)
  return matchstr(a:line, '\v^(Bundle|Plugin) ("|'')\zs(.*)+\ze("|'')')
endfunction
" }}}

" vim: fdm=marker:fmr={{{,}}}
