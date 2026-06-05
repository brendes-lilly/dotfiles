function! s:update() abort
  let b:gitstatus_branch = ''
  let b:gitstatus_path = expand('%:p')

  if &buftype != '' | return | endif

  let l:dir = expand('%:p:h')
  if empty(l:dir) | let l:dir = getcwd() | endif

  let l:cmd = 'git -C ' . shellescape(l:dir)
  let l:branch = trim(system(l:cmd . ' symbolic-ref --short HEAD 2>/dev/null'))
  if v:shell_error
    let l:branch = trim(system(l:cmd . ' rev-parse --short HEAD 2>/dev/null'))
    if v:shell_error | return | endif
  endif

  let l:dirty = trim(system(l:cmd . ' diff --quiet HEAD 2>/dev/null; echo $?')) != '0' ? '*' : ''

  let l:info = split(system(l:cmd . ' rev-parse --git-dir --show-toplevel 2>/dev/null'), "\n")
  if v:shell_error || len(l:info) < 2 | return | endif

  let l:git_dir = l:info[0]
  if l:git_dir !~# '^/' | let l:git_dir = l:dir . '/' . l:git_dir | endif

  let l:root = l:info[1]
  let l:fullpath = expand('%:p')
  if l:fullpath[0:len(l:root)-1] ==# l:root
    let b:gitstatus_path = fnamemodify(l:root, ':t') . l:fullpath[len(l:root):]
  endif

  let l:state = ''
  if isdirectory(l:git_dir . '/rebase-merge') || isdirectory(l:git_dir . '/rebase-apply')
    let l:state = '|REBASE'
  elseif filereadable(l:git_dir . '/MERGE_HEAD')
    let l:state = '|MERGE'
  elseif filereadable(l:git_dir . '/CHERRY_PICK_HEAD')
    let l:state = '|PICK'
  endif

  let b:gitstatus_branch = '(' . l:branch . l:dirty . l:state . ')'
endfunction

function! GitStatusBranch() abort
  return get(b:, 'gitstatus_branch', '')
endfunction

function! GitStatusPath() abort
  let l:path = get(b:, 'gitstatus_path', '')
  if empty(l:path)
    if &filetype == 'netrw' && exists('b:netrw_curdir')
      let l:path = b:netrw_curdir
    else
      return expand('%:~')
    endif
  endif
  return l:path
endfunction

augroup gitstatus
  autocmd!
  autocmd BufEnter,BufWritePost * call s:update()
augroup END
