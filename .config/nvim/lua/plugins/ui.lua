-- Modern Aesthetic UI & Dynamic Flavor Statusline

return {
  -- ── 1. Custom Dashboard Header (Aesthetic Minimalist) ─────────────────────
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
   █████████                                          
  ███░░░░░███                                         
 ░███    ░░░   ██████   ██████  ████████  █████ █████ 
 ░░█████████  ░░░░░███ ░░░░░███░░███░░███░░███ ░░███  
  ░░░░░░░░███  ███████  ███████ ░███ ░░░  ░███  ░███  
  ███    ░███ ███░░███ ███░░███ ░███      ░░███ ███   
 ░░█████████ ░░████████░░████████████      ░░█████    
  ░░░░░░░░░   ░░░░░░░░  ░░░░░░░░░░░░        ░░░░░     
          ─── N E O V I M  •  L A Z Y V I M ───       
          ]],
        },
      },
    },
  },

  -- ── 2. Clean, macOS-Style Lualine Statusline ──────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = "auto"
      opts.options.component_separators = { left = "│", right = "│" }
      opts.options.section_separators = { left = "", right = "" }
      opts.options.globalstatus = true

      opts.sections = opts.sections or {}
      opts.sections.lualine_a = { { "mode", icon = "" } }
      opts.sections.lualine_b = {
        { "branch", icon = "󰊢" },
        { "diff", symbols = { added = "✚ ", modified = " ", removed = "✖ " } },
      }
      opts.sections.lualine_c = {
        {
          function()
            local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return "📁 " .. dir
          end,
          gui = "bold",
        },
        {
          "filename",
          file_status = true,
          path = 1,
          symbols = {
            modified = " 󰏫 (unsaved)",
            readonly = " 󰌾 (readonly)",
            unnamed = "[No Name]",
            newfile = " 󰝒 (new)",
          },
        },
        {
          "diagnostics",
          symbols = {
            error = " ",
            warn = " ",
            info = " ",
            hint = " ",
          },
        },
      }

      opts.sections.lualine_x = {
        {
          function()
            local ok, client = pcall(require, "copilot.client")
            if ok and client and type(client.is_disabled) == "function" and not client.is_disabled() then
              return " Copilot: On"
            end
            return " Copilot: Off"
          end,
          color = function()
            local ok, client = pcall(require, "copilot.client")
            if ok and client and type(client.is_disabled) == "function" and not client.is_disabled() then
              return { fg = "#a6da95", gui = "bold" }
            end
            return { fg = "#6e738d" }
          end,
        },
        { "filetype", icon_only = true },
      }

      opts.sections.lualine_y = { "progress" }
      opts.sections.lualine_z = { { "location", padding = { left = 1, right = 1 } } }

      return opts
    end,
  },

  -- ── 3. Modern macOS-Style Bufferline (Pill Tabs) ──────────────────────────
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers",
        style_preset = "default",
        separator_style = "thin",
        show_buffer_close_icons = true,
        show_close_icon = false,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 150,
          reveal = { "close" },
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "󰉓 Explorer",
            highlight = "Directory",
            text_align = "center",
          },
        },
      },
    },
  },

  -- ── 4. Disable glitchy animated indentscope ───────────────────────────────
  {
    "nvim-mini/mini.indentscope",
    opts = {
      draw = {
        delay = 0,
        animation = function()
          return 0
        end,
      },
    },
  },

  -- ── 5. Smooth Animated Caret & Cursor Glide (smear-cursor) ────────────────
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.1,
      hide_target_hack = false,
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
    },
  },
}
