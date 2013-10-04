" vim: et sw=2 sts=2

scriptencoding utf-8

" Init {{{1
if has_key(g:toplevel, 'rootlist')
  let s:rootlist = g:toplevel.rootlist
else
  let s:rootlist = filter(['git', 'hg', 'bzr'], 'executable(v:val)')
endif

let s:vsmode = (has('win32') && has_key(g:toplevel, 'vimshell')) ? 1 : 0
"}}}

" toplevel#root#find {{{1
function! toplevel#root#find(bang) abort
  if exists('b:toplevel_root')
    return toplevel#cd_to_root(a:bang, b:toplevel_root)
  endif

  for target in s:rootlist
    try
      let rootpath = s:detect_{target}()
    catch
      continue
    endtry

    if !empty(rootpath)
      let b:toplevel_root = split(rootpath)[0]
      return toplevel#cd_to_root(a:bang, b:toplevel_root)
    endif
  endfor

  echohl ErrorMsg
  echo 'No VCS found.'
  echohl NONE
endfunction
"}}}

" s:detect_git {{{1
function! s:detect_git() abort
  let cmd = 'git rev-parse --show-toplevel'

  if s:vsmode
    let ret = xolox#misc#os#exec({'command': cmd})
    return ret.exit_code ? '' : join(ret.stdout, "\n")
  endif

  let root = system(cmd)
  return v:shell_error ? '' : root
endfunction

" s:detect_hg {{{1
function! s:detect_hg() abort
  let cmd = 'hg root'

  if s:vsmode
    let ret = xolox#misc#os#exec({'command': cmd})
    return ret.exit_code ? '' : join(ret.stdout, "\n")
  endif

  let root = system(cmd)
  return v:shell_error ? '' : root
endfunction

" s:detect_bzr {{{1
function! s:detect_bzr() abort
  let cmd = 'bzr root'

  if s:vsmode
    let ret = xolox#misc#os#exec({'command': cmd})
    return ret.exit_code ? '' : join(ret.stdout, "\n")
  endif

  let root = system(cmd)
  return v:shell_error ? '' : root
endfunction
