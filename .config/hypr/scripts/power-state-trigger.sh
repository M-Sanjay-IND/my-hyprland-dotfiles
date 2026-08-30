#!/usr/bin/env bash

MODE="${1:-}"

# Auto-detect if no argument provided
if [ -z "$MODE" ]; then
    if grep -q "1" /sys/class/power_supply/AC*/online 2>/dev/null || grep -q "1" /sys/class/power_supply/ACAD/online 2>/dev/null; then
        MODE="ac"
    else
        MODE="battery"
    fi
fi

if [ "$MODE" = "battery" ]; then
    # ── 🔋 1. ON BATTERY: Maximum Power Saving (8-10+ Hrs) ─────────────────────
    asusctl profile set Quiet 2>/dev/null || true
    powerprofilesctl set power-saver 2>/dev/null || true

    # Force AMD CPU energy performance preference to 'power'
    for epp in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do
        [ -f "$epp" ] && echo "power" > "$epp" 2>/dev/null || true
    done

    # Turn off keyboard RGB backlight
    asusctl leds set off 2>/dev/null || true

    # Disable Hyprland animations & blur to eliminate GPU wakeups
    hyprctl keyword decoration:blur:enabled false 2>/dev/null || true
    hyprctl keyword animations:enabled false 2>/dev/null || true

    # Switch display to 60Hz (saves ~4 Watts of panel power)
    hyprctl keyword monitor "eDP-1, preferred@60, auto, 1.25" 2>/dev/null || true

    # Send on-screen confirmation
    notify-send -u low -i "battery-good" "🔋 Running on Battery" "Switched to Ultra Eco Mode\n• 60Hz OLED Refresh\n• Quiet Profile (Low TDP)\n• CPU EPP: Power\n• Blur & RGB: OFF"
else
    # ── ⚡ 2. ON CHARGER: Maximum Beast Performance ─────────────────────────────
    asusctl profile set Performance 2>/dev/null || true
    powerprofilesctl set performance 2>/dev/null || true

    # Force AMD CPU energy performance preference to 'performance'
    for epp in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do
        [ -f "$epp" ] && echo "performance" > "$epp" 2>/dev/null || true
    done

    # Restore keyboard RGB backlight
    asusctl leds set med 2>/dev/null || true

    # Restore full Hyprland animations & glassmorphism blur
    hyprctl keyword decoration:blur:enabled true 2>/dev/null || true
    hyprctl keyword animations:enabled true 2>/dev/null || true

    # Restore full native high refresh rate (120Hz / 240Hz)
    hyprctl keyword monitor "eDP-1, preferred, auto, 1.25" 2>/dev/null || true

    # Send on-screen confirmation
    notify-send -u low -i "battery-charging" "⚡ Connected to Charger" "Switched to Beast Performance Mode\n• Full High-Refresh Rate (120Hz+)\n• Performance Profile (Max TDP)\n• Full CPU Boost Unlocked\n• Blur & Animations: ON"
fi
