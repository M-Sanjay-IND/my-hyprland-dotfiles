#!/bin/bash
# theme-switch.sh <macchiato|matrix>
theme="${1:-macchiato}"

export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

# Cartella wallpaper e avatar per il tema
case "$theme" in
    matrix)
        wall_dir="$HOME/.config/assets/backgrounds/blackhat"
        avatar="$HOME/.config/assets/backgrounds/my-avatar-blackhat-transparent.png"
        lock_wall="$HOME/.config/assets/backgrounds/hack-the-planet-red.png"
        lock_accent="ff3131"
        lock_inner="1a0505"
        lock_label_valign="top"
        lock_time_pos="-100, -80"
        lock_name_pos="-100, -230"
        lock_input_valign="center"
        lock_input_pos="35, -25"
        ;;
    *)
        wall_dir="$HOME/.config/assets/backgrounds/whitehat"
        avatar="$HOME/.config/assets/backgrounds/my-avatar-whitehat.png"
        lock_accent="b7bdf8"
        lock_inner="1e2030"
        lock_label_valign="bottom"
        lock_time_pos="-100, 80"
        lock_name_pos="-100, 230"
        lock_input_valign="bottom"
        lock_input_pos="30, 150"
        ;;
esac
# Fallback avatar se quello specifico non esiste ancora
[[ -f "$avatar" ]] || avatar="$HOME/.config/assets/backgrounds/my-avatar.png"

# ── Symlinks e file (tutti prima di qualsiasi segnale) ──────────────────────
ln -sf "$HOME/.config/waybar/themes/${theme}.css"     "$HOME/.config/waybar/theme.css"
ln -sf "$HOME/.config/fastfetch/config-${theme}.jsonc" "$HOME/.config/fastfetch/config.jsonc"
ln -sf "$HOME/.config/rofi/colors-${theme}.rasi"      "$HOME/.config/rofi/colors.rasi"
ln -sf "$HOME/.config/kitty/themes/${theme}.conf"     "$HOME/.config/kitty/theme.conf"
ln -sf "$HOME/.config/swaync/themes/${theme}.css"     "$HOME/.config/swaync/theme.css"
rm -f "$HOME/.config/swaync/style.css"
cp "$HOME/.config/swaync/themes/${theme}.css"         "$HOME/.config/swaync/style.css"
ln -sf "$HOME/.config/hypr/themes/${theme}.conf"      "$HOME/.config/hypr/theme.conf"
printf '%s' "$wall_dir" > "$HOME/.config/rofi/.wall_dir"

# Wallpaper random dalla cartella del tema
wall=$(find "$wall_dir" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    | shuf -n1)

if [[ -n "$wall" ]]; then
    ln -sf "$wall" "$HOME/.config/rofi/.current_wallpaper"
    # setsid: distacca awww dal processo figlio di waybar — sopravvive al SIGUSR2
    setsid awww img "$wall" \
        --transition-type random --transition-fps 255 --transition-duration 0.8 \
        >/tmp/theme-switch.log 2>&1 &
    # Aggiorna wallpaper e avatar di hyprlock
    sed -i "/^background {/,/^}/ s|^\( *path = \).*|\1${lock_wall:-$wall}|" "$HOME/.config/hypr/hyprlock.conf"
fi
sed -i "s|^\( *path = \).*my-avatar.*|\1$avatar|" "$HOME/.config/hypr/hyprlock.conf"
sed -i "/^input-field {/,/^}/ s|^\( *outer_color = \).*|\1rgb($lock_accent)|" "$HOME/.config/hypr/hyprlock.conf"
sed -i "/^input-field {/,/^}/ s|^\( *inner_color = \).*|\1rgb($lock_inner)|" "$HOME/.config/hypr/hyprlock.conf"
sed -i "/^input-field {/,/^}/ s|^\( *font_color = \).*|\1rgb($lock_accent)|" "$HOME/.config/hypr/hyprlock.conf"
sed -i "/^input-field {/,/^}/ s|^\( *position = \).*|\1$lock_input_pos|" "$HOME/.config/hypr/hyprlock.conf"
sed -i "/^input-field {/,/^}/ s|^\( *valign = \).*|\1$lock_input_valign|" "$HOME/.config/hypr/hyprlock.conf"
sed -i "/^label {/,/^}/ s|^\( *color = \).*|\1rgb($lock_accent)|" "$HOME/.config/hypr/hyprlock.conf"
sed -i "/text = cmd.*TIME/,/^}/ s|^\( *position = \).*|\1$lock_time_pos|" "$HOME/.config/hypr/hyprlock.conf"
sed -i "/text = Kernel_x23_6/,/^}/ s|^\( *position = \).*|\1$lock_name_pos|" "$HOME/.config/hypr/hyprlock.conf"
sed -i "/^label {/,/^}/ s|^\( *valign = \).*|\1$lock_label_valign|" "$HOME/.config/hypr/hyprlock.conf"
sed -i "/^image {/,/^}/ s|^\( *border_color = \).*|\1rgb($lock_accent)|" "$HOME/.config/hypr/hyprlock.conf"

# ── Reload/restart processes ────────────────────────────────────────────────
hyprctl reload >/tmp/hypr-theme-switch.log 2>&1 || true
pkill -SIGUSR1 -x kitty 2>/dev/null || true
setsid "$HOME/.config/swaync/restart" >/tmp/swaync-theme-switch.log 2>&1 &

# Waybar reload stays last because this script is launched by Waybar itself.
killall -SIGUSR2 waybar
