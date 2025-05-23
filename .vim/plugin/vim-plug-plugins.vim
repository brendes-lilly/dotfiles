" if empty(glob('~/.vim/autoload/plug.vim'))
"   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | runtime $MYVIMRC
" endif
" call plug#begin('~/.vim/plug')
" Plug 'urbit/hoon.vim'
" Plug 'arcticicestudio/nord-vim'
" Plug 'chrisbra/Colorizer'
" Plug 'neovim/nvim-lspconfig'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" call plug#end()

" if has('nvim')
"   lua << EOF
"   require'lspconfig'.hoon_ls.setup{
"     cmd = { "hoon-language-server", "-p", "8080" },
"     filetypes = { "hoon" },
"     single_file_support = true
"   }
" EOF
" endif
