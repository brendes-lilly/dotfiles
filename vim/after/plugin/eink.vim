" settings for e-ink displays

function! Boox()
  if exists('$ANDROID_ROOT') || exists('$ANDROID_DATA')
    return 1
  endif

  if executable('getprop')
    let l:brand = system('getprop ro.product.brand')
    let l:model = system('getprop ro.product.model')
    if l:brand =~? 'onyx' || l:model =~? 'noteair'
      return 1
    endif
  endif

  return 0
endfunction

if Boox()
  " move these to a termux-detecting plugin later
  let g:netrw_browsex_viewer = "termux-open"
  vnoremap ; y:call system("termux-clipboard-set", @")<CR>

  colorscheme calm
  set background=light
  set t_Co=8
  set lazyredraw
  set ttyfast
  set synmaxcol=200
  " set updatetime=300
  " set notimeout
  " set ttimeout
  " set ttimeoutlen=10
  set nocursorline
  set nocursorcolumn
  " set noincsearch
  set noruler
  set t_ut=
  " set t_ti= t_te=
  augroup colorOverrides
    autocmd ColorScheme * hi CurSearch ctermfg=none ctermbg=none cterm=reverse,underline
  augroup END
endif
