" acme.vim -- A minimal colorscheme inspired by the Acme editor
" If in terminal, assumes true color capabilities and a light background

set guioptions-=elL
set background=light

if has("termguicolors")
	set termguicolors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if exists("syntax on")
	highlight clear
	syntax reset
endif

let g:colors_name = "acme"

let  s:black1   =  "#000000"
let  s:black2   =  "#999990"
let  s:white1   =  "#e1e1ce"
let  s:white2   =  "#ebebd7"
let  s:white3   =  "#ffffff"
let  s:red1     =  "#bb5d5d"
let  s:red2     =  "#ff8888"
let  s:green1   =  "#448844"
let  s:green2   =  "#88cc88"
let  s:green3   =  "#e4f8e4"
let  s:green4   =  "#eaffea"
let  s:blue1    =  "#4466bb"
let  s:blue2    =  "#bbddee"
let  s:yellow1  =  "#99884c"
let  s:yellow2  =  "#eeee9e"
let  s:yellow3  =  "#ffffea"
let  s:purple1  =  "#aa77aa"
let  s:purple2  =  "#8888cc"
let  s:cyan1    =  "#55aaaa"
let  s:cyan2    =  "#aeeeee"
let  s:cyan3    =  "#eaffff"

let s:bg1 = s:yellow3
let s:bg2 = s:white1
let s:bg3 = "#f2f2dd"
let s:fg1 = s:black1
let s:fg2 = s:black2

exe 'hi Normal ctermfg=none ctermbg=none guifg='.s:fg1.' guibg='.s:bg1.' '
exe 'hi Error cterm=bold ctermfg=1 ctermbg=none '
exe 'hi CursorLine ctermfg=none ctermbg=none cterm=none guifg=none guibg='.s:bg3.' gui=none '
exe 'hi Constant cterm=none ctermfg=none gui=none guifg='.s:fg1.' '
exe 'hi Comment cterm=none ctermfg=8 guifg='.s:fg2.' '
exe 'hi DiffAdd ctermfg=2 ctermbg=none guifg='.s:green1.' guibg=none '
exe 'hi DiffChange ctermfg=5 ctermbg=none guifg='.s:blue1.' guibg=none '
exe 'hi DiffDelete ctermfg=1 ctermbg=none guifg='.s:red1.' guibg=none '
exe 'hi Folded term=standout cterm=bold ctermfg=none ctermbg=none gui=bold guifg=none guibg=none'
exe 'hi Link cterm=underline ctermfg=4 gui=underline guifg='.s:blue1.' '
exe 'hi LineNr cterm=none ctermfg=7 gui=none guifg='.s:bg2.' '
exe 'hi MatchParen ctermbg=7 guibg='.s:bg2.' '
exe 'hi Pmenu ctermbg=194 guibg='.s:green3.' '
exe 'hi PmenuSel ctermfg=194 ctermbg=71 guifg='.s:green3.' guibg='.s:green1.' '
exe 'hi PmenuSbar ctermbg=114 guibg='.s:green2.' '
exe 'hi PmenuThumb ctermbg=71 guibg='.s:green1.' '
exe 'hi CurSearch ctermfg=0 ctermbg=yellow cterm=underline guifg=fg guibg='.s:yellow2.' gui=underline'
exe 'hi IncSearch ctermfg=0 ctermbg=magenta guifg='.s:white3.' guibg='.s:purple2.' gui=none '
exe 'hi Search ctermfg=0 ctermbg=yellow guifg=fg guibg='.s:yellow2.' '
exe 'hi Special cterm=none ctermfg=none gui=none guifg='.s:fg1.' '
exe 'hi StatusLine cterm=bold,underline ctermbg=195 gui=bold,underline guifg=none guibg='.s:cyan3.' '
exe 'hi StatusLineNC cterm=underline ctermbg=195 gui=underline guifg=none guibg='.s:cyan3.' '
exe 'hi String cterm=none ctermfg=none guifg='.s:fg1.' '
exe 'hi TabLineSel cterm=bold,underline ctermbg=116 gui=bold,underline guibg='.s:cyan2.' '
exe 'hi Todo ctermfg=0 ctermbg=yellow cterm=bold,underline guifg=black guibg='.s:yellow2.' gui=bold,underline '
exe 'hi VertSplit cterm=none ctermfg=195 ctermbg=195 gui=none guifg='.s:fg1.' guibg=none '
exe 'hi Visual ctermfg=0 ctermbg=11 guifg='.s:fg1.' guibg='.s:yellow2.' '

hi Underlined cterm=underline ctermfg=none gui=underline guifg=none
hi Title cterm=bold ctermfg=none ctermbg=none gui=bold guifg=none
hi link markdownCodeDelimiter markdownCode
hi markdownLinkText cterm=bold ctermfg=none gui=bold guifg=none

hi! link Delimiter Constant
hi! link Directory Normal
hi! link DiffText Comment
hi! link helpHyperTextJump Link
hi! link Identifier Normal
hi! link NonText Comment
hi! link PreProc Normal
hi! link SignColumn Comment
hi! link SignifySignAdd Comment
hi! link SignifySignChange Comment
hi! link SignifySignDelete Comment
hi! link Statement Normal
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link TabLine StatusLineNC
hi! link TabLineFill StatusLineNC
hi! link Type Normal
hi! link vimMapModKey Constant
hi! link vimNotation Constant
hi! link markdownURL Link

let g:terminal_ansi_colors = [s:black1, s:red1, s:green1, s:yellow1, s:blue1,
			\ s:purple1, s:cyan1, s:white2, s:black2, s:red2, s:green2,
			\ s:yellow2, s:blue2, s:purple2, s:cyan2, s:white3]
