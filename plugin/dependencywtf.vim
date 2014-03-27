function! DependencyWTF()
  let l:line = getline('.')

  if expand('%:t') == 'Gemfile'
    call l:gemfileWTF(l:line)
  elseif expand('%:e') == 'gemspec'
    call l:gemspecWTF(l:line)
  endif
endfunction

function! l:openURL(url)
  execute "silent !open " . a:url
endfunction

" {{{ Gemfile
function! l:gemfileWTF(line)
  let gemName = l:gemNameFromGemfile(a:line)
  if gemName != ""
    call l:openURL("https://rubygems.org/gems/" . gemName)
  endif
endfunction

function! l:gemNameFromGemfile(line)
  " Must match the following lines:
  "   gem "jquery-rails"
  "   gem 'active_support'
  "   gem 'foo', '1.0.0', require: false
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
  " Must match the following lines:
  "   s.add_dependency 'activesupport', ['>= 3.0.0']
  "   s.add_development_dependency "bundler", ['>= 1.0.0']
  "   s.add_development_dependency 'bundler'
  return matchstr(a:line, '\v.*add_(development_)?dependency ("|'')\zs(\w|-)+\ze("|'')')
endfunction
" }}}

" vim: fdm=marker:fmr={{{,}}}
