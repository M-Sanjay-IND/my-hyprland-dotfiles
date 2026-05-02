#!/bin/bash
# keybind-help.sh — floating cheat sheet (SUPER+I)
# Edit this file to update the cheatsheet: ~/.config/hypr/scripts/keybind-help.sh

R=$'\e[0m'; B=$'\e[1m'
TEXT=$'\e[38;2;202;211;245m'
SUB=$'\e[38;2;165;173;203m'
LAV=$'\e[38;2;183;189;248m'
GREEN=$'\e[38;2;166;218;149m'
PEACH=$'\e[38;2;245;169;127m'
SURF=$'\e[38;2;73;77;100m'
YEL=$'\e[38;2;238;212;159m'

TOP=$(printf '═%.0s' {1..74})
DIV=$(printf '─%.0s' {1..76})

sec() { printf "\n  ${B}${PEACH}◈  %s${R}\n  ${SURF}${DIV}${R}\n" "$1"; }
# key strings must be pure ASCII — Unicode chars break printf %-Ns byte-vs-cell counting
row() { printf "  ${GREEN}%-26s${R}  ${TEXT}%s${R}\n" "$1" "$2"; }

host=$(hostname)
pad=$(( 54 - ${#host} ))

main() {
printf "\n"
printf "  ${B}${LAV}╔${TOP}╗${R}\n"
printf "  ${B}${LAV}║${R}  ${B}${TEXT}SUPER CHEATSHEET${R}%${pad}s${SUB}%s${R}  ${B}${LAV}║${R}\n" "" "$host"
printf "  ${B}${LAV}╚${TOP}╝${R}\n"

sec "APPS"
row "SUPER + T"                "Terminal (kitty)"
row "SUPER + B"                "Browser (firefox)"
row "SUPER + SHIFT + B"        "Browser pentest (clean profile)"
row "SUPER + O"                "Notes (obsidian)"
row "SUPER + V"                "Editor (vscodium)"
row "SUPER + ALT + V"          "Editor alt (cursor)"
row "SUPER + F"                "File manager (yazi)"
row "SUPER + A"                "App launcher (rofi)"
row "SUPER + SHIFT + A"        "Emoji picker"
row "SUPER + P"                "Color picker"
row "SUPER + SHIFT + P"        "Toggle idle inhibitor (hypridle)"

sec "WINDOWS"
row "SUPER + Q"                "Close window"
row "SUPER + W"                "Toggle floating"
row "SUPER + SPACE"            "Center window"
row "SUPER + M"                "Float preset: minimize (1100x720)"
row "SUPER + SHIFT + M"        "Float preset: maximize (1500x820)"
row "SUPER + J"                "Toggle split"
row "SUPER + SHIFT + F"        "Fullscreen (real)"
row "SUPER + ALT + F"          "Fake fullscreen"
row "ALT + TAB"                "Cycle windows (prev)"
row "ALT + SHIFT + TAB"        "Cycle windows (next)"
row "SUPER + Arrows"           "Move focus"
row "SUPER + SHIFT + Arrows"   "Move window in layout"
row "SUPER + CTRL + Arrows"    "Resize window"

sec "WORKSPACES"
row "SUPER + 1-9"              "Switch workspace"
row "SUPER + SHIFT + 1-9"      "Move window + follow"
row "SUPER + CTRL + 1-9"       "Move window (silent)"
row "SUPER + TAB"              "Next workspace"
row "SUPER + SHIFT + TAB"      "Previous workspace"
row "SUPER + S"                "Toggle scratchpad"
row "SUPER + SHIFT + S"        "Move to scratchpad"

sec "SYSTEM"
row "SUPER + N"                "Notification center (swaync)"
row "SUPER + L"                "Lock screen (hyprlock)"
row "SUPER + ESC"              "Logout menu (wlogout)"
row "CTRL + ESC"               "Toggle waybar"
row "SUPER + SHIFT + W"        "Wallpaper picker (rofi)"

sec "SCREENSHOT"
row "Print"                    "Full screen"
row "SUPER + Print"            "Active window"
row "SUPER + ALT + Print"      "Area select"
row "SUPER + SHIFT + Print"    "Area -> edit (swappy)"

sec "MEDIA"
row "XF86AudioRaise / Lower"   "Volume up / down"
row "XF86AudioMute"            "Mute toggle"
row "XF86AudioMicMute"         "Mic mute"
row "XF86AudioPlay"            "Play / Pause"
row "XF86AudioNext / Prev"     "Next / previous track"
row "XF86Brightness + / -"     "Brightness up / down"

sec "THEMES & RICING"
row "SUPER + I"                "This cheatsheet"
row "SUPER + SHIFT + I"        "Blackhat theme"
row "SUPER + CTRL + I"         "Whitehat theme"

printf "\n  ${SURF}${DIV}${R}\n"
printf "  ${SUB}Press  ${B}${YEL}q${R}${SUB}  to close${R}\n\n"
}

main | LESS='-R -~' less
