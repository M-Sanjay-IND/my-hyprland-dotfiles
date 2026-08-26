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

      return opts
    end,
  },
}
