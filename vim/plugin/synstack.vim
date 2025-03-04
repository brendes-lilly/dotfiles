" print the name of the highlight group of the object under the cursor
function! SynStack() abort
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

command! SynStack call SynStack()
