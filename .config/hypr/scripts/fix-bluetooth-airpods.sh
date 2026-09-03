#!/usr/bin/env bash
# Optimize BlueZ configuration for Apple AirPods & Fast Handshake

if [ "$(id -u)" -ne 0 ]; then
    echo "Please run with sudo: sudo bash $0"
    exit 1
fi

cat << 'CONF' > /etc/bluetooth/main.conf
[General]
Name = cachyOS
Class = 0x000100
DiscoverableTimeout = 0
AlwaysPairable = true
PairableTimeout = 0
AutoConnectTimeout = 60
FastConnectable = true
JustWorksRepairing = always
AutoEnable = true
ControllerMode = dual
Privacy = device

[Policy]
AutoEnable = true
CONF

systemctl restart bluetooth
echo "✅ BlueZ configured with FastConnectable & dual controller mode for AirPods!"
