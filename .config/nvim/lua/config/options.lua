-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.clipboard = "unnamedplus" -- Sync with system clipboard (Wayland wl-clipboard)
opt.relativenumber = false    -- Standard absolute line numbers (1, 2, 3...)
opt.number = true             -- Show line number
opt.cursorline = true         -- Highlight current line
opt.wrap = false              -- No line wrapping by default
opt.scrolloff = 8             -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8         -- Keep 8 columns to left/right
opt.termguicolors = true      -- True color support
opt.undofile = true           -- Persistent undo history
opt.autowrite = true          -- Auto-save on buffer leave / run
opt.autowriteall = true       -- Auto-save on all buffer events
