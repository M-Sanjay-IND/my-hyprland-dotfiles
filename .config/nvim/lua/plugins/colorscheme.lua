-- Dynamic Dual-Taste Colorscheme Engine (Catppuccin Macchiato & Cyberdream Matrix)

local function get_active_flavor()
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
  -- ── 1. Catppuccin Macchiato (Cozy Pastel Whitehat Theme) ──────────────────
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "macchiato",
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        aerial = true,
        alpha = true,
        blink_cmp = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        mini = true,
        navic = { enabled = true },
        neotree = true,
        neotest = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
      custom_highlights = function(colors)
        return {
          Normal = { bg = colors.base, fg = colors.text },
          NormalFloat = { bg = colors.mantle, fg = colors.text },
          FloatBorder = { bg = colors.mantle, fg = colors.lavender },
          FloatTitle = { bg = colors.mantle, fg = colors.mauve, bold = true },
          NormalNC = { bg = colors.mantle },
          SignColumn = { bg = colors.base },
          LineNr = { fg = colors.surface2 },
          CursorLineNr = { fg = colors.mauve, bold = true },
          CursorLine = { bg = "#2e324a" },
          Search = { bg = colors.mauve, fg = colors.base, bold = true },
          IncSearch = { bg = colors.peach, fg = colors.base, bold = true },
          StatusLine = { bg = colors.mantle, fg = colors.text },
          StatusLineNC = { bg = colors.crust, fg = colors.overlay0 },
          NeoTreeNormal = { bg = colors.mantle, fg = colors.text },
          NeoTreeNormalNC = { bg = colors.crust },
          NeoTreeEndOfBuffer = { fg = colors.mantle },
          Directory = { fg = colors.lavender, bold = true },
          DiagnosticError = { fg = colors.red },
          DiagnosticWarn = { fg = colors.peach },
          DiagnosticInfo = { fg = colors.teal },
          DiagnosticHint = { fg = colors.sapphire },
        }
      end,
    },
  },

  -- ── 2. Cyberdream (Ultra-High Contrast Cyberpunk / Matrix Theme) ──────────
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      italic_comments = true,
      hide_fillchars = false,
      borderless_pickers = false,
      terminal_colors = true,
      theme = {
        variant = "default",
        highlights = {
          Normal = { bg = "#080202", fg = "#ff5566" },
          NormalFloat = { bg = "#0e0303", fg = "#ff5566" },
          FloatBorder = { bg = "#0e0303", fg = "#ff3344" },
          FloatTitle = { bg = "#0e0303", fg = "#ffdd44", bold = true },
          CursorLineNr = { fg = "#ff3344", bold = true },
          CursorLine = { bg = "#180404" },
          NeoTreeNormal = { bg = "#040101", fg = "#ff5566" },
          NeoTreeNormalNC = { bg = "#020000" },
          Directory = { fg = "#ff8040", bold = true },
          DiagnosticError = { fg = "#ff3344" },
          DiagnosticWarn = { fg = "#ff8040" },
        },
        colors = {
          bg = "#080202",
          bg_alt = "#0e0303",
          bg_highlight = "#180404",
          fg = "#ff5566",
          grey = "#6b2030",
          blue = "#ff4455",
          green = "#ff3344",
          cyan = "#ff6677",
          red = "#ff2233",
          yellow = "#ffdd44",
          magenta = "#ff3344",
          pink = "#ff6677",
          orange = "#ff8040",
          purple = "#ff4455",
        },
      },
    },
  },

  -- ── 3. LazyVim Theme Selector & Auto-Apply ───────────────────────────────
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      local flavor = get_active_flavor()
      if flavor == "matrix" then
        opts.colorscheme = "cyberdream"
      else
        opts.colorscheme = "catppuccin-macchiato"
      end
      return opts
    end,
  },
}
