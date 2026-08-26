return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = "<Tab>", -- Tab to accept Copilot suggestion
          accept_word = "<M-Right>",
          accept_line = "<M-Down>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
        ["."] = false,
      },
    },
    keys = {
      {
        "<A-c>",
        function()
          local suggestion = require("copilot.suggestion")
          suggestion.toggle_auto_trigger()
          vim.notify("GitHub Copilot suggestions toggled", vim.log.levels.INFO, { title = "Copilot" })
        end,
        desc = "Toggle Copilot (Alt+C)",
        mode = { "n", "i", "v" },
      },
      {
        "<C-A-c>",
        function()
          local suggestion = require("copilot.suggestion")
          suggestion.toggle_auto_trigger()
          vim.notify("GitHub Copilot suggestions toggled", vim.log.levels.INFO, { title = "Copilot" })
        end,
        desc = "Toggle Copilot (Ctrl+Alt+C)",
        mode = { "n", "i", "v" },
      },
    },
  },
}
