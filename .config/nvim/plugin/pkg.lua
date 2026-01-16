local M = {}

local core = {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mhinz/vim-signify',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/chrisbra/Colorizer',
  'https://github.com/urbit/hoon.vim',
  'https://github.com/f-person/auto-dark-mode.nvim',
}

local neotree = {
  'https://github.com/nvim-neo-tree/neo-tree.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

M.packages = vim.iter({
  core,
  neotree,
}):flatten():totable()

local startdir = vim.fn.stdpath('data') .. '/site/pack/plugins/start'

local function name(url)
  return url:match('.*/(.+)$'):gsub('%.git$', '')
end

function M.install()
  vim.fn.mkdir(startdir, 'p')
  for _, url in ipairs(M.packages) do
    local dir = startdir .. '/' .. name(url)
    if vim.fn.isdirectory(dir) == 0 then
      print('Installing ' .. name(url))
      vim.fn.system{'git', 'clone', url, dir}
    end
  end
  vim.cmd('helptags ALL')
  print('Done')
end

function M.update()
  for _, url in ipairs(M.packages) do
    local dir = startdir .. '/' .. name(url)
    if vim.fn.isdirectory(dir .. '/.git') == 1 then
      print('Updating ' .. name(url))
      vim.fn.system{'git', '-C', dir, 'pull', '--ff-only'}
    end
  end
  vim.cmd('helptags ALL')
  print('Done')
end

function M.remove()
  local installed = vim.fn.glob(startdir .. '/*', false, true)
  local wanted = {}
  for _, url in ipairs(M.packages) do
    wanted[name(url)] = true
  end
  for _, dir in ipairs(installed) do
    local n = vim.fn.fnamemodify(dir, ':t')
    if not wanted[n] then
      print('Removing ' .. n)
      vim.fn.delete(dir, 'rf')
    end
  end
  print('Done')
end

local cmd = vim.api.nvim_create_user_command
cmd('PackInstall', M.install, {})
cmd('PackUpdate', M.update, {})
cmd('PackRemove', M.remove, {})

return M

