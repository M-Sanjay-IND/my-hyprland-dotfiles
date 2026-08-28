#!/usr/bin/env bash
set -e

CONFIG_FILE="/etc/asusd/asusd.ron"

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root: sudo $0"
    exit 1
fi

if [ -f "$CONFIG_FILE" ]; then
    sed -i 's/change_platform_profile_on_battery: true/change_platform_profile_on_battery: false/g' "$CONFIG_FILE"
    sed -i 's/change_platform_profile_on_ac: true/change_platform_profile_on_ac: false/g' "$CONFIG_FILE"
    sed -i 's/disable_nvidia_powerd_on_battery: true/disable_nvidia_powerd_on_battery: false/g' "$CONFIG_FILE"
    systemctl restart asusd.service
    echo "✓ Successfully locked ASUS dGPU & power modes to manual control only!"
else
    echo "Error: $CONFIG_FILE not found"
    exit 1
fi
