" vim: et sw=2 sts=2

scriptencoding utf-8

" Init {{{1
if has_key(g:toplevel, 'cdlist')
  let s:cdlist = g:toplevel.cdlist
else
  let s:cdlist = [
        \ ['.git', 'finddir' ],
        \ ['.hg',  'finddir' ],
        \ ['.bzr', 'finddir' ],
        \ ]
endif
"}}}

" toplevel#cd#find {{{1
function! toplevel#cd#find(bang) abort
  if exists('b:toplevel_cd')
    return toplevel#cd_to_root(a:bang, b:toplevel_cd)
  endif

  let curdir = resolve(expand('<afile>:p:h')) .';'

  for target in s:cdlist
    let root = call(target[1], [target[0], curdir])
    if !empty(root)
      let b:toplevel_cd = fnamemodify(root, ':p:h:h')
      return toplevel#cd_to_root(a:bang, b:toplevel_cd)
    endif
  endfor

  echohl ErrorMsg
  echo 'No VCS found.'
  echohl NONE
endfunction
