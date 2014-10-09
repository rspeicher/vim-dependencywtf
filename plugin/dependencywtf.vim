com! -nargs=0 DependencyWTF
\ call DependencyWTF()

function! DependencyWTF()
  let s:line = getline('.')

  if expand('%:t') == 'Gemfile'
    call s:gemfileWTF(s:line)
  elseif expand('%:e') == 'gemspec'
    call s:gemspecWTF(s:line)
  elseif &filetype == "vim"
    call s:vimWTF(s:line)
  endif
endfunction

function! s:openURL(url)
  if exists("g:dependencywtf_testing")
    echo a:url
  else
    execute "silent !open " . a:url
  endif
endfunction

" {{{ Gemfile
function! s:gemfileWTF(line)
  let gemName = s:gemNameFromGemfile(a:line)
  if gemName != ""
    call s:openURL("https://rubygems.org/gems/" . gemName)
  endif
endfunction

function! s:gemNameFromGemfile(line)
  return matchstr(a:line, '\vgem ("|'')\zs(\w|-)+\ze("|'')')
endfunction
" }}}

" {{{ gemspec
function! s:gemspecWTF(line)
  let gemName = s:gemNameFromGemspec(a:line)
  if gemName != ""
    call s:openURL("https://rubygems.org/gems/" . gemName)
  endif
endfunction

function! s:gemNameFromGemspec(line)
  return matchstr(a:line, '\v.*add_(development_)?dependency ("|'')\zs(\w|-)+\ze("|'')')
endfunction
" }}}

" {{{ Vundle
function! s:vimWTF(line)
  let bundle = s:bundleName(a:line)

  " TODO: Support for 'git://' style
  if bundle != ""
    if match(bundle, '/') == -1
      call s:openURL("https://github.com/vim-scripts/" . bundle)
    else
      call s:openURL("https://github.com/" . bundle)
    endif
  endif
endfunction

function! s:bundleName(line)
  return matchstr(a:line, '\v^(Bundle|Plugin) ("|'')\zs(\w|-|\/|\.)+\ze("|'')')
endfunction
" }}}

" vim: fdm=marker:fmr={{{,}}}
