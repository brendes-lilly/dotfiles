" function! CurrentGitStatus() abort
" 	let g:gitbranch = ''
" 	let g:gitmodmarker = ''
" 	if &buftype == ''
" 		let l:gitbranchoutput = systemlist("cd " . resolve(expand("%:p:h:S"))
" 					\ . " && git rev-parse --abbrev-ref HEAD 2>/dev/null")
" 		if len(l:gitbranchoutput) > 0
" 			let g:gitbranch = get(l:gitbranchoutput,0,"")
" 			let l:gitmodified = system("cd " . resolve(expand("%:p:h:S"))
" 						\ . " && git diff --name-only " . resolve(expand("%:p")) . " 2>/dev/null")
" 			if len(l:gitmodified) > 0
" 				let g:gitmodmarker = '+'
" 			endif
" 		endif
" 	endif
" endfunc

" augroup statusline_git_branch
" 	autocmd!
" 	autocmd WinEnter,WinLeave,BufEnter,BufWritePost * call CurrentGitStatus()
" augroup END

" set statusline+=\ %([%{g:gitbranch}%{g:gitmodmarker}]%)

" fun! SetupStl(nr)
"   return get(extend(w:, { "is_active": (winnr() == a:nr) }), "", "")
" endf

" fun! BuildStatusLine(nr)
"   return '%{SetupStl(' . a:nr . ')} %{w:["is_active"] ? "active" : "inactive"}'
" endf

" winnr() here is always the number of the *active* window
" set statusline=%!BuildStatusLine(winnr())
