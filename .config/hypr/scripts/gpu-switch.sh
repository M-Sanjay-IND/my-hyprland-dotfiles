#!/usr/bin/env bash
# GPU Mode Switcher for ASUS ROG Zephyrus via supergfxctl

current_mode=$(supergfxctl -g 2>/dev/null || echo "Unknown")
theme_file="$HOME/.config/rofi/config.rasi"

options="🔋 Integrated (Eco: Turn OFF Nvidia GPU · 10+ hrs battery)\n🎮 Hybrid (Gaming: Enable Nvidia RTX 5070 Ti)\n────────────────────────\nCurrent Mode: $current_mode"

chosen=$(echo -e "$options" | rofi -dmenu -p "GPU Mode" -theme "$theme_file")

[ -z "$chosen" ] && exit 0

case "$chosen" in
    *Integrated*)
        if [ "$current_mode" = "Integrated" ]; then
            notify-send -u low -i "battery-good" "GPU Mode" "Already in Integrated (Eco) mode!"
            exit 0
        fi
        res=$(supergfxctl -m Integrated 2>&1)
        notify-send -u critical -i "battery-good" "GPU Switched to Integrated (Eco)" "Nvidia GPU will be powered OFF (0.0W).\nLog out now to complete the switch."
        ;;
    *Hybrid*)
        if [ "$current_mode" = "Hybrid" ]; then
            notify-send -u low -i "video-display" "GPU Mode" "Already in Hybrid mode!"
            exit 0
        fi
        res=$(supergfxctl -m Hybrid 2>&1)
        notify-send -u critical -i "video-display" "GPU Switched to Hybrid" "Nvidia GPU will be enabled for games.\nLog out now to complete the switch."
        ;;
esac
