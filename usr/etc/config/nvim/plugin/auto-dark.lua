if not vim.env.CODESPACES then
  local ok_adm, auto_dark_mode = pcall(require, 'auto-dark-mode')
  if ok_adm then
    auto_dark_mode.setup{
      update_interval = 1000,
      set_dark_mode = function() vim.opt.background = 'dark' end,
      set_light_mode = function() vim.opt.background = 'light' end,
    }
    auto_dark_mode.init()
  end
end

