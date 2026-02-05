" acmevim -- A minimal colorscheme inspired by the Acme editor
" 'termguicolors' required

if !exists('v:colornames')
	finish
endif

set background=light
set guioptions-=elL
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
highlight clear
syntax reset
let g:colors_name = "acme"

call extend(v:colornames, {
            \ 'acme_black1': '#000000',
            \ 'acme_black2': '#888880',
            \ 'acme_white1': '#e1e1ce',
            \ 'acme_white2': '#ebebd7',
            \ 'acme_white3': '#ffffff',
            \ 'acme_red1': '#bb5d5d',
            \ 'acme_red2': '#ff8888',
            \ 'acme_green1': '#448844',
            \ 'acme_green2': '#88cc88',
            \ 'acme_green3': '#e4f8e4',
            \ 'acme_green4': '#eaffea',
            \ 'acme_blue1': '#4466bb',
            \ 'acme_blue2': '#bbddee',
            \ 'acme_yellow1': '#99884c',
            \ 'acme_yellow2': '#eeee9e',
            \ 'acme_yellow3': '#ffffea',
            \ 'acme_purple1': '#aa77aa',
            \ 'acme_purple2': '#8888cc',
            \ 'acme_cyan1': '#55aaaa',
            \ 'acme_cyan2': '#aeeeee',
            \ 'acme_cyan3': '#eaffff',
            \ 'acme_shadow_ui': '#808888',
            \ })

hi Normal cterm=none gui=none guifg=acme_black1 guibg=acme_yellow3
hi Cleared cterm=none gui=none guifg=fg guibg=bg

hi Dim cterm=none gui=none guifg=acme_black2
hi Fade cterm=none gui=none guifg=acme_white2

hi DiffAdd cterm=none gui=none guifg=acme_green1 guibg=bg
hi DiffChange cterm=none gui=none guifg=acme_blue1 guibg=bg
hi DiffDelete cterm=none gui=none guifg=acme_red1 guibg=bg
hi Error cterm=none guifg=acme_red1 guibg=bg gui=none
hi Link cterm=underline gui=underline guifg=acme_blue1
hi MatchParen cterm=none gui=none guibg=acme_white2
hi Pmenu cterm=none gui=none guibg=acme_green3
hi PmenuBorder cterm=none gui=none guifg=acme_green1 guibg=acme_green3
hi PmenuSbar cterm=none gui=none guibg=acme_green2
hi PmenuSel cterm=none gui=none guifg=acme_green3 guibg=acme_green1
hi PmenuThumb cterm=none gui=none guibg=acme_green1
hi StatusLine cterm=underline gui=underline guifg=fg guibg=acme_cyan3
hi StatusLineNC cterm=underline gui=underline guifg=acme_shadow_ui guibg=acme_cyan3
hi Todo cterm=bold,underline gui=bold,underline guifg=fg guibg=bg
hi Underlined cterm=underline gui=underline guifg=fg
hi Visual cterm=none gui=none guifg=fg guibg=acme_yellow2
hi WildMenu cterm=underline gui=underline guifg=fg guibg=acme_cyan2

hi CurSearch cterm=underline gui=underline guifg=fg guibg=acme_yellow2
hi IncSearch cterm=none gui=none guifg=acme_white3 guibg=acme_purple2
hi Search cterm=none gui=none guifg=fg guibg=acme_yellow2

hi! link EndOfBuffer Fade
hi! link VertSplit Normal
hi! link CursorLine Underlined
hi! link DiffText Dim
hi! link Title Bold
hi! link Directory Normal
hi! link LineNr Fade
hi! link Folded Normal
hi! link helpHyperTextJump Underlined
hi! link NonText Dim
hi! link SignColumn Dim
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link TabLine StatusLineNC
hi! link TabLineFill StatusLine
hi! link TabLineSel StatusLine
hi! link vimMapModKey Normal
hi! link vimNotation Normal

hi! link Comment Dim
hi! link Constant Normal
hi! link Special Normal
hi! link Statement Normal
hi! link String Normal
hi! link Identifier Normal
hi! link PreProc Normal
hi! link Delimiter Normal
hi! link Type Normal
hi! link Function Normal


" nvim/third party
hi! link markdownURL Link
hi! link markdownCode Normal
hi! link markdownCodeDelimiter markdownCode
hi! link markdownLinkText Normal
hi! link NeoTreeCursorLine CursorLine
hi! link NeoTreeFileIcon Cleared
hi! link NeoTreeRootName Normal
hi! link SignifySignAdd Comment
hi! link SignifySignChange Comment
hi! link SignifySignDelete Comment

let g:terminal_ansi_colors = [
            \ v:colornames['acme_black1'],
            \ v:colornames['acme_red1'],
            \ v:colornames['acme_green1'],
            \ v:colornames['acme_yellow1'],
            \ v:colornames['acme_blue1'],
            \ v:colornames['acme_purple1'],
            \ v:colornames['acme_cyan1'],
            \ v:colornames['acme_white2'],
            \ v:colornames['acme_black2'],
            \ v:colornames['acme_red2'],
            \ v:colornames['acme_green2'],
            \ v:colornames['acme_yellow2'],
            \ v:colornames['acme_blue2'],
            \ v:colornames['acme_purple2'],
            \ v:colornames['acme_cyan2'],
            \ v:colornames['acme_white3'],
            \ ]
