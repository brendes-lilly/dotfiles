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
  autocmd ColorScheme nord set termguicolors
  autocmd ColorScheme nord hi! Comment guifg=#72809a
  autocmd ColorScheme nord hi! Question ctermfg=2
augroup END

