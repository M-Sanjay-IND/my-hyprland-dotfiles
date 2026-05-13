#!/usr/bin/env bash
set -euo pipefail

# ── Banner ───────────────────────────────────────────────────────────────────
figlet -f slant "Kernel_x23_6" 2>/dev/null || true
echo "   my-hyprland-dotfiles installer"
echo

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Colors ───────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
info()  { echo -e "${GREEN}[info]${NC}  $*"; }
warn()  { echo -e "${YELLOW}[warn]${NC}  $*"; }

# ── 1. Package check ──────────────────────────────────────────────────────────
info "Checking packages..."
missing=()
while IFS= read -r line; do
    [[ "$line" =~ ^[[:space:]]*# || -z "${line// }" ]] && continue
    pkg="${line%%#*}"
    pkg="${pkg//[[:space:]]}"
    [[ -z "$pkg" ]] && continue
    pacman -Q "$pkg" &>/dev/null || missing+=("$pkg")
done < "$DOTFILES/packages.txt"

if [[ ${#missing[@]} -gt 0 ]]; then
    warn "${#missing[@]} missing packages:"
    printf '  %s\n' "${missing[@]}"
    echo
    read -rp "Install with yay now? [y/N] " answer
    [[ "$answer" =~ ^[Yy]$ ]] && yay -S --needed "${missing[@]}" \
        || warn "Skipping package install — some features may not work."
else
    info "All packages present."
fi

# ── 2. Symlink helper ─────────────────────────────────────────────────────────
link() {
    local src="$1" dst="$2"
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        info "OK     $dst"
        return
    fi
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        warn "Backup $dst → ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi
    [[ -L "$dst" ]] && rm "$dst"
    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    info "Linked $dst"
}

# ── 3. Config symlinks ────────────────────────────────────────────────────────
info "Symlinking config dirs..."
link "$DOTFILES/.config/hypr"       "$HOME/.config/hypr"
link "$DOTFILES/.config/waybar"     "$HOME/.config/waybar"
link "$DOTFILES/.config/kitty"      "$HOME/.config/kitty"
link "$DOTFILES/.config/swaync"     "$HOME/.config/swaync"
link "$DOTFILES/.config/rofi"       "$HOME/.config/rofi"
link "$DOTFILES/.config/fastfetch"  "$HOME/.config/fastfetch"
link "$DOTFILES/.config/wlogout"    "$HOME/.config/wlogout"
link "$DOTFILES/.config/btop"       "$HOME/.config/btop"
link "$DOTFILES/assets"             "$HOME/.config/assets"

# ── 4. Local bin scripts ──────────────────────────────────────────────────────
info "Symlinking ~/.local/bin scripts..."
mkdir -p "$HOME/.local/bin"
for script in "$DOTFILES/.local/bin/"*; do
    [[ -f "$script" ]] || continue
    chmod +x "$script"
    link "$script" "$HOME/.local/bin/$(basename "$script")"
done

# ── 5. Assets: icon pack + GTK theme ─────────────────────────────────────────
info "Installing assets..."
mkdir -p "$HOME/.local/share/icons" "$HOME/.local/share/themes"

if [[ ! -d "$HOME/.local/share/icons/Tela-circle-dracula" ]]; then
    tar -xf "$DOTFILES/assets/icons/Tela-circle-dracula.tar.xz" \
        -C "$HOME/.local/share/icons/"
    info "Icon pack installed."
else
    info "Icon pack already present."
fi

if [[ ! -d "$HOME/.local/share/themes/Catppuccin-Mocha" ]]; then
    tar -xf "$DOTFILES/assets/themes/Catppuccin-Mocha.tar.xz" \
        -C "$HOME/.local/share/themes/"
    info "GTK theme installed."
else
    info "GTK theme already present."
fi

# ── 6. Initialize theme ───────────────────────────────────────────────────────
info "Initializing macchiato theme..."
bash "$DOTFILES/.config/waybar/scripts/theme-switch.sh" macchiato 2>/dev/null || true

echo
info "Done. Log out and back in (or: uwsm start hyprland) to launch Hyprland."
