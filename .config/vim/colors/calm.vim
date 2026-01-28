" calm.vim -- simple colorscheme for terminal vim with monochrome syntax

highlight clear
syntax reset
set notermguicolors
let g:colors_name = "calm"

" base
hi Normal ctermfg=none ctermbg=none cterm=none
hi Subtle ctermfg=none ctermbg=7 cterm=none
hi Bold ctermfg=none ctermbg=none cterm=bold
hi Dim ctermfg=8 ctermbg=none cterm=none
hi Faint ctermfg=7 ctermbg=none cterm=none
hi Inactive ctermfg=8 ctermbg=7 cterm=none
hi Italic ctermfg=none ctermbg=none cterm=italic
hi Standout ctermfg=8 ctermbg=none cterm=bold,reverse
hi Underlined ctermfg=8 ctermbg=none cterm=underline
hi VertSplit ctermfg=7 ctermbg=none cterm=none
hi ErrorMsg cterm=reverse ctermfg=1 ctermbg=none

" syntax
hi! link Comment Dim
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
hi! link markdownCode Dim
hi! link markdownCodeDelimiter markdownCode
hi! link markdownLink Link
hi! link markdownLinkDelimiter Normal
hi! link markdownLinkText Bold
hi! link markdownURL Link
hi! link scalaOperator Statement
hi! link scalaTypeTypePostDeclaration Normal
hi! link shCommandSub Normal
hi! link vimMapModKey Constant
hi! link vimNotation Constant
syn region shCommandSub matchgroup=String start="\$(" end=")" contains=NONE

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
hi! link CurSearch Standout
hi Search ctermfg=none ctermbg=7 cterm=underline
hi StatusLine ctermfg=none ctermbg=7 cterm=none
hi StatusLineNC ctermfg=8 ctermbg=7 cterm=none
hi TabLineSel ctermfg=none ctermbg=7 cterm=underline
hi Todo ctermfg=none ctermbg=none cterm=bold,underline
hi WarningMsg ctermfg=1 ctermbg=none cterm=none

hi! link qfFileName Normal
hi! link CocFloating Subtle
hi! link CocSearch Search
hi! link ColorColumn Subtle
hi! link CursorLine Subtle
hi! link CursorLineFold Inactive
hi! link CursorLineNr Normal
hi! link DiagnosticSignWarn WarningMsg
hi! link DiagnosticWarn Normal
hi! link DiagnosticHint Normal
hi! link DiagnosticInfo Normal
hi! link DiffText Dim
hi! link Directory Normal
hi! link EndOfBuffer Faint
hi! link Folded Bold
hi! link IncSearch Standout
hi! link LineNr Faint
hi! link MatchParen Standout
hi! link ModeMsg Normal
hi! link MoreMsg Dim
hi! link NeoTreeCursorLine CursorLine
hi! link NeoTreeIndentMarker Faint
hi! link Pmenu Subtle
hi! link PmenuSbar Subtle
hi! link PmenuSel Standout
hi! link PmenuThumb Standout
hi! link QuickFixLine Normal
hi! link SignColumn Dim
hi! link SignifySignAdd Dim
hi! link SignifySignChange Dim
hi! link SignifySignDelete Dim
hi! link SpellBad Error
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link TabLine Underlined
hi! link TabLineFill TabLine
hi! link Title Bold
hi! link Visual Subtle
hi! link helpHyperTextJump Underlined
hi! link helpOption Dim
hi! link htmlBold Bold
hi! link netrwSymLink Normal
hi! link WildMenu Standout
hi! link WinSeparator VertSplit
