-- hyprland/themes/macchiato.lua

hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 5,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(b7bdf8ff)", "rgba(8aadf4ff)" }, angle = 45 },
            inactive_border = "rgba(363a4faa)",
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding = 5,

        active_opacity   = 1.0,
        inactive_opacity = 0.75,

        blur = {
            enabled        = true,
            size           = 6,
            passes         = 2,
            vibrancy       = 0.1696,
            ignore_opacity = false,
            xray           = true,
        },
    },

    animations = { enabled = true },

    dwindle = { preserve_split = true },

    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        vrr                      = 0,
        size_limits_tiled        = true,
    },
})

hl.curve("wind",   { type = "bezier", points = { { 0.05, 0.9  }, { 0.1,  1.05 } } })
hl.curve("winIn",  { type = "bezier", points = { { 0.1,  1.1  }, { 0.1,  1.1  } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3  }, { 0.0,  1.0  } } })
hl.curve("liner",  { type = "bezier", points = { { 1.0,  1.0  }, { 1.0,  1.0  } } })

hl.animation({ leaf = "windows",      enabled = true, speed = 6,  bezier = "wind",   style = "slide" })
hl.animation({ leaf = "windowsIn",    enabled = true, speed = 6,  bezier = "winIn",  style = "slide" })
hl.animation({ leaf = "windowsOut",   enabled = true, speed = 5,  bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove",  enabled = true, speed = 5,  bezier = "wind",   style = "slide" })
hl.animation({ leaf = "border",       enabled = true, speed = 1,  bezier = "liner" })
hl.animation({ leaf = "borderangle",  enabled = true, speed = 30, bezier = "liner",  style = "loop" })
hl.animation({ leaf = "fade",         enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces",   enabled = true, speed = 5,  bezier = "wind" })
