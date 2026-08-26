return {
  -- Copilot Core
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "InsertEnter", "BufReadPost", "BufNewFile" },
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<Tab>",
          accept_word = "<M-Right>",
          accept_line = "<M-Down>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        ["*"] = true,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)

      local function toggle_copilot()
        local client = require("copilot.client")
        local cmd = require("copilot.command")
        if client.is_disabled() then
          cmd.enable()
          vim.notify(" GitHub Copilot: Enabled", vim.log.levels.INFO, { title = "Copilot" })
        else
          cmd.disable()
          vim.notify(" GitHub Copilot: Disabled", vim.log.levels.WARN, { title = "Copilot" })
        end
        pcall(function()
          require("lualine").refresh()
        end)
      end

      vim.keymap.set({ "n", "i", "v" }, "<A-c>", toggle_copilot, { desc = "Toggle GitHub Copilot (Alt+C)" })
      vim.keymap.set({ "n", "i", "v" }, "<C-A-c>", toggle_copilot, { desc = "Toggle GitHub Copilot (Ctrl+Alt+C)" })
      vim.keymap.set("n", "<leader>uc", toggle_copilot, { desc = "Toggle Copilot" })
    end,
  },

  -- Blink.cmp integration so Copilot suggestions appear in autocomplete popup
  {
    "giuxtaposition/blink-cmp-copilot",
  },
  {
    "saghen/blink.cmp",
    dependencies = { "giuxtaposition/blink-cmp-copilot" },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or { "lsp", "path", "snippets", "buffer" }
      if not vim.tbl_contains(opts.sources.default, "copilot") then
        table.insert(opts.sources.default, "copilot")
      end
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.copilot = {
        name = "copilot",
        module = "blink-cmp-copilot",
        score_offset = 100,
        async = true,
      }
      return opts
    end,
  },
}
