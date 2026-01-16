function! GitPath()
  let l:path = get(b:, 'git_path', '')
  if empty(l:path)
    if &filetype == 'netrw' && exists('b:netrw_curdir')
      return b:netrw_curdir
    endif
    return expand('%:p')
  endif
  return l:path
endfunction

function! UpdateGitStatus()
  let b:git_branch = ''
  let b:git_path = expand('%:p')

  if &buftype != '' | return | endif

  let l:dir = expand('%:p:h')
  if empty(l:dir) | let l:dir = getcwd() | endif

  let l:cmd = "git -C " . shellescape(l:dir)
  let l:branch = trim(system(l:cmd . " symbolic-ref --short HEAD 2>/dev/null"))
  if v:shell_error
    let l:branch = trim(system(l:cmd . " rev-parse --short HEAD 2>/dev/null"))
    if v:shell_error | return | endif
  endif

  let l:dirty = empty(system(l:cmd . " status -s -uno 2>/dev/null | head -c1")) ? '' : '*'

  let l:info = split(system(l:cmd . " rev-parse --git-dir --show-toplevel 2>/dev/null"), "\n")
  if v:shell_error || len(l:info) < 2 | return | endif

  let l:git_dir = l:info[0]
  if l:git_dir !~# '^/' | let l:git_dir = l:dir . '/' . l:git_dir | endif

  let l:root = l:info[1]
  let l:fullpath = expand('%:p')
  if l:fullpath[0:len(l:root)-1] ==# l:root
    let b:git_path = fnamemodify(l:root, ':t') . l:fullpath[len(l:root):]
  endif

  let l:state = ''
  if isdirectory(l:git_dir . '/rebase-merge') || isdirectory(l:git_dir . '/rebase-apply')
    let l:state = '|REBASE'
  elseif filereadable(l:git_dir . '/MERGE_HEAD')
    let l:state = '|MERGE'
  elseif filereadable(l:git_dir . '/CHERRY_PICK_HEAD')
    let l:state = '|PICK'
  endif

  let b:git_branch = '(' . l:branch . l:dirty . l:state . ')'
endfunction

augroup gitstatus
  autocmd!
  "autocmd BufEnter,BufWinEnter,BufWritePost,FocusGained * call UpdateGitStatus()
  autocmd BufEnter,BufWritePost * call UpdateGitStatus()
augroup END
