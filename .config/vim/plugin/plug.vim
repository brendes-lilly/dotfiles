if has('nvim') | finish | endif

let g:plug_dir = (!empty($XDG_DATA_HOME) ? $XDG_DATA_HOME : $HOME.'/.local/share/vim') . '/pack/bundle/start'
let g:plug_list = [
  \ 'https://github.com/mhinz/vim-signify',
  \ ]

function! s:sync() abort
  call mkdir(g:plug_dir, 'p')
  let l:wanted = map(copy(g:plug_list), 'fnamemodify(v:val, ":t")')
  for url in g:plug_list
    let dest = g:plug_dir . '/' . fnamemodify(url, ':t')
    if !isdirectory(dest)
      echo 'Installing ' . fnamemodify(url, ':t') . '...'
      call system('git clone --depth 1 ' . url . ' ' . dest)
    else
      echo 'Updating ' . fnamemodify(url, ':t') . '...'
      call system('git -C ' . dest . ' pull --ff-only')
    endif
  endfor
  for dir in glob(g:plug_dir . '/*', 0, 1)
    if index(l:wanted, fnamemodify(dir, ':t')) < 0
      echo 'Removing ' . fnamemodify(dir, ':t') . '...'
      call delete(dir, 'rf')
    endif
  endfor
  packloadall
  echo 'Done.'
endfunction

command! PlugSync call s:sync()
