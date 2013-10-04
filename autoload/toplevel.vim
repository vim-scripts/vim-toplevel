" vim: et sw=2 sts=2

scriptencoding utf-8

" toplevel#cd_to_root {{{1
function! toplevel#cd_to_root(bang, rootpath) abort
  if a:bang
    execute 'cd' a:rootpath
  else
    execute 'lcd' a:rootpath
  endif

  echo 'Changed to: '. a:rootpath
endfunction
