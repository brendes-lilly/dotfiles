function! ToggleBg()
  if &background ==# 'light'
    set background=dark
  else
    set background=light
  endif
endfunction
nnoremap <leader>b :call ToggleBg()<cr>

augroup ColorschemeOverrides
  autocmd!
  autocmd ColorScheme * hi! link hoonArm Identifier
  autocmd ColorScheme * hi! link hoonAtomType Type
  autocmd ColorScheme * hi! link hoonCubeType Type
  autocmd ColorScheme * hi! link hoonNumber Number
  autocmd ColorScheme * hi! link scalaCapitalWord Type
  autocmd ColorScheme * hi! link scalaInstanceDeclaration Identifier
  autocmd ColorScheme * hi! link scalaSpecial Normal
  autocmd ColorScheme nord set termguicolors
  autocmd ColorScheme nord hi! Comment guifg=#72809a
  autocmd ColorScheme nord hi! Question ctermfg=2
augroup END

