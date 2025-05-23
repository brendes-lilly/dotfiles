" low.vim -- A calm colorscheme with low-key colors.
" Assumes a 24-bit color terminal or GUI vim.

if has("termguicolors")
	set termguicolors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

highlight clear
if exists("syntax on")
	syntax reset
endif

let g:colors_name = "low"

" https://github.com/tomasiser/vim-code-dark
function! <sid>hi(group, fg, bg, attr)
	if !empty(a:fg)
		exec "hi " . a:group . " guifg=" . a:fg.gui . " ctermfg=" .  a:fg.cterm256
	endif
	if !empty(a:bg)
		exec "hi " . a:group . " guibg=" . a:bg.gui . " ctermbg=" .  a:bg.cterm256
	endif
	if a:attr != ""
		exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
	endif
endfunction

" name  | class     | description
" ------+-----------+------------
" base0 | normal bg |
" base1 | faint  bg | cursorline, inactive ui, &c
" base2 | subtle bg | selection
" base3 | medium bg | active ui bg, nontext, line numbers, &c
" base4 | faint  fg | nontext, line numbers, &c
" base5 | subtle fg | comments, special
" base6 | normal fg |
" base7 | bold   fg |

let s:crow = {'gui': '#181818', 'cterm256':  '235'} " fg
let s:snow = {'gui': '#ffffff', 'cterm256':  '231'} " bg
let s:gray = {'gui': '#a8a8a8', 'cterm256':  '248'} " comment
let s:lith = {'gui': '#73809f', 'cterm256':  '103'} " keyword
let s:fawn = {'gui': '#af9078', 'cterm256':  '138'} " type
let s:foil = {'gui': '#646a78', 'cterm256':   '60'} " identifier
let s:plum = {'gui': '#8c5d7b', 'cterm256':   '96'} " function
let s:aqua = {'gui': '#5f8c7d', 'cterm256':   '66'} " constant
let s:leaf = {'gui': '#81895d', 'cterm256':   '65'} " string
let s:rind = {'gui': '#cdb298', 'cterm256':  '179'} " special
let s:corn = {'gui': '#eee0c2', 'cterm256':  '187'} " highlight
let s:cool = {'gui': '#bbbbff', 'cterm256':  '189'} " highlight alt

let s:base0    = s:snow
let s:base1    = {'gui': '#f4f4f4', 'cterm256':  '255'}
let s:base2    = {'gui': '#eeeeee', 'cterm256':  '255'}
let s:base3    = {'gui': '#e8e8e8', 'cterm256':  '254'}
let s:base4    = {'gui': '#d8d8d8', 'cterm256':  '253'}
let s:base5    = {'gui': '#b8b8b8', 'cterm256':  '249'}
let s:base6    = s:crow
let s:base7    = {'gui': '#000000', 'cterm256':   '16'}
let s:none     = {'gui': 'NONE',    'cterm256': 'NONE'}

let s:red1    = {'gui': '#cc6068', 'cterm256':  '167'}
let s:red2    = {'gui': '#ee8888', 'cterm256':  '174'}
let s:green1  = {'gui': '#839e78', 'cterm256':  '108'}
let s:green2  = {'gui': '#bbddaa', 'cterm256':  '151'}
let s:yellow1 = {'gui': '#bbaa77', 'cterm256':  '137'}
let s:yellow2 = {'gui': '#eeddaa', 'cterm256':  '186'}
let s:blue1   = {'gui': '#6688cc', 'cterm256':   '68'}
let s:blue2   = {'gui': '#aaccee', 'cterm256':  '153'}
let s:purple1 = {'gui': '#bb88cc', 'cterm256':  '140'}
let s:purple2 = {'gui': '#ccaadd', 'cterm256':  '183'}
let s:cyan1   = {'gui': '#87afaf', 'cterm256':  '109'}
let s:cyan2   = {'gui': '#bfe8df', 'cterm256':  '152'}

"     <sid>hi('GROUP',         FG,       BG,       'ATTR')
call  <sid>hi('Bold',          s:none,   s:none,   'bold')
call  <sid>hi('Comment',       s:gray,   s:none,   'none')
call  <sid>hi('Constant',      s:aqua,   s:none,   'none')
call  <sid>hi('Cursor',        s:none,   s:base0,  'none')
call  <sid>hi('CursorLine',    s:none,   s:base1,  'none')
call  <sid>hi('CursorLineNr',  s:none,   s:base1,  'none')
call  <sid>hi('DiffAdd',       s:leaf,   s:none,   'none')
call  <sid>hi('DiffChange',    s:lith,   s:none,   'none')
call  <sid>hi('DiffDelete',    s:plum,   s:none,   'none')
call  <sid>hi('Identifier',    s:plum,   s:none,   'none')
call  <sid>hi('LineNr',        s:base4,  s:none,   'none')
call  <sid>hi('Link',          s:lith,   s:none,   'underline')
call  <sid>hi('MatchParen',    s:none,   s:base2,  'none')
call  <sid>hi('NonText',       s:base3,  s:none,   'none')
call  <sid>hi('Normal',        s:base6,  s:base0,  'none')
call  <sid>hi('Pmenu',         s:base6,  s:base2,  'none')
call  <sid>hi('PmenuSel',      s:base0,  s:base5,  'none')
call  <sid>hi('PmenuSbar',     s:none,   s:base3,  'none')
call  <sid>hi('PmenuThumb',    s:none,   s:base4,  'none')
call  <sid>hi('PreProc',       s:lith,   s:none,   'none')
call  <sid>hi('IncSearch',     s:base7,  s:cool,   'none')
call  <sid>hi('Search',        s:base7,  s:corn,   'none')
call  <sid>hi('Special',       s:rind,   s:none,   'none')
call  <sid>hi('Statement',     s:lith,   s:none,   'none')
call  <sid>hi('StatusLine',    s:base7,  s:base3,  'none')
call  <sid>hi('StatusLineNC',  s:base5,  s:base1,  'none')
call  <sid>hi('String',        s:leaf,   s:none,   'none')
call  <sid>hi('TabLine',       s:base5,  s:base1,  'none')
call  <sid>hi('TabLineSel',    s:base7,  s:base3,  'none')
call  <sid>hi('Todo',          s:red1,   s:none,   'bold')
call  <sid>hi('Type',          s:fawn,   s:none,   'none')
call  <sid>hi('Underlined',    s:none,   s:none,   'underline')
call  <sid>hi('VertSplit',     s:base4,  s:none,   'none')
call  <sid>hi('Visual',        s:none,   s:base2,  'none')
call  <sid>hi('WildMenu',      s:none,   s:none,   'bold,reverse')

hi! link Delimiter             Comment
hi! link Directory             Normal
hi! link DiffText              Comment
hi! link Folded                Bold
hi! link helpHyperTextJump     Link
hi! link netrwSymLink          Normal
hi! link Number                Constant
hi! link SignColumn            Comment
hi! link SignifySignAdd        Comment
hi! link SignifySignChange     Comment
hi! link SignifySignDelete     Comment
hi! link SpecialKey            Special
hi! link StatusLineTerm        StatusLine
hi! link StatusLineTermNC      StatusLineNC
hi! link TabLineFill           TabLine
hi! link Title                 Bold
hi! link vimMapModKey          Constant
hi! link vimNotation           Constant
hi! link markdownCode          Constant
hi! link markdownCodeDelimiter markdownCode
hi! link markdownURL           Link
hi! link markdownLink          Link
hi! link markdownLinkText      Bold
hi! link markdownLinkDelimiter Normal
hi! link shCommandSub          Comment

let g:terminal_ansi_colors = [s:base5, s:red1, s:green1, s:yellow1, s:blue1,
			\ s:purple1, s:cyan1, s:base2, s:base5, s:red2, s:green2,
			\ s:yellow2, s:blue2, s:purple2, s:cyan2, s:snow]

" Test the actual colorscheme
syn match Comment      "\"__Comment.*"
syn match Constant     "\"__Constant.*"
syn match Cursor       "\"__Cursor.*"
syn match CursorLine   "\"__CursorLine.*"
syn match DiffAdd      "\"__DiffAdd.*"
syn match DiffChange   "\"__DiffChange.*"
syn match DiffText     "\"__DiffText.*"
syn match DiffDelete   "\"__DiffDelete.*"
syn match Folded       "\"__Folded.*"
syn match Function     "\"__Function.*"
syn match Identifier   "\"__Identifier.*"
syn match IncSearch    "\"__IncSearch.*"
syn match NonText      "\"__NonText.*"
syn match Normal       "\"__Normal.*"
syn match Pmenu        "\"__Pmenu.*"
syn match PreProc      "\"__PreProc.*"
syn match Search       "\"__Search.*"
syn match Special      "\"__Special.*"
syn match SpecialKey   "\"__SpecialKey.*"
syn match Statement    "\"__Statement.*"
syn match StatusLine   "\"__StatusLine.*"
syn match StatusLineNC "\"__StatusLineNC.*"
syn match String       "\"__String.*"
syn match Todo         "\"__Todo.*"
syn match Type         "\"__Type.*"
syn match Underlined   "\"__Underlined.*"
syn match VertSplit    "\"__VertSplit.*"
syn match Visual       "\"__Visual.*"

"__Comment              /* this is a comment */
"__Constant             var = SHBLAH
"__Cursor               char under the cursor?
"__CursorLine           Line where the cursor is
"__DiffAdd              +line added from file.orig
"__DiffChange           line changed from file.orig
"__DiffText             actual changes on this line
"__DiffDelete           -line removed from file.orig
"__Folded               +--- 1 line : Folded line ---
"__Function             function sblah()
"__Identifier           Never ran into that actually...
"__IncSearch            Next search term
"__NonText              This is not a text, move on
"__Normal               Typical text goes like this
"__Pmenu                Currently selected menu item
"__PreProc              #define SHBLAH true
"__Search               This is what you're searching for
"__Special              true false NULL SIGTERM
"__SpecialKey           Never ran into that either
"__Statement            if else return for switch
"__StatusLine           Statusline of current windows
"__StatusLineNC         Statusline of other windows
"__String               "Hello, World!"
"__Todo                 TODO: remove todos from source
"__Type                 int float char void unsigned uint32_t
"__Underlined           Anything underlined
"__VertSplit            :vsplit will only show ' | '
"__Visual               Selected text looks like this
"__DiffAdd
"__DiffChange
"__DiffDelete
"__DiffText
