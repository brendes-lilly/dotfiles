setlocal tabstop=4

augroup gofmt
	autocmd!
	autocmd BufWritePost <buffer> silent! !gofmt -w %
augroup END

imap <buffer> () ()<esc>i
imap <buffer> { {<cr>}<esc>O
