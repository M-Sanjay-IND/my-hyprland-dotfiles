#!/usr/bin/env bash
set -euo pipefail

# ── Banner ───────────────────────────────────────────────────────────────────
figlet -f slant "Kernel_x23_6" 2>/dev/null || true
echo "   my-hyprland-dotfiles installer"
echo

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Colors & helpers ─────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
info()  { echo -e "  ${GREEN}✓${NC}  $*"; }
warn()  { echo -e "  ${YELLOW}!${NC}  $*"; }
step()  { echo -e "\n${CYAN}▶ $*${NC}"; }

step "Dotfiles directory: $DOTFILES"

# ── Step 1: Package check ─────────────────────────────────────────────────────
step "1/5  Checking packages"

total=0
missing=()
while IFS= read -r line; do
    [[ "$line" =~ ^[[:space:]]*# || -z "${line// }" ]] && continue
    pkg="${line%%#*}"
    pkg="${pkg//[[:space:]]}"
    [[ -z "$pkg" ]] && continue
    (( total++ )) || true
    pacman -Q "$pkg" &>/dev/null || missing+=("$pkg")
done < "$DOTFILES/packages.txt"

installed=$(( total - ${#missing[@]} ))
echo "  $installed / $total packages already installed"

if [[ ${#missing[@]} -gt 0 ]]; then
    warn "${#missing[@]} missing packages:"
    printf '      %s\n' "${missing[@]}"
    echo
    # yay handles both official repos and AUR — it must be installed first
    # (install it manually from AUR if not present: makepkg -si)
    if ! command -v yay &>/dev/null; then
        warn "yay not found — install it first: https://github.com/Jguer/yay"
        warn "Skipping package install."
    else
        read -rp "  Install missing packages with yay? [y/N] " answer
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            yay -S --needed "${missing[@]}"
        else
            warn "Skipping. Some features may not work."
        fi
    fi
else
    info "All $total packages present."
fi

# ── Symlink helper ────────────────────────────────────────────────────────────
link() {
    local src="$1" dst="$2"
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        info "already linked  $dst"
        return
    fi
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        warn "backing up  $dst → ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi
    [[ -L "$dst" ]] && rm "$dst"
    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    info "linked  $src  →  $dst"
}

# ── Step 2: Config symlinks ───────────────────────────────────────────────────
step "2/5  Symlinking ~/.config dirs"
link "$DOTFILES/.config/hypr"       "$HOME/.config/hypr"
link "$DOTFILES/.config/waybar"     "$HOME/.config/waybar"
link "$DOTFILES/.config/kitty"      "$HOME/.config/kitty"
link "$DOTFILES/.config/swaync"     "$HOME/.config/swaync"
link "$DOTFILES/.config/rofi"       "$HOME/.config/rofi"
link "$DOTFILES/.config/fastfetch"  "$HOME/.config/fastfetch"
link "$DOTFILES/.config/wlogout"    "$HOME/.config/wlogout"
link "$DOTFILES/.config/btop"       "$HOME/.config/btop"
link "$DOTFILES/assets"             "$HOME/.config/assets"

# ── Step 3: Local bin scripts ─────────────────────────────────────────────────
step "3/5  Symlinking ~/.local/bin scripts"
mkdir -p "$HOME/.local/bin"
for script in "$DOTFILES/.local/bin/"*; do
    [[ -f "$script" ]] || continue
    chmod +x "$script"
    link "$script" "$HOME/.local/bin/$(basename "$script")"
done

# ── Step 4: Assets ────────────────────────────────────────────────────────────
step "4/5  Installing icon pack and GTK theme"
mkdir -p "$HOME/.local/share/icons" "$HOME/.local/share/themes"

if [[ ! -d "$HOME/.local/share/icons/Tela-circle-dracula" ]]; then
    echo "  Extracting Tela-circle-dracula icon pack..."
    tar -xf "$DOTFILES/assets/icons/Tela-circle-dracula.tar.xz" \
        -C "$HOME/.local/share/icons/"
    info "icon pack installed → ~/.local/share/icons/Tela-circle-dracula"
else
    info "icon pack already present"
fi

if [[ ! -d "$HOME/.local/share/themes/Catppuccin-Mocha" ]]; then
    echo "  Extracting Catppuccin-Mocha GTK theme..."
    tar -xf "$DOTFILES/assets/themes/Catppuccin-Mocha.tar.xz" \
        -C "$HOME/.local/share/themes/"
    info "GTK theme installed → ~/.local/share/themes/Catppuccin-Mocha"
else
    info "GTK theme already present"
fi

# ── Step 5: Initialize theme ──────────────────────────────────────────────────
step "5/5  Initializing macchiato theme"
echo "  Running theme-switch.sh macchiato (safe outside Hyprland)..."
bash "$DOTFILES/.config/waybar/scripts/theme-switch.sh" macchiato 2>/dev/null || true
info "theme initialized"

echo
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Done! Log out and back in, then:  uwsm start hyprland${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
