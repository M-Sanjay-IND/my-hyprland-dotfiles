#!/usr/bin/env bash
# Real-time Hardware AC/Battery Watcher for ASUS ROG Zephyrus

LAST_STATE=""

while true; do
    # Check if AC adapter is online
    if [ -f "/sys/class/power_supply/ACAD/online" ]; then
        IS_ONLINE=$(cat /sys/class/power_supply/ACAD/online 2>/dev/null)
    elif [ -f "/sys/class/power_supply/AC0/online" ]; then
        IS_ONLINE=$(cat /sys/class/power_supply/AC0/online 2>/dev/null)
    else
        IS_ONLINE="0"
    fi

    if [ "$IS_ONLINE" = "1" ]; then
        CURRENT_STATE="ac"
    else
        CURRENT_STATE="battery"
    fi

    if [ "$CURRENT_STATE" != "$LAST_STATE" ]; then
        if [ "$CURRENT_STATE" = "battery" ]; then
            # ── 🔋 ON BATTERY (Ultra Power Saving Mode) ────────────────────────
            asusctl profile set Quiet 2>/dev/null || true
            powerprofilesctl set power-saver 2>/dev/null || true

            # Set all AMD CPU cores to maximum energy efficiency ('power')
            for epp in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do
                [ -f "$epp" ] && echo "power" > "$epp" 2>/dev/null || true
            done

            # Turn off keyboard RGB to save battery
            asusctl leds set off 2>/dev/null || true

            # Set screen brightness to comfortable power-saving level (35%)
            brightnessctl set 35% 2>/dev/null || true

            notify-send -u normal -i "battery-good" "🔋 Running on Battery" "Switched to Ultra Eco Mode\n• Quiet Profile (Low TDP)\n• CPU EPP: Power (Max Efficiency)\n• Screen Brightness: 35%\n• Keyboard RGB: OFF"
        else
            # ── ⚡ ON CHARGER (Beast Performance Mode) ─────────────────────────
            asusctl profile set Performance 2>/dev/null || true
            powerprofilesctl set performance 2>/dev/null || true

            # Set all AMD CPU cores to high performance
            for epp in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do
                [ -f "$epp" ] && echo "performance" > "$epp" 2>/dev/null || true
            done

            # Restore keyboard RGB
            asusctl leds set med 2>/dev/null || true

            # Restore screen brightness
            brightnessctl set 80% 2>/dev/null || true

            notify-send -u normal -i "battery-charging" "⚡ Connected to Charger" "Switched to Beast Performance Mode\n• Performance Profile (Max TDP)\n• CPU EPP: Performance (Full Boost)\n• Screen Brightness: 80%\n• Keyboard RGB: ON"
        fi
        LAST_STATE="$CURRENT_STATE"
    fi

    # Check power state every 3 seconds
    sleep 3
done
