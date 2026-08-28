-- hyprland/conf/keybinds.lua
-- Pure Lua Callback Architecture (100% reliable execution)

local home    = os.getenv("HOME")
local mainMod = "SUPER"

local terminal    = "kitty"
local fileManager = "kitty yazi"
local browser     = "firefox"
local notes       = "obsidian"
local editor      = "code"
local editorAlt   = "subl"
local colorPicker = "hyprpicker"
local menu        = home .. "/.local/bin/rofi-launcher -show drun -modi 'drun,window,clipboard:" .. home .. "/.local/bin/rofi-clipboard'"

-- ── 1. App Launches ─────────────────────────────────────────────────────────
hl.bind(mainMod .. " + space",       function() hl.exec_cmd(menu) end)
hl.bind(mainMod .. " + a",           function() hl.exec_cmd(menu) end)
hl.bind(mainMod .. " + t",           function() hl.exec_cmd(terminal) end)
hl.bind(mainMod .. " + b",           function() hl.exec_cmd(browser) end)
hl.bind(mainMod .. " + SHIFT + b",   function() hl.exec_cmd("firefox -P pentest --no-remote") end)
hl.bind(mainMod .. " + o",           function() hl.exec_cmd(notes) end)
hl.bind(mainMod .. " + v",           function() hl.exec_cmd(editor) end)
hl.bind(mainMod .. " + ALT + v",     function() hl.exec_cmd(editorAlt) end)
hl.bind(mainMod .. " + f",           function() hl.exec_cmd(fileManager) end)
hl.bind(mainMod .. " + p",           function() hl.exec_cmd("sh -c '" .. colorPicker .. " | wl-copy'") end)
hl.bind(mainMod .. " + SHIFT + p",   function() hl.exec_cmd(home .. "/.config/waybar/scripts/idle-toggle.sh") end)
hl.bind(mainMod .. " + SHIFT + a",   function() hl.exec_cmd(home .. "/.local/bin/rofi-launcher -show emoji") end)
hl.bind(mainMod .. " + SHIFT + w",   function() hl.exec_cmd(home .. "/.local/bin/rofi-wallpaper") end)

-- ── 2. Window Management ────────────────────────────────────────────────────
hl.bind(mainMod .. " + q",           function() hl.dispatch(hl.dsp.window.close()) end)
hl.bind(mainMod .. " + w",           function() hl.dispatch(hl.dsp.window.float({ action = "toggle" })) end)
hl.bind(mainMod .. " + SHIFT + f",   function() hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })) end)
hl.bind(mainMod .. " + ALT + f",     function() hl.dispatch(hl.dsp.window.fullscreen({ mode = "maximized",  action = "toggle" })) end)
hl.bind(mainMod .. " + j",           function() hl.dispatch(hl.dsp.layout("togglesplit")) end)
hl.bind(mainMod .. " + c",           function() hl.dispatch(hl.dsp.window.center()) end)

-- Float presets: minimize / maximize
hl.bind(mainMod .. " + m", function()
    hl.dispatch(hl.dsp.window.resize({ x = 1100, y = 720, relative = false }))
    hl.dispatch(hl.dsp.window.center())
end)
hl.bind(mainMod .. " + SHIFT + m", function()
    hl.dispatch(hl.dsp.window.resize({ x = 1500, y = 820, relative = false }))
    hl.dispatch(hl.dsp.window.center())
end)

-- Alt-Tab: cycle windows (prev/next) and bring to top
hl.bind("ALT + Tab",         function() hl.dispatch(hl.dsp.window.cycle_next()) end)
hl.bind("ALT + SHIFT + Tab", function() hl.dispatch(hl.dsp.window.cycle_next({ next = false })) end)

-- Focus with arrow keys & vim
hl.bind(mainMod .. " + left",  function() hl.dispatch(hl.dsp.focus({ direction = "left" })) end)
hl.bind(mainMod .. " + right", function() hl.dispatch(hl.dsp.focus({ direction = "right" })) end)
hl.bind(mainMod .. " + up",    function() hl.dispatch(hl.dsp.focus({ direction = "up" })) end)
hl.bind(mainMod .. " + down",  function() hl.dispatch(hl.dsp.focus({ direction = "down" })) end)
hl.bind(mainMod .. " + h",     function() hl.dispatch(hl.dsp.focus({ direction = "left" })) end)
hl.bind(mainMod .. " + l",     function() hl.dispatch(hl.dsp.focus({ direction = "right" })) end)
hl.bind(mainMod .. " + k",     function() hl.dispatch(hl.dsp.focus({ direction = "up" })) end)

-- Move window in layout (arrows + vim)
hl.bind(mainMod .. " + SHIFT + left",  function() hl.dispatch(hl.dsp.window.move({ direction = "left" })) end)
hl.bind(mainMod .. " + SHIFT + right", function() hl.dispatch(hl.dsp.window.move({ direction = "right" })) end)
hl.bind(mainMod .. " + SHIFT + up",    function() hl.dispatch(hl.dsp.window.move({ direction = "up" })) end)
hl.bind(mainMod .. " + SHIFT + down",  function() hl.dispatch(hl.dsp.window.move({ direction = "down" })) end)
hl.bind(mainMod .. " + SHIFT + h",     function() hl.dispatch(hl.dsp.window.move({ direction = "left" })) end)
hl.bind(mainMod .. " + SHIFT + l",     function() hl.dispatch(hl.dsp.window.move({ direction = "right" })) end)
hl.bind(mainMod .. " + SHIFT + k",     function() hl.dispatch(hl.dsp.window.move({ direction = "up" })) end)
hl.bind(mainMod .. " + SHIFT + j",     function() hl.dispatch(hl.dsp.window.move({ direction = "down" })) end)

-- Resize with CTRL + arrows + vim (repeating)
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x =  30, y =   0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -30, y =   0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x =   0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x =   0, y =  30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + l",     hl.dsp.window.resize({ x =  30, y =   0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + h",     hl.dsp.window.resize({ x = -30, y =   0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + k",     hl.dsp.window.resize({ x =   0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + j",     hl.dsp.window.resize({ x =   0, y =  30, relative = true }), { repeating = true })

-- Mouse drag / resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ── 3. Workspaces ───────────────────────────────────────────────────────────
for i = 1, 10 do
    local key = i % 10  -- 10 → key 0
    hl.bind(mainMod .. " + " .. key,             function() hl.dispatch(hl.dsp.focus({ workspace = i })) end)
    hl.bind(mainMod .. " + SHIFT + " .. key,     function() hl.dispatch(hl.dsp.window.move({ workspace = i })) end)
    hl.bind(mainMod .. " + CTRL + " .. key,      function() hl.dispatch(hl.dsp.window.move({ workspace = i, follow = false })) end)
end

-- Special Workspace / Scratchpad
hl.bind(mainMod .. " + s",         function() hl.dispatch(hl.dsp.workspace.toggle_special("magic")) end)
hl.bind(mainMod .. " + SHIFT + s", function() hl.dispatch(hl.dsp.window.move({ workspace = "special:magic" })) end)

-- Cycle workspaces
hl.bind(mainMod .. " + Tab",         function() hl.dispatch(hl.dsp.focus({ workspace = "e+1" })) end)
hl.bind(mainMod .. " + SHIFT + Tab", function() hl.dispatch(hl.dsp.focus({ workspace = "previous" })) end)
hl.bind(mainMod .. " + mouse_down",  function() hl.dispatch(hl.dsp.focus({ workspace = "e+1" })) end)
hl.bind(mainMod .. " + mouse_up",    function() hl.dispatch(hl.dsp.focus({ workspace = "e-1" })) end)

-- ── 4. System & Hardware Keys ───────────────────────────────────────────────
hl.bind(mainMod .. " + l",      function() hl.exec_cmd("hyprlock") end)
hl.bind(mainMod .. " + Escape", function()
    hl.exec_cmd("wlogout -p layer-shell -C " .. home .. "/.config/wlogout/style.css -l " .. home .. "/.config/wlogout/layout -b 5")
end)
hl.bind("CTRL + Escape", function() hl.exec_cmd("sh -c 'killall waybar || waybar'") end)

-- Screenshots
hl.bind(            "Print",              function() hl.exec_cmd("grimblast --notify copysave screen") end)
hl.bind(mainMod .. " + Print",           function() hl.exec_cmd("grimblast --notify copysave active") end)
hl.bind(mainMod .. " + ALT + Print",     function() hl.exec_cmd("grimblast --notify copysave area") end)
hl.bind(mainMod .. " + SHIFT + Print",   function()
    hl.exec_cmd("sh -c 'grimblast save area /tmp/swappy-screenshot.png && swappy -f /tmp/swappy-screenshot.png'")
end)

-- Hardware Volume & Brightness Keys
hl.bind("XF86AudioRaiseVolume", function() hl.exec_cmd(home .. "/.config/hypr/scripts/osd-volume up") end,   { locked = true })
hl.bind("XF86AudioLowerVolume", function() hl.exec_cmd(home .. "/.config/hypr/scripts/osd-volume down") end, { locked = true })
hl.bind("XF86AudioMicMute",     function() hl.exec_cmd(home .. "/.config/hypr/scripts/osd-volume mic") end,  { locked = true })
hl.bind("XF86AudioMute",        function() hl.exec_cmd(home .. "/.config/hypr/scripts/osd-volume mute") end, { locked = true })
hl.bind("XF86AudioPlay",        function() hl.exec_cmd("playerctl play-pause") end, { locked = true })
hl.bind("XF86AudioPause",       function() hl.exec_cmd("playerctl play-pause") end, { locked = true })
hl.bind("XF86AudioNext",        function() hl.exec_cmd("playerctl next") end,       { locked = true })
hl.bind("XF86AudioPrev",        function() hl.exec_cmd("playerctl previous") end,   { locked = true })
hl.bind("XF86MonBrightnessUp",   function() hl.exec_cmd(home .. "/.config/hypr/scripts/osd-brightness up") end,   { locked = true })
hl.bind("XF86MonBrightnessDown", function() hl.exec_cmd(home .. "/.config/hypr/scripts/osd-brightness down") end, { locked = true })

-- Notifications & Cheatsheet
hl.bind(mainMod .. " + n", function() hl.exec_cmd("swaync-client -t") end)
hl.bind(mainMod .. " + i", function()
    hl.exec_cmd("kitty --class keybind-help --override font_size=10 -e " .. home .. "/.config/hypr/scripts/keybind-help.sh")
end)

-- Theme Switcher
hl.bind(mainMod .. " + SHIFT + i", function() hl.exec_cmd(home .. "/.config/waybar/scripts/theme-switch.sh matrix") end)
hl.bind(mainMod .. " + CTRL + i",  function() hl.exec_cmd(home .. "/.config/waybar/scripts/theme-switch.sh macchiato") end)

-- ── 5. ASUS ROG Zephyrus Hardware Keys & Battery Saver ──────────────────────
-- ROG Key (M4 button): Opens ROG Control Center GUI
hl.bind("XF86Launch1", function() hl.exec_cmd("rog-control-center") end)
-- Fan / Profile Key (Fn+F5 / M3): Cycles Power Modes
hl.bind("XF86Launch4", function()
    hl.exec_cmd("sh -c 'asusctl profile next && notify-send -u low -i preferences-system-power \"ROG Power Mode\" \"$(asusctl profile get | grep \"Active profile\" | cut -d: -f2)\"'")
end)
hl.bind(mainMod .. " + F5", function()
    hl.exec_cmd("sh -c 'asusctl profile next && notify-send -u low -i preferences-system-power \"ROG Power Mode\" \"$(asusctl profile get | grep \"Active profile\" | cut -d: -f2)\"'")
end)

-- Custom Ultra Battery Saver Toggle (SUPER + SHIFT + E & SUPER + F6)
hl.bind(mainMod .. " + SHIFT + e", function() hl.exec_cmd(home .. "/.config/hypr/scripts/battery-saver.sh") end)
hl.bind(mainMod .. " + F6",        function() hl.exec_cmd(home .. "/.config/hypr/scripts/battery-saver.sh") end)
