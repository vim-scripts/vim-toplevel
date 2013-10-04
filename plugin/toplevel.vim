" vim: et sw=2 sts=2

scriptencoding utf-8

if exists('g:loaded_toplevel') || &compatible
  finish
endif
let g:loaded_toplevel = 1

if !exists('toplevel')
  let toplevel = {}
endif

command! -nargs=0 -bar -bang Cd   call toplevel#cd#find(<bang>0)
command! -nargs=0 -bar -bang Root call toplevel#root#find(<bang>0)
