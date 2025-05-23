" if has('nvim')
"   lua << EOF
"   require'lspconfig'.hoon_ls.setup{
"     cmd = { "hoon-language-server", "-p", "8080" },
"     filetypes = { "hoon" },
"     single_file_support = true
"   }
" EOF
" endif
