-- Dynamic Dual-Taste Colorscheme Engine (Catppuccin Macchiato & Matrix Cyberpunk)

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
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = function()
      local is_matrix = (get_active_flavor() == "matrix")

      return {
        flavour = is_matrix and "mocha" or "macchiato",
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
        color_overrides = is_matrix and {
          mocha = {
            base = "#0a0202",
            mantle = "#060101",
            crust = "#020000",
            surface0 = "#180404",
            surface1 = "#240606",
            surface2 = "#320808",
            text = "#ff5566",
            subtext0 = "#cc3344",
            subtext1 = "#dd4455",
            overlay0 = "#6b2030",
            overlay1 = "#7a2535",
            overlay2 = "#893040",
            red = "#ff3344",
            maroon = "#ff5566",
            peach = "#ff8040",
            yellow = "#ffdd44",
            green = "#ff3344",
            teal = "#ff6677",
            sky = "#ff8040",
            sapphire = "#ff5566",
            blue = "#cc3344",
            lavender = "#ff6677",
            mauve = "#ff3344",
            rosewater = "#ffdd44",
          },
        } or {},
        custom_highlights = function(colors)
          if is_matrix then
            return {
              Normal = { bg = "#0a0202", fg = "#ff5566" },
              NormalFloat = { bg = "#100303", fg = "#ff5566" },
              FloatBorder = { bg = "#100303", fg = "#ff3344" },
              FloatTitle = { bg = "#100303", fg = "#ffdd44", bold = true },
              NormalNC = { bg = "#060101" },
              SignColumn = { bg = "#0a0202" },
              LineNr = { fg = "#6b2030" },
              CursorLineNr = { fg = "#ff3344", bold = true },
              CursorLine = { bg = "#180404" },
              Search = { bg = "#ff3344", fg = "#000000", bold = true },
              IncSearch = { bg = "#ffdd44", fg = "#000000", bold = true },
              StatusLine = { bg = "#100202", fg = "#ff5566" },
              StatusLineNC = { bg = "#060101", fg = "#6b2030" },
              NeoTreeNormal = { bg = "#060101", fg = "#ff5566" },
              NeoTreeNormalNC = { bg = "#040000" },
              NeoTreeEndOfBuffer = { fg = "#060101" },
              Directory = { fg = "#ff8040", bold = true },
              DiagnosticError = { fg = "#ff3344" },
              DiagnosticWarn = { fg = "#ff8040" },
              DiagnosticInfo = { fg = "#ff6677" },
              DiagnosticHint = { fg = "#ffdd44" },
            }
          else
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
          end
        end,
      }
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
