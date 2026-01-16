highlight clear
syntax reset
set notermguicolors
set t_Co=8
let g:colors_name = "eink"

" base
hi Normal ctermfg=none ctermbg=none cterm=none
hi Subtle ctermfg=none ctermbg=7 cterm=none
hi Bold ctermfg=none ctermbg=none cterm=bold
hi Dim ctermfg=8 ctermbg=none cterm=none
hi Italic ctermfg=none ctermbg=none cterm=italic
hi Standout ctermfg=8 ctermbg=none cterm=bold,reverse
hi Underline ctermfg=none ctermbg=none cterm=underline
hi UnderlineDim ctermfg=8 ctermbg=none cterm=underline
hi UnderlineBold ctermfg=none ctermbg=none cterm=underline,bold

" syntax
hi! link Comment Normal
hi! link Constant Normal
hi! link Function Normal
hi! link Identifier Normal
hi! link Number Normal
hi! link PreProc Normal
hi! link Special Normal
hi! link SpecialChar Normal
hi! link SpecialComment Dim
hi! link SpecialKey Dim
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

" ui
hi Todo ctermfg=none ctermbg=none cterm=bold,underline
hi VertSplit ctermfg=none ctermbg=none cterm=none
hi! link ColorColumn Subtle
hi! link CurSearch Underline
hi! link CursorLine Underline
hi! link CursorLineFold Dim
hi! link CursorLineNr Normal
hi! link DiffAdd Normal
hi! link DiffChange Normal
hi! link DiffDelete Normal
hi! link DiffText Dim
hi! link Directory Normal
hi! link EndOfBuffer Dim
hi! link Error Normal
hi! link Folded Bold
hi! link IncSearch Standout
hi! link LineNr Dim
hi! link MatchParen Underline
hi! link ModeMsg Normal
hi! link MoreMsg Dim
hi! link NonText Dim
hi! link Pmenu Subtle
hi! link PmenuSbar Subtle
hi! link PmenuSel Standout
hi! link PmenuThumb Standout
hi! link Question Normal
hi! link QuickFixLine Normal
hi! link Search Underline
hi! link SignColumn Dim
hi! link SpellBad Error
hi! link SpellCap Underline
hi! link SpellLocal Underline
hi! link SpellRare Underline
hi! link StatusLine Underline
hi! link StatusLineNC Underline
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link TabLine Underlined
hi! link TabLineFill TabLine
hi! link TabLineSel Underline
hi! link Title Bold
" hi! link Visual Subtle
hi! link Visual Underlined
hi! link WarningMsg Normal
hi! link WildMenu Subtle
hi! link helpHyperTextJump Underlined
hi! link helpOption Dim
hi! link htmlBold Bold
hi! link netrwSymLink Normal
hi! link qfFileName Normal

" nvim only
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
