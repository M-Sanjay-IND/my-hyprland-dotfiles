#!/usr/bin/env bash
# Script to enable NVIDIA RTD3 (D3cold 0.0W power cutoff) on Linux

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run with sudo: sudo bash $0"
    exit 1
fi

echo "1. Configuring NVIDIA Dynamic Power Management in /etc/modprobe.d/..."
cat << 'CONF' > /etc/modprobe.d/nvidia-pm.conf
options nvidia "NVreg_DynamicPowerManagement=0x02"
options nvidia "NVreg_PreserveVideoMemoryAllocations=1"
options nvidia "NVreg_TemporaryFilePath=/var/tmp"
CONF

echo "2. Configuring PCIe Runtime Power Management udev rules..."
cat << 'RULES' > /etc/udev/rules.d/80-nvidia-pm.rules
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", ATTR{power/control}="auto"
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", ATTR{power/control}="auto"
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto"
RULES

echo "3. Applying udev rules and reloading..."
udevadm control --reload-rules
udevadm trigger

echo "4. Setting PCI power control to auto..."
echo "auto" > /sys/bus/pci/devices/0000:64:00.0/power/control 2>/dev/null || true
echo "auto" > /sys/bus/pci/devices/0000:64:00.1/power/control 2>/dev/null || true

echo "✅ NVIDIA RTD3 Dynamic Power Management is configured!"
echo "Upon next reboot (or module reload), the RTX 5070 Ti will enter D3cold (0.0W) sleep when on battery."
