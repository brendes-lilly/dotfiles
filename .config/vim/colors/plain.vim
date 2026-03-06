set notermguicolors
highlight clear
syntax reset
let g:colors_name = "plain"

" base
hi Normal ctermfg=none ctermbg=none cterm=none
hi Underlined ctermfg=none ctermbg=none cterm=underline
hi default Subtle ctermfg=none ctermbg=7 cterm=none
hi default Bold ctermfg=none ctermbg=none cterm=bold
hi default Dim ctermfg=8 ctermbg=none cterm=none
hi default Faint ctermfg=7 ctermbg=none cterm=bold
hi default Italic ctermfg=none ctermbg=none cterm=italic
hi default Inactive ctermfg=8 ctermbg=7 cterm=none
hi default Reverse term=reverse ctermfg=none ctermbg=none cterm=reverse
hi default Standout ctermfg=8 ctermbg=none cterm=bold,reverse
hi default Underlined ctermfg=none ctermbg=none cterm=underline
hi default UnderlinedBold ctermfg=none ctermbg=none cterm=underline,bold
hi default UnderlinedDim ctermfg=8 ctermbg=none cterm=underline
hi default UnderlinedSubtle ctermfg=none ctermbg=7 cterm=underline

" ui
hi Todo ctermfg=none ctermbg=none cterm=bold,underline
hi VertSplit ctermfg=none ctermbg=none cterm=none
hi! link ColorColumn Subtle
hi! link CurSearch Reverse
hi! link CursorLine Underlined
hi! link CursorLineFold Dim
hi! link CursorLineNr Normal
hi! link DiffAdd Normal
hi! link DiffChange Normal
hi! link DiffDelete Normal
hi! link DiffText Dim
hi! link Directory Normal
hi! link EndOfBuffer Normal
hi! link Error Normal
hi! link ErrorMsg Reverse
hi! link Folded Bold
hi! link helpHyperTextJump Underlined
hi! link helpOption Underlined
hi! link htmlBold Bold
hi! link IncSearch Standout
hi! link LineNr Dim
hi! link MatchParen UnderlinedSubtle
hi! link ModeMsg Normal
hi! link MoreMsg Bold
hi! link netrwSymLink Normal
hi! link NonText Bold
hi! link Pmenu Normal
hi! link PmenuBorder Normal
hi! link PmenuSbar Normal
hi! link PmenuSel Reverse
hi! link PmenuSel Subtle
hi! link PmenuThumb Standout
hi! link qfFileName Normal
hi! link Question Normal
hi! link QuickFixLine Normal
hi! link Search UnderlinedSubtle
hi! link SignColumn Normal
hi! link SpellBad Error
hi! link SpellCap Underlined
hi! link SpellLocal Underlined
hi! link SpellRare Underlined
hi! link StatusLine Underlined
hi! link StatusLineNC UnderlinedDim
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link TabLine UnderlinedDim
hi! link TabLineFill TabLine
hi! link TabLineSel Underlined
hi! link TabPanel Normal
hi! link TabPanelFill Normal
hi! link Title Bold
hi! link Visual Subtle
hi! link WarningMsg Normal
hi! link WildMenu Underlined

" syntax
hi! link Comment Normal
hi! link Constant Normal
hi! link Function Normal
hi! link Identifier Normal
hi! link Number Normal
hi! link PreProc Normal
hi! link Special Normal
hi! link SpecialChar Normal
hi! link SpecialComment Normal
hi! link SpecialKey Underlined
hi! link Statement Normal
hi! link String Normal
hi! link Type Normal
hi! link markdownCode Normal
hi! link markdownCodeDelimiter markdownCode
hi! link markdownLink Link
hi! link markdownLinkDelimiter Normal
hi! link markdownLinkText Bold
hi! link markdownURL Link
hi! link shCommandSub Normal
hi! link vimMapModKey Constant
hi! link vimNotation Constant
syn region shCommandSub matchgroup=String start="\$(" end=")" contains=NONE

" nvim
hi! link DiagnosticSignWarn WarningMsg
hi! link DiagnosticWarn Normal
hi! link DiagnosticHint Normal
hi! link DiagnosticInfo Normal
hi! link WinSeparator VertSplit

" external
hi! link NeoTreeCursorLine CursorLine
hi! link NeoTreeIndentMarker Dim
hi! link SignifySignAdd Dim
hi! link SignifySignChange Dim
hi! link SignifySignDelete Dim
hi! link scalaOperator Statement
hi! link scalaTypeTypePostDeclaration Normal

