vim.uv = vim.uv or vim.loop

local vimrc = vim.fn.expand('~/.config/vim/vimrc')
local vimdir = vim.fn.fnamemodify(vimrc, ':h')
local opt = vim.opt

opt.runtimepath:prepend(vimdir)
opt.runtimepath:append(vimdir .. '/after')
vim.o.packpath = vim.o.runtimepath
vim.cmd.source(vimrc)

opt.winborder = 'single'

-- this should be fixed soon
if vim.env.TERM_PROGRAM == 'WezTerm' then
  opt.termsync = false
end

