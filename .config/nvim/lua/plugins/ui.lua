return {
  -- Custom Dashboard Header
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

  -- Clean, Informative Lualine Statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = "auto"
      opts.options.component_separators = { left = "│", right = "│" }
      opts.options.section_separators = { left = "", right = "" }

      -- Add directory badge to lualine_c
      opts.sections = opts.sections or {}
      opts.sections.lualine_c = {
        {
          function()
            local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return "📁 " .. dir
          end,
          color = { fg = "#8bd5ca", gui = "bold" },
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

      -- Add Copilot status indicator to lualine_x
      opts.sections.lualine_x = opts.sections.lualine_x or {}
      table.insert(opts.sections.lualine_x, 1, {
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
            return { fg = "#6e738d" }
          end
          return { fg = "#a6da95", gui = "bold" }
        end,
      })

      -- Line location in lualine_z
      opts.sections.lualine_z = {
        { "location", padding = { left = 1, right = 1 } },
      }

      return opts
    end,
  },

  -- Disable glitchy animated indentscope
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
}
