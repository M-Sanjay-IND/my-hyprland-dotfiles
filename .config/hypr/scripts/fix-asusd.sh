#!/usr/bin/env bash
set -e

CONFIG_FILE="/etc/asusd/asusd.ron"

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root: sudo $0"
    exit 1
fi

if [ -f "$CONFIG_FILE" ]; then
    sed -i 's/change_platform_profile_on_battery: .*/change_platform_profile_on_battery: true,/g' "$CONFIG_FILE"
    sed -i 's/change_platform_profile_on_ac: .*/change_platform_profile_on_ac: true,/g' "$CONFIG_FILE"
    sed -i 's/platform_profile_on_battery: .*/platform_profile_on_battery: Quiet,/g' "$CONFIG_FILE"
    sed -i 's/platform_profile_on_ac: .*/platform_profile_on_ac: Performance,/g' "$CONFIG_FILE"
    sed -i 's/platform_profile_linked_epp: .*/platform_profile_linked_epp: true,/g' "$CONFIG_FILE"
    sed -i 's|ac_command: .*|ac_command: "/home/sanjaym/.config/hypr/scripts/power-state-trigger.sh ac",|g' "$CONFIG_FILE"
    sed -i 's|bat_command: .*|bat_command: "/home/sanjaym/.config/hypr/scripts/power-state-trigger.sh battery",|g' "$CONFIG_FILE"
    systemctl restart asusd.service
    systemctl enable --now supergfxd.service
    echo "✓ Successfully enabled automatic AC Performance & Battery Eco switching!"
else
    echo "Error: $CONFIG_FILE not found"
    exit 1
fi
