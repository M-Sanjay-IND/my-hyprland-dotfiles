return {
  -- Disable snacks explorer so it never conflicts with Neo-tree
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
  },

  -- Neo-tree (Visual docked File Tree Sidebar)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<C-b>", "<cmd>Neotree toggle left<cr>", desc = "Toggle Directory Sidebar" },
      { "<F2>", "<cmd>Neotree toggle left<cr>", desc = "Toggle Directory Sidebar" },
      { "<leader>e", "<cmd>Neotree toggle left<cr>", desc = "Explorer (sidebar)" },
    },
    opts = {
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      sources = { "filesystem", "buffers", "git_status" },
      source_selector = {
        winbar = true,
        statusline = false,
        sources = {
          { source = "filesystem", display_name = " 󰉓 Files " },
          { source = "buffers", display_name = " 󰈚 Buffers " },
          { source = "git_status", display_name = " 󰊢 Git " },
        },
      },
      filesystem = {
        bind_to_cwd = true,
        follow_current_file = { enabled = true, leave_dirs_open = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<space>"] = "none",
          ["<cr>"] = "open",
          ["o"] = "open",
          ["<Tab>"] = "open",
          ["l"] = "open",
          ["<Right>"] = "open",
          ["h"] = "close_node",
          ["<Left>"] = "close_node",
          ["s"] = "open_vsplit",
          ["i"] = "open_split",
          ["a"] = "add",
          ["d"] = "delete",
          ["r"] = "rename",
          ["c"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["q"] = "close_window",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
        },
        icon = {
          folder_closed = "📁",
          folder_open = "📂",
          folder_empty = "󰜌",
          default = "📄",
        },
        git_status = {
          symbols = {
            added = "✚",
            modified = "",
            deleted = "✖",
            renamed = "󰁕",
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },
    },
  },
}
