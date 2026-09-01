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

    # Adjust screen brightness to comfortable battery level (40%)
    brightnessctl set 40% 2>/dev/null || true

    # Send on-screen confirmation
    notify-send -u low -i "battery-good" "🔋 Running on Battery" "Switched to Ultra Eco Mode\n• Quiet Profile (Low TDP)\n• CPU EPP: Power\n• Keyboard RGB: OFF"
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

    # Restore screen brightness
    brightnessctl set 80% 2>/dev/null || true

    # Send on-screen confirmation
    notify-send -u low -i "battery-charging" "⚡ Connected to Charger" "Switched to Beast Performance Mode\n• Performance Profile (Max TDP)\n• Full CPU Boost Unlocked\n• Keyboard RGB: ON"
fi
