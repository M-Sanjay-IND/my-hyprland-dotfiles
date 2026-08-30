-- Modern Aesthetic UI & Dynamic Flavor Statusline

local function get_flavor()
  local home = os.getenv("HOME") or ""
  local f = io.open(home .. "/.config/nvim/.theme", "r")
  if f then
    local content = f:read("*all"):gsub("%s+", "")
    f:close()
    if content == "matrix" then
      return "matrix"
    end
  end
  return "macchiato"
end

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

  -- ── 2. Clean, macOS Bubble-Style Lualine Statusline ───────────────────────
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local is_matrix = (get_flavor() == "matrix")

      opts.options = opts.options or {}
      opts.options.theme = is_matrix and "powerline_dark" or "catppuccin"
      opts.options.component_separators = { left = "│", right = "│" }
      opts.options.section_separators = { left = "", right = "" }
      opts.options.globalstatus = true

      -- Left: Mode, Branch, Directory & Filename
      opts.sections = opts.sections or {}
      opts.sections.lualine_a = {
        { "mode", separator = { left = "", right = "" }, padding = { left = 1, right = 1 } },
      }
      opts.sections.lualine_b = {
        { "branch", icon = "󰊢" },
        { "diff", symbols = { added = " ", modified = " ", removed = " " } },
      }
      opts.sections.lualine_c = {
        {
          function()
            local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return "📁 " .. dir
          end,
          color = { fg = is_matrix and "#ff8040" or "#8bd5ca", gui = "bold" },
        },
        {
          "filename",
          file_status = true,
          path = 1, -- relative path
          symbols = {
            modified = " 󰏫 (unsaved)",
            readonly = " 󰌾 (readonly)",
            unnamed = "[No Name]",
            newfile = " 󰝒 (new)",
          },
          color = { fg = is_matrix and "#ff5566" or "#cad3f5", gui = "bold" },
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

      -- Right: Copilot status & filetype
      opts.sections.lualine_x = {
        {
          function()
            local ok, client = pcall(require, "copilot.client")
            if not ok or client.is_disabled() then
              return " Copilot: Off"
            end
            return " Copilot: On"
          end,
          color = function()
            local ok, client = pcall(require, "copilot.client")
            if not ok or client.is_disabled() then
              return { fg = is_matrix and "#6b2030" or "#6e738d" }
            end
            return { fg = is_matrix and "#ff3344" or "#a6da95", gui = "bold" }
          end,
        },
        { "filetype", icon_only = true },
      }

      -- Location pill in lualine_z
      opts.sections.lualine_z = {
        { "location", separator = { left = "", right = "" }, padding = { left = 1, right = 1 } },
      }

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
        separator_style = "slant",
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
