runtime colors/chernila.vim
let g:colors_name = "calm"

" ui
hi Error ctermfg=1 ctermbg=none cterm=underline
hi NonText ctermfg=1 ctermbg=none cterm=none
hi SpellCap ctermfg=4 ctermbg=none cterm=underline
hi SpellLocal ctermfg=6 ctermbg=none cterm=underline
hi SpellRare ctermfg=5 ctermbg=none cterm=underline
hi DiffAdd ctermfg=6 ctermbg=none cterm=bold
hi DiffChange ctermfg=3 ctermbg=none cterm=bold
hi DiffDelete ctermfg=1 ctermbg=none cterm=bold
hi Question ctermfg=2 ctermbg=none cterm=none
hi TabLine cterm=underline ctermfg=8 ctermbg=7
hi TabLineFill cterm=underline ctermfg=none ctermbg=7
hi WarningMsg ctermfg=1 ctermbg=none cterm=none

hi! link TabLineSel Underlined

hi! link CurSearch Standout
hi! link CursorLineFold Inactive
hi! link IncSearch Standout
hi! link LineNr Faint
hi! link MatchParen Standout

hi! link Pmenu Subtle
hi! link PmenuBorder Normal
hi! link PmenuSbar Subtle
hi! link PmenuSel Standout
hi! link PmenuThumb Standout

hi! link SpellBad Error
hi! link StatusLine Subtle
hi! link StatusLineNC Inactive
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link TabPanel Normal
hi! link TabPanelFill Normal
hi! link TabPanelSel Subtle
hi! link Visual Subtle
hi! link WildMenu Standout

" syntax
hi! link Comment Dim
hi! link SpecialComment Dim
hi! link SpecialKey Dim
hi! link markdownCode Dim
hi! link markdownLinkDelimiter Normal
hi! link markdownLinkText Bold

" nvim/other
hi! link DiagnosticSignWarn WarningMsg
hi! link NeoTreeCursorLine CursorLine
hi! link NeoTreeIndentMarker Faint
