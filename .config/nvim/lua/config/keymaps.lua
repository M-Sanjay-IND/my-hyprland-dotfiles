-- Standard Windows / VSCode-style Keymaps for LazyVim

local map = vim.keymap.set

-- ── 1. Direct Save (Ctrl+S & Ctrl+Shift+S) ──────────────────────────────────
local function save_current_file()
  local buf = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(buf)
  if bufname == "" or vim.bo[buf].buftype == "nofile" then
    vim.ui.input({ prompt = "Save As: " }, function(input)
      if input and input ~= "" then
        vim.cmd("write " .. vim.fn.fnameescape(input))
        vim.notify("💾 Saved as " .. input, vim.log.levels.INFO, { title = "Neovim" })
      end
    end)
  else
    local ok, err = pcall(vim.cmd, "write")
    if ok then
      local fname = vim.fn.fnamemodify(bufname, ":t")
      vim.notify("💾 Saved " .. fname, vim.log.levels.INFO, { title = "Neovim" })
    else
      vim.notify("❌ Error saving: " .. tostring(err), vim.log.levels.ERROR, { title = "Neovim" })
    end
  end
end

map({ "n", "i", "v", "x", "s" }, "<C-s>", save_current_file, { desc = "Save File" })
map({ "n", "i", "v", "x", "s" }, "<C-S-s>", function()
  local ok, err = pcall(vim.cmd, "wa")
  if ok then
    vim.notify("💾 All files saved", vim.log.levels.INFO, { title = "Neovim" })
  else
    vim.notify("❌ Error saving all: " .. tostring(err), vim.log.levels.ERROR, { title = "Neovim" })
  end
end, { desc = "Save All Files" })

-- ── 2. Integrated Terminal (Ctrl+` or Ctrl+~ or Ctrl+J or F12) ───────────────
local function toggle_terminal()
  Snacks.terminal.toggle()
end

map({ "n", "i", "v" }, "<C-`>", toggle_terminal, { desc = "Toggle Terminal" })
map({ "n", "i", "v" }, "<C-~>", toggle_terminal, { desc = "Toggle Terminal" })
map({ "n", "i", "v" }, "<C-j>", toggle_terminal, { desc = "Toggle Terminal" })
map({ "n", "i", "v" }, "<F12>", toggle_terminal, { desc = "Toggle Terminal" })
map("t", "<C-`>", "<cmd>close<cr>", { desc = "Close Terminal" })
map("t", "<C-~>", "<cmd>close<cr>", { desc = "Close Terminal" })
map("t", "<C-j>", "<cmd>close<cr>", { desc = "Close Terminal" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Close Terminal" })
map("t", "<C-_>", "<cmd>close<cr>", { desc = "Close Terminal" })
map("t", "<F12>", "<cmd>close<cr>", { desc = "Close Terminal" })
map("t", "<Esc><Esc>", "<cmd>close<cr>", { desc = "Close Terminal" })

-- ── 3. Directory & File Explorer Sidebar (Ctrl+B / F2) ──────────────────────
map({ "n", "i", "v" }, "<C-b>", "<cmd>Neotree toggle<cr>", { desc = "Toggle Directory Sidebar" })
map({ "n", "i", "v" }, "<F2>", "<cmd>Neotree toggle<cr>", { desc = "Toggle Directory Sidebar" })
map({ "n", "i", "v" }, "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Directory Sidebar" })

-- Jump between Sidebar and Code window (Ctrl+Left / Ctrl+Right)
map({ "n", "i", "v" }, "<C-Left>", "<cmd>wincmd h<cr>", { desc = "Focus Left Window" })
map({ "n", "i", "v" }, "<C-Right>", "<cmd>wincmd l<cr>", { desc = "Focus Right Window" })
map({ "n", "i", "v" }, "<C-Up>", "<cmd>wincmd k<cr>", { desc = "Focus Upper Window" })
map({ "n", "i", "v" }, "<C-Down>", "<cmd>wincmd j<cr>", { desc = "Focus Lower Window" })

-- ── 4. Open File / Open Folder (Ctrl+O, Ctrl+P, Ctrl+Shift+O) ───────────────
map({ "n", "i" }, "<C-S-o>", function()
  vim.ui.input({ prompt = "📁 Change Directory to: ", completion = "dir", default = vim.fn.getcwd() .. "/" }, function(input)
    if input and input ~= "" then
      vim.cmd("cd " .. vim.fn.fnameescape(input))
      vim.cmd("Neotree show")
      vim.notify("Working directory: " .. input, vim.log.levels.INFO, { title = "Neovim" })
    end
  end)
end, { desc = "Change Directory / Open Folder" })

map({ "n", "i" }, "<C-o>", function()
  LazyVim.pick("files")()
end, { desc = "Open File" })

map({ "n", "i" }, "<C-p>", function()
  LazyVim.pick("files")()
end, { desc = "Quick Open File" })

map({ "n", "i" }, "<C-S-f>", function()
  LazyVim.pick("live_grep")()
end, { desc = "Search Across Project" })

map("n", "<C-f>", "/", { desc = "Find in File" })
map("i", "<C-f>", "<Esc>/", { desc = "Find in File" })

map({ "n", "i" }, "<C-S-p>", function()
  LazyVim.pick("commands")()
end, { desc = "Command Palette" })

-- ── 5. Copy, Cut, Paste (Ctrl+C, Ctrl+X, Ctrl+V) ────────────────────────────
map("v", "<C-c>", '"+y', { desc = "Copy (Clipboard)" })
map("v", "<C-x>", '"+d', { desc = "Cut (Clipboard)" })
map({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste (Clipboard)" })
map("i", "<C-v>", "<C-r>+", { desc = "Paste (Clipboard)" })

-- ── 6. Undo & Redo (Ctrl+Z, Ctrl+Y) ─────────────────────────────────────────
map("n", "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<cmd>undo<cr>", { desc = "Undo" })
map("n", "<C-y>", "<C-r>", { desc = "Redo" })
map("i", "<C-y>", "<cmd>redo<cr>", { desc = "Redo" })

-- ── 7. Select All (Ctrl+A) ──────────────────────────────────────────────────
map({ "n", "i", "v" }, "<C-a>", "<Esc>ggVG", { desc = "Select All" })

-- ── 8. Tab / Buffer Management (Ctrl+W, Ctrl+N, Ctrl+Tab, Alt+Left/Right) ───
map({ "n", "i" }, "<C-w>", function()
  Snacks.bufdelete()
end, { desc = "Close Current File" })

-- New File (Ctrl+N): Prompts for filename in the current working directory, opens it, and keeps Neo-tree open!
map({ "n", "i" }, "<C-n>", function()
  local cwd = vim.fn.getcwd()
  vim.ui.input({ prompt = "📄 New file name (e.g. main.py): " }, function(name)
    if name and name ~= "" then
      local path = cwd .. "/" .. name
      vim.cmd("edit " .. vim.fn.fnameescape(path))
      vim.cmd("silent! write")
      vim.notify("✅ Created: " .. name .. " in " .. vim.fn.fnamemodify(cwd, ":t"), vim.log.levels.INFO, { title = "Neovim" })
    end
  end)
end, { desc = "New File in Current Directory" })

-- Tab switching that works 100% in Normal and Insert mode
map({ "n", "i", "v" }, "<C-Tab>", "<cmd>bnext<cr>", { desc = "Next Tab" })
map({ "n", "i", "v" }, "<C-S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous Tab" })
map({ "n", "i", "v" }, "<A-Right>", "<cmd>bnext<cr>", { desc = "Next Tab" })
map({ "n", "i", "v" }, "<A-Left>", "<cmd>bprevious<cr>", { desc = "Previous Tab" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Tab" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous Tab" })

-- ── 9. Side-by-Side Splits (Ctrl+\, Ctrl+-, F11) ───────────────────────────
map("n", "<C-\\>", "<cmd>vsplit<cr>", { desc = "Split Side-by-Side (Vertical)" })
map("n", "<C-->", "<cmd>split<cr>", { desc = "Split Horizontal" })
map("n", "<F11>", "<cmd>only<cr>", { desc = "Close All Other Splits (Keep Only This)" })

-- ── 10. Comments (Ctrl+/) ───────────────────────────────────────────────────
map({ "n", "i" }, "<C-/>", function()
  require("mini.comment").toggle_current_line()
end, { desc = "Toggle Comment" })
map("v", "<C-/>", "<esc><cmd>lua require('mini.comment').toggle_lines(vim.fn.line('\'<'), vim.fn.line('\'>'))<cr>", { desc = "Toggle Comment" })
map({ "n", "i" }, "<C-_>", "<cmd>normal gcc<cr>", { desc = "Toggle Comment" })
map("v", "<C-_>", "gc", { remap = true, desc = "Toggle Comment" })

-- ── 11. Line Moving & Duplication (Alt+Up/Down, Shift+Alt+Down) ─────────────
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move Lines Down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move Lines Up" })

map("n", "<A-S-Down>", "<cmd>t .<cr>", { desc = "Duplicate Line Down" })
map("i", "<A-S-Down>", "<esc><cmd>t .<cr>gi", { desc = "Duplicate Line Down" })

-- ── 12. Run Current Code File (Ctrl+R / F5 / :Run) ──────────────────────────
local function run_current_file()
  local file = vim.fn.expand("%:p")
  if file == "" or vim.bo.buftype ~= "" then
    local name = vim.fn.input("Save file as to run (e.g. Main.java or script.py): ")
    if name and name ~= "" then
      local fullpath = vim.fn.getcwd() .. "/" .. name
      vim.cmd("edit " .. vim.fn.fnameescape(fullpath))
      vim.cmd("silent! write")
      run_current_file()
    end
    return
  end

  vim.cmd("silent! write")

  local ft = vim.bo.filetype
  local ext = vim.fn.expand("%:e"):lower()
  local fname = vim.fn.expand("%:t")
  local dir = vim.fn.expand("%:p:h")
  local exec_cmd = ""

  if ft == "python" or ext == "py" then
    exec_cmd = "python3 " .. vim.fn.shellescape(file)
  elseif ft == "java" or ext == "java" then
    exec_cmd = "cd " .. vim.fn.shellescape(dir) .. " && java " .. vim.fn.shellescape(fname)
  elseif ft == "go" or ext == "go" then
    exec_cmd = "cd " .. vim.fn.shellescape(dir) .. " && go run " .. vim.fn.shellescape(fname)
  elseif ft == "javascript" or ext == "js" then
    exec_cmd = "node " .. vim.fn.shellescape(file)
  elseif ft == "typescript" or ext == "ts" then
    exec_cmd = "bun " .. vim.fn.shellescape(file) .. " 2>/dev/null || ts-node " .. vim.fn.shellescape(file)
  elseif ft == "sh" or ft == "bash" or ext == "sh" then
    exec_cmd = "bash " .. vim.fn.shellescape(file)
  elseif ft == "c" or ext == "c" then
    exec_cmd = "gcc " .. vim.fn.shellescape(file) .. " -o /tmp/a.out && /tmp/a.out"
  elseif ft == "cpp" or ext == "cpp" then
    exec_cmd = "g++ " .. vim.fn.shellescape(file) .. " -o /tmp/a.out && /tmp/a.out"
  elseif ft == "rust" or ext == "rs" then
    exec_cmd = "cargo run 2>/dev/null || (rustc " .. vim.fn.shellescape(file) .. " -o /tmp/a.out && /tmp/a.out)"
  elseif ft == "lua" or ext == "lua" then
    exec_cmd = "lua " .. vim.fn.shellescape(file)
  elseif ft == "ruby" or ext == "rb" then
    exec_cmd = "ruby " .. vim.fn.shellescape(file)
  elseif ft == "php" or ext == "php" then
    exec_cmd = "php " .. vim.fn.shellescape(file)
  else
    exec_cmd = "java " .. vim.fn.shellescape(file) .. " 2>/dev/null || python3 " .. vim.fn.shellescape(file) .. " 2>/dev/null || bash " .. vim.fn.shellescape(file)
  end

  local full_shell_cmd = "clear; echo '🚀 Running " .. fname .. "...'; echo '────────────────────────────────────────'; "
    .. exec_cmd
    .. "; echo ''; echo '────────────────────────────────────────'; read -r -p 'Press [Enter] to close output...' _; exit 0"

  -- Close existing terminal splits if already open
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      pcall(vim.api.nvim_win_close, win, true)
    end
  end

  -- Open split terminal at bottom
  vim.cmd("botright 14split | terminal bash -c " .. vim.fn.shellescape(full_shell_cmd))
  vim.cmd("startinsert")
end

map({ "n", "i", "v" }, "<C-r>", run_current_file, { desc = "Run Current File" })
map({ "n", "i", "v" }, "<F5>", run_current_file, { desc = "Run Current File" })
map({ "n", "i", "v" }, "<leader>r", run_current_file, { desc = "Run Current File" })

vim.api.nvim_create_user_command("Run", run_current_file, { desc = "Run Current File" })
vim.api.nvim_create_user_command("R", run_current_file, { desc = "Run Current File" })

-- ── 9. Interactive Theme Switcher (Space + u + T or :ThemeToggle) ──────────
local function toggle_theme()
  local cur = vim.g.colors_name or ""
  if cur:find("catppuccin") then
    vim.cmd("colorscheme cyberdream")
    vim.notify("🎨 Switched to Matrix / Cyberdream Theme", vim.log.levels.INFO, { title = "Theme" })
  else
    vim.cmd("colorscheme catppuccin-macchiato")
    vim.notify("🌸 Switched to Catppuccin Macchiato Theme", vim.log.levels.INFO, { title = "Theme" })
  end
end

map("n", "<leader>uT", toggle_theme, { desc = "Toggle Theme Flavor (Catppuccin / Cyberdream)" })
vim.api.nvim_create_user_command("ThemeToggle", toggle_theme, { desc = "Toggle Theme Flavor" })

