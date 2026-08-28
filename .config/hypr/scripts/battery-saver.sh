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

    # Disable Hyprland animations & blur to save GPU power
    hyprctl keyword decoration:blur:enabled false 2>/dev/null || true
    hyprctl keyword animations:enabled false 2>/dev/null || true

    # Drop display refresh rate to 60Hz (saves massive power on OLED/IPS)
    hyprctl keyword monitor "eDP-1, preferred@60, auto, 1.25" 2>/dev/null || true

    # Send rich notification
    notify-send -u normal -i "battery-good" "🔋 Ultra Battery Saver" "ENABLED\n• Power Draw Dropped\n• Quiet Profile (Low TDP)\n• 60Hz Display Refresh\n• CPU EPP: Power\n• GPU Blur & RGB OFF"
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

    # Restore Hyprland animations & blur
    hyprctl keyword decoration:blur:enabled true 2>/dev/null || true
    hyprctl keyword animations:enabled true 2>/dev/null || true

    # Restore full high refresh rate
    hyprctl keyword monitor "eDP-1, preferred, auto, 1.25" 2>/dev/null || true

    # Send rich notification
    notify-send -u normal -i "battery-charging" "⚡ Normal Mode Restored" "• Balanced Profile\n• Full High Refresh Rate (120Hz+)\n• Hyprland Animations & Blur ON\n• Keyboard RGB ON"
fi
