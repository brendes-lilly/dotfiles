vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 0,
  files = 0,
  folder_arrows = 0,
}

require('neo-tree').setup({
  close_if_last_window = false,
  popup_border_style = "",
  clipboard = {
    sync = "none",
  },
  enable_git_status = true,
  enable_diagnostics = true,
  open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
  open_files_using_relative_paths = false,
  sort_case_insensitive = false,
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      indent_size = 2,
      padding = 0,
      with_markers = true,
      last_indent_marker = "└",
      indent_marker = "│",
      highlight = "NeoTreeIndentMarker",
      with_expanders = nil,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = " ",
      -- provider = function(icon, node, state)
      --   if node.type == "file" or node.type == "terminal" then
      --     local success, web_devicons = pcall(require, "nvim-web-devicons")
      --     local name = node.type == "terminal" and "terminal" or node.name
      --     if success then
      --       local devicon, hl = web_devicons.get_icon(name)
      --       icon.text = devicon or icon.text
      --       icon.highlight = hl or icon.highlight
      --     end
      --   end
      -- end,
      -- default = "*",
      default = " ",
      highlight = "NeoTreeFileIcon",
      use_filtered_colors = false,
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = true,
      use_filtered_colors = false,
      use_git_status_colors = false,
      highlight = "NeoTreeFileName",
    },
    file_size = {
      enabled = false,
      width = 12,
      required_width = 64,
    },
    type = {
      enabled = false,
      width = 10,
      required_width = 122,
    },
    last_modified = {
      enabled = false,
      width = 20,
      required_width = 88,
    },
    created = {
      enabled = false,
      width = 20,
      required_width = 110,
    },
    symlink_target = {
      enabled = false,
    },
  },
  -- A list of functions, each representing a global custom command
  -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
  -- see `:h neo-tree-custom-commands-global`
  commands = {},
  window = {
    position = "left",
    width = 30,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = {
        "toggle_node",
        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "cancel",
      ["P"] = {
        "toggle_preview",
        config = {
          use_float = true,
          use_snacks_image = true,
          use_image_nvim = true,
        },
      },
      ["l"] = "focus_preview",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      ["t"] = "open_tabnew",
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ["w"] = "open_with_window_picker",
      ["C"] = "close_node",
      ["z"] = "close_all_nodes",
      ["a"] = {
        "add",
        config = {
          show_path = "none", -- "none", "relative", "absolute"
        },
      },
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["b"] = "rename_basename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["<C-r>"] = "clear_clipboard",
      ["c"] = "copy",
      -- ["c"] = {
      --  "copy",
      --  config = {
      --    show_path = "none" -- "none", "relative", "absolute"
      --  }
      --}
      ["m"] = "move",
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
      ["i"] = "show_file_details",
    },
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_ignored = false,
      ignore_files = {
        ".neotreeignore",
        ".ignore",
      },
      hide_hidden = false, -- windows
      hide_by_name = { },
      hide_by_pattern = { },
      always_show = { },
      always_show_by_pattern = {
        ".env*",
      },
      never_show = {
        ".DS_Store",
        "thumbs.db"
      },
      never_show_by_pattern = { },
    },
    follow_current_file = {
      enabled = false,
      leave_dirs_open = false,
    },
    group_empty_dirs = false,
    hijack_netrw_behavior = "open_default",
    -- netrw disabled, opening a directory opens neo-tree
    -- "open_current",  -- netrw disabled, opening a directory opens within the
    -- window like netrw would, regardless of window.position
    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    use_libuv_file_watcher = false,
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        -- ["D"] = "fuzzy_sorter_directory",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
        ["o"] = {
          "show_help",
          nowait = false,
          config = { title = "Order by", prefix_key = "o" },
        },
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["og"] = { "order_by_git_status", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
        -- ['<key>'] = function(state) ... end,
      },
      fuzzy_finder_mappings = {
        ["<down>"] = "move_cursor_down",
        ["<C-n>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
        ["<C-p>"] = "move_cursor_up",
        ["<esc>"] = "close",
        ["<S-CR>"] = "close_keep_filter",
        ["<C-CR>"] = "close_clear_filter",
        ["<C-w>"] = { "<C-S-w>", raw = true },
        {
          -- normal mode mappings
          n = {
            ["j"] = "move_cursor_down",
            ["k"] = "move_cursor_up",
            ["<S-CR>"] = "close_keep_filter",
            ["<C-CR>"] = "close_clear_filter",
            ["<esc>"] = "close",
          }
        }
        -- ["<esc>"] = "noop", -- if you want to use normal mode
        -- ["key"] = function(state, scroll_padding) ... end,
      },
    },

    commands = {}, -- Add a custom command or override a global one using the same function name
  },
  buffers = {
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
      --              -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    group_empty_dirs = true, -- when true, empty folders will be grouped together
    show_unloaded = true,
    window = {
      mappings = {
        ["d"] = "buffer_delete",
        ["bd"] = "buffer_delete",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["o"] = {
          "show_help",
          nowait = false,
          config = { title = "Order by", prefix_key = "o" },
        },
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
      },
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["A"] = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["gU"] = "git_undo_last_commit",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
        ["o"] = {
          "show_help",
          nowait = false,
          config = { title = "Order by", prefix_key = "o" },
        },
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
      },
    },
  },
})
