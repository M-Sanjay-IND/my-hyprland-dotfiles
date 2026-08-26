#!/usr/bin/env bash
# Toggle hypridle on/off and notify the user.

set -euo pipefail

if pgrep -x hypridle &>/dev/null; then
  pkill hypridle
  notify-send -i system-suspend "Idle Inhibitor" "ENABLED — Screen will stay awake (no lock/sleep)"
else
  hypridle &
  disown
  notify-send -i system-shutdown "Idle Inhibitor" "DISABLED — Normal auto-lock & sleep active"
fi

# Aggiorna icona waybar
pkill -SIGRTMIN+8 waybar 2>/dev/null || true
