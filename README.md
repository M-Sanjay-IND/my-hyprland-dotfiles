# my-hyprland-dotfiles

Hyprland rice for Arch Linux with a dual-theme system: **macchiato** (Catppuccin Mocha, daily use) and **matrix** (red-on-black, for when the mood calls for it). Theme switching is live with  one click in the bar or shortcut from keyboard and every component updates without restarting anything.

---

## Preview

![preview](screenshots/preview.gif)

---

## Components

| Role | Tool |
|---|---|
| Compositor | Hyprland |
| Bar | Waybar |
| Terminal | Kitty |
| Notification center | sway-notification-center |
| App launcher | Rofi (Wayland) |
| Fetch | Fastfetch |
| Logout screen | wlogout |
| System monitor | btop |
| Wallpaper daemon | awww |
| Lock / idle | hyprlock + hypridle |
| Clipboard | cliphist + wl-paste |

**Font:** JetBrainsMono Nerd Font  
**Icons:** Tela-circle-dracula (included as archive in `assets/`)  
**GTK theme:** Catppuccin Mocha (included as archive in `assets/`)

---

## Installation

> Arch Linux only. Assumes a base bootable system with Hyprland and Kitty already installed.

At the moment there is no automated install script. To replicate this setup manually:

1. Install the packages listed in `packages.txt` via pacman / yay
2. Copy each config folder to the corresponding path in `~/.config/`
3. Copy the scripts in `scripts/` to `~/.local/bin/` and make them executable
4. Extract `assets/icons/Tela-circle-dracula.tar.xz` to `~/.local/share/icons/`
5. Extract `assets/themes/Catppuccin-Mocha.tar.xz` to `~/.local/share/themes/`
6. Log out and back in

To add the BlackArch repository (optional), follow the official instructions at https://blackarch.org/downloads.html#install-repo

An automated install script is planned for a future release.

---

## Theme switching

Switch theme from the bar (click the theme indicator) or directly from a terminal:

```bash
~/.config/waybar/scripts/theme-switch.sh macchiato
~/.config/waybar/scripts/theme-switch.sh matrix
```

The script updates symlinks for Hyprland, Waybar, Kitty, swaync, Rofi and Fastfetch simultaneously. No restart needed.

---

## Wallpapers

Wallpapers are split by theme in `assets/backgrounds/`:

- `whitehat/` — used with macchiato (anime, landscapes, Studio Ghibli)
- `blackhat/` — used with matrix (dark Arch, Uchiha, BlackArch)

The wallpaper picker (`Super + W`) opens a Rofi gallery. You can also set a random wallpaper from the current theme's folder automatically on login.

---

## Keybinds

A cheatsheet overlay is available at any time with `Super + I`. All bindings are defined in `hyprland/conf/keybinds.conf`.

---

## Structure

```
my-hyprland-dotfiles/
├── hyprland/       config, themes, scripts
├── waybar/         bar config, per-module CSS, scripts, themes
├── kitty/          terminal config and themes
├── swaync/         notification center config and themes
├── rofi/           launcher, wallpaper picker, themes
├── fastfetch/      per-theme fetch configs
├── wlogout/        logout screen layout and icons
├── btop/           system monitor config
├── assets/         wallpapers, icon pack, GTK theme archive
└── scripts/        rofi-launcher, rofi-clipboard, rofi-wallpaper
```
