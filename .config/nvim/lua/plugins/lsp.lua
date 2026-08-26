return {
  -- Error Lens for Neovim (Rich inline glowing diagnostics on error lines)
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "modern",
        transparent_bg = true,
        options = {
          show_source = true,
          use_icons_from_diagnostic = true,
          multilines = true,
          show_all_diags_on_cursorline = true,
          enable_on_insert = true,
        },
      })
      -- Disable default virtual text so Error Lens handles it cleanly without double text
      vim.diagnostic.config({ virtual_text = false })
    end,
  },

  -- Ensure key LSPs are installed in Mason for instant code suggestions
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "pyright",           -- Python LSP
        "clangd",            -- C/C++ LSP
        "gopls",             -- Go LSP
        "rust-analyzer",     -- Rust LSP
        "lua-language-server",-- Lua LSP
        "vtsls",             -- TypeScript / JS LSP
      })
      return opts
    end,
  },
}
