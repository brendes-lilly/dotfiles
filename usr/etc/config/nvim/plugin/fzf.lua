require("fzf-lua").setup(
  {
    defaults = {
      file_icons = false,
    },
    winopts = {
      preview = {
        hidden = 'hidden',
      },
    },
    color_icons = false,
    buffers = {
      prompt = 'Buffers: ',
      ignore_current_buffer = true,
      sort_lastused = true
    },
    files = { prompt = 'Files: ' },
    grep = {
      prompt = 'Rg: ',
      input_prompt = 'Grep for: '
    },
    fzf_layout = 'minimal',
  }
)

local map = vim.keymap.set

