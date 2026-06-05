local augroup = vim.api.nvim_create_augroup("config", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

vim.opt.signcolumn = 'auto:1-2'

vim.lsp.enable({
  'gopls',
  'lua_ls',
  'pyright',
})

autocmd('LspAttach', {
  group = augroup,
  callback = function(ev)
    local map = vim.keymap.set
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    map('n', 'grd', vim.lsp.buf.definition, bufopts)
    map('i', '<C-k>', vim.lsp.completion.get, bufopts)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local methods = vim.lsp.protocol.Methods
    if client:supports_method(methods.textDocument_completion) then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

