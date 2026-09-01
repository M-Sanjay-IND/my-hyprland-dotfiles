#!/usr/bin/env bash

STATE_FILE="/tmp/hypr_battery_saver_state"

if [ ! -f "$STATE_FILE" ]; then
    echo "off" > "$STATE_FILE"
fi

CURRENT_STATE=$(cat "$STATE_FILE")

if [ "$CURRENT_STATE" = "off" ]; then
    # ── 1. Enable Ultra Battery Saver ──────────────────────────────────────────
    echo "on" > "$STATE_FILE"

    # Set ASUS profile to Quiet and power-saver
    asusctl profile set Quiet 2>/dev/null || true
    powerprofilesctl set power-saver 2>/dev/null || true

    # Force AMD CPU energy performance preference to maximum power savings
    for epp in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do
        [ -f "$epp" ] && echo "power" > "$epp" 2>/dev/null || true
    done

    # Turn off keyboard RGB to save power
    asusctl leds set off 2>/dev/null || true

    # Lower brightness to 35% on battery to save ~3 Watts
    brightnessctl set 35% 2>/dev/null || true

    # Send rich notification
    notify-send -u normal -i "battery-good" "🔋 Ultra Battery Saver" "ENABLED\n• Power Draw Minimized\n• Quiet Profile (Low TDP)\n• CPU EPP: Power (Max Efficiency)\n• Screen Brightness: 35%\n• Keyboard RGB: OFF"
else
    # ── 2. Disable & Restore Normal Mode ──────────────────────────────────────
    echo "off" > "$STATE_FILE"

    # Restore ASUS profile to Balanced
    asusctl profile set Balanced 2>/dev/null || true
    powerprofilesctl set balanced 2>/dev/null || true

    # Restore AMD CPU energy performance preference
    for epp in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do
        [ -f "$epp" ] && echo "balance_performance" > "$epp" 2>/dev/null || true
    done

    # Restore keyboard RGB
    asusctl leds set med 2>/dev/null || true

    # Restore brightness
    brightnessctl set 70% 2>/dev/null || true

    # Send rich notification
    notify-send -u normal -i "battery-charging" "⚡ Normal Mode Restored" "• Balanced Profile\n• CPU EPP: Balanced\n• Keyboard RGB ON"
fi
