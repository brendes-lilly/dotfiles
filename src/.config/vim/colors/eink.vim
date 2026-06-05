runtime colors/plain.vim
let g:colors_name = "eink"

if exists("g:eink") || !empty("$EINK")
  set background=light
  set t_Co=8
endif

hi! link CurSearch Underlined
hi! link Search Underlined
hi! link MatchParen UnderlinedSubtle
hi! link Visual Underlined
hi! link StatusLineNC Underlined
hi! link TabLineSel UnderlinedBold
hi! link PmenuSel Underlined
hi! link WildMenu UnderlinedSubtle
