" b.vim -- colored syntax theme for terminal vim that is background-agnostic
"
" a 256-color terminal is recommended for a palette of subtle, but
" distinguishable colors. the theme will fall back to the terminal's 16-color
" palette if the terminal isn't capable of 256 colors.

if has("termguicolors")
    set notermguicolors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

highlight clear
if exists("syntax on")
	syntax reset
endif

let g:colors_name = "b"

" base
hi  Normal      ctermfg=none  ctermbg=none  cterm=none
hi  Shadow      ctermfg=8     ctermbg=none  cterm=none
hi  Faint       ctermfg=7     ctermbg=none  cterm=none
hi  Active      ctermfg=none  ctermbg=7     cterm=none
hi  Inactive    ctermfg=8     ctermbg=7     cterm=none
hi  Standout    ctermfg=15    ctermbg=8     cterm=none
hi  Bold        ctermfg=none  ctermbg=none  cterm=bold
hi  Underlined  ctermfg=4     ctermbg=none  cterm=underline

" ui
hi  DiffAdd            ctermfg=2     ctermbg=none  cterm=none
hi  DiffChange         ctermfg=3     ctermbg=none  cterm=none
hi  DiffDelete         ctermfg=1     ctermbg=none  cterm=none
hi  MatchParen         ctermfg=none  ctermbg=7     cterm=none
hi  Question           ctermfg=6     ctermbg=none  cterm=none
hi  IncSearch          ctermfg=none  ctermbg=7     cterm=none
hi  Search             ctermfg=0     ctermbg=11    cterm=none
hi  SpellCap           ctermfg=4     ctermbg=none  cterm=underline
hi  SpellLocal         ctermfg=6     ctermbg=none  cterm=underline
hi  SpellRare          ctermfg=5     ctermbg=none  cterm=underline
hi  WarningMsg         ctermfg=1     ctermbg=none  cterm=none
hi  SignifySignAdd     ctermfg=2     ctermbg=none  cterm=none
hi  SignifySignChange  ctermfg=4     ctermbg=none  cterm=none
hi  SignifySignDelete  ctermfg=1     ctermbg=none  cterm=none

" syntax
hi  Boolean         ctermfg=5    ctermbg=none  cterm=none
hi  Constant        ctermfg=5    ctermbg=none  cterm=none
hi  Error           ctermfg=1    ctermbg=none  cterm=underline
hi  Identifier      ctermfg=4    ctermbg=none  cterm=none
hi  NonText         ctermfg=210  ctermbg=none  cterm=bold
hi  Number          ctermfg=5    ctermbg=none  cterm=none
hi  Special         ctermfg=8    ctermbg=none  cterm=none
hi  SpecialChar     ctermfg=3    ctermbg=none  cterm=none
hi  SpecialComment  ctermfg=8    ctermbg=none  cterm=none
hi  Statement       ctermfg=none ctermbg=none  cterm=none
hi  String          ctermfg=6    ctermbg=none  cterm=none
hi  Todo            ctermfg=1    ctermbg=none  cterm=bold,underline
hi  Type            ctermfg=4    ctermbg=none  cterm=none
hi  markdownH1      ctermfg=none ctermbg=none  cterm=bold

hi!  link  Comment         Shadow
hi!  link  Delimiter       Shadow
hi!  link  PreProc         Statement
hi!  link  SpecialComment  Shadow
hi!  link  SpecialKey      Special
hi!  link  Tag             Constant
hi!  link  Debug           Function

hi!  link  CocFloating            Active
hi!  link  CocSearch              Search
hi!  link  ColorColumn            Active
hi!  link  CursorLineFold         Inactive
hi!  link  CursorLineNr           Shadow
hi!  link  DiffText               Shadow
hi!  link  Directory              Normal
hi!  link  EndOfBuffer            Faint
hi!  link  Folded                 Shadow
hi!  link  LineNr                 Faint
hi!  link  MatchParen             Active
hi!  link  MoreMsg                Shadow
hi!  link  netrwClassify          Constant
hi!  link  Pmenu                  Active
hi!  link  PmenuSbar              Active
hi!  link  PmenuSel               Standout
hi!  link  PmenuThumb             Standout
hi!  link  SignColumn             Shadow
hi!  link  SpellBad               Error
hi!  link  StatusLine             Active
hi!  link  StatusLineNC           Inactive
hi!  link  StatusLineTerm         StatusLine
hi!  link  StatusLineTermNC       StatusLineNC
hi!  link  TabLine                Inactive
hi!  link  TabLineFill            TabLine
hi!  link  TabLineSel             Active
hi!  link  Title                  Bold
hi!  link  VertSplit              Faint
hi!  link  Visual                 Active
hi!  link  WildMenu               Standout
hi!  link  WinSeparator           Faint
hi!  link  helpHyperTextJump      Underlined
hi!  link  helpOption             Shadow
hi!  link  htmlBold               Bold
hi!  link  markdownCode           Constant
hi!  link  markdownCodeDelimiter  markdownCode
hi!  link  markdownH1Delimiter    markdownH1
hi!  link  markdownH2             markdownH1
hi!  link  markdownH2Delimiter    markdownH2
hi!  link  markdownH3             markdownH1
hi!  link  markdownH3Delimiter    markdownH3
hi!  link  markdownH4             markdownH1
hi!  link  markdownH4Delimiter    markdownH4
hi!  link  markdownLink           Underlined
hi!  link  markdownLinkDelimiter  Normal
hi!  link  markdownLinkText       Bold
hi!  link  markdownURL            Underlined
hi!  link  netrwSymLink           Normal
hi!  link  shCommandSub           Normal
hi!  link  vimMapModKey           Constant
hi!  link  vimNotation            Constant
