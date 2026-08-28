-- hyprland/conf/keybinds.lua
-- Correct keysyms for Hyprland Lua API (lowercase for unshifted keys)

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
hl.bind(mainMod .. " + space",       hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + a",           hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + t",           hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + b",           hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + b",   hl.dsp.exec_cmd("firefox -P pentest --no-remote"))
hl.bind(mainMod .. " + o",           hl.dsp.exec_cmd(notes))
hl.bind(mainMod .. " + v",           hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + ALT + v",     hl.dsp.exec_cmd(editorAlt))
hl.bind(mainMod .. " + f",           hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + p",           hl.dsp.exec_cmd("sh -c '" .. colorPicker .. " | wl-copy'"))
hl.bind(mainMod .. " + SHIFT + p",   hl.dsp.exec_cmd(home .. "/.config/waybar/scripts/idle-toggle.sh"))
hl.bind(mainMod .. " + SHIFT + a",   hl.dsp.exec_cmd(home .. "/.local/bin/rofi-launcher -show emoji"))
hl.bind(mainMod .. " + SHIFT + w",   hl.dsp.exec_cmd(home .. "/.local/bin/rofi-wallpaper"))

-- ── 2. Window Management ────────────────────────────────────────────────────
hl.bind(mainMod .. " + q",           hl.dsp.window.close())
hl.bind(mainMod .. " + w",           hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + f",   hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + ALT + f",     hl.dsp.window.fullscreen({ mode = "maximized",  action = "toggle" }))
hl.bind(mainMod .. " + j",           hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + c",           hl.dsp.window.center())

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
hl.bind("ALT + Tab",         hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))

-- Focus with arrow keys & vim
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down"  }))
hl.bind(mainMod .. " + h",     hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + l",     hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k",     hl.dsp.focus({ direction = "up"    }))

-- Move window in layout (arrows + vim)
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left"  }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up"    }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down"  }))
hl.bind(mainMod .. " + SHIFT + h",     hl.dsp.window.move({ direction = "left"  }))
hl.bind(mainMod .. " + SHIFT + l",     hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k",     hl.dsp.window.move({ direction = "up"    }))
hl.bind(mainMod .. " + SHIFT + j",     hl.dsp.window.move({ direction = "down"  }))

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
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. key,      hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Special Workspace / Scratchpad
hl.bind(mainMod .. " + s",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + s", hl.dsp.window.move({ workspace = "special:magic" }))

-- Cycle workspaces
hl.bind(mainMod .. " + Tab",         hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "previous" }))
hl.bind(mainMod .. " + mouse_down",  hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",    hl.dsp.focus({ workspace = "e-1" }))

-- ── 4. System & Hardware Keys ───────────────────────────────────────────────
hl.bind(mainMod .. " + l",      hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(
    "wlogout -p layer-shell" ..
    " -C " .. home .. "/.config/wlogout/style.css" ..
    " -l " .. home .. "/.config/wlogout/layout" ..
    " -b 5"
))
hl.bind("CTRL + Escape", hl.dsp.exec_cmd("sh -c 'killall waybar || waybar'"))

-- Screenshots
hl.bind(            "Print",              hl.dsp.exec_cmd("grimblast --notify copysave screen"))
hl.bind(mainMod .. " + Print",           hl.dsp.exec_cmd("grimblast --notify copysave active"))
hl.bind(mainMod .. " + ALT + Print",     hl.dsp.exec_cmd("grimblast --notify copysave area"))
hl.bind(mainMod .. " + SHIFT + Print",   hl.dsp.exec_cmd(
    "sh -c 'grimblast save area /tmp/swappy-screenshot.png && swappy -f /tmp/swappy-screenshot.png'"
))

-- Hardware Volume & Brightness Keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/osd-volume up"),   { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/osd-volume down"), { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/osd-volume mic"),  { locked = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/osd-volume mute"), { locked = true })
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause",       hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/osd-brightness up"),   { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/osd-brightness down"), { locked = true })

-- Notifications & Cheatsheet
hl.bind(mainMod .. " + n", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + i", hl.dsp.exec_cmd(
    "kitty --class keybind-help --override font_size=10 -e " ..
    home .. "/.config/hypr/scripts/keybind-help.sh"
))

-- Theme Switcher
hl.bind(mainMod .. " + SHIFT + i", hl.dsp.exec_cmd(home .. "/.config/waybar/scripts/theme-switch.sh matrix"))
hl.bind(mainMod .. " + CTRL + i",  hl.dsp.exec_cmd(home .. "/.config/waybar/scripts/theme-switch.sh macchiato"))

-- ── 5. ASUS ROG Zephyrus Hardware Keys & Battery Saver ──────────────────────
-- ROG Key (M4 button): Opens ROG Control Center GUI
hl.bind("XF86Launch1", hl.dsp.exec_cmd("rog-control-center"))
-- Fan / Profile Key (Fn+F5 / M3): Cycles Power Modes
hl.bind("XF86Launch4", hl.dsp.exec_cmd("sh -c 'asusctl profile next && notify-send -u low -i preferences-system-power \"ROG Power Mode\" \"$(asusctl profile get | grep \"Active profile\" | cut -d: -f2)\"'"))
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd("sh -c 'asusctl profile next && notify-send -u low -i preferences-system-power \"ROG Power Mode\" \"$(asusctl profile get | grep \"Active profile\" | cut -d: -f2)\"'"))

-- Custom Ultra Battery Saver Toggle (SUPER + SHIFT + E & SUPER + F6)
hl.bind(mainMod .. " + SHIFT + e", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/battery-saver.sh"))
hl.bind(mainMod .. " + F6",        hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/battery-saver.sh"))
