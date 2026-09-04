#!/usr/bin/env bash
# ==============================================================================
#  Complete Arch Linux Post-Install Setup Script for ASUS ROG Zephyrus
#  Restores: Hyprland, Waybar, Catppuccin/Matrix themes, Neovim, ASUS ROG power
# ==============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🚀 Starting Arch Linux Automated Desktop Setup..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 1. Update system & install base development tools
echo ":: 1/7 Updating system packages..."
sudo pacman -Syu --needed --noconfirm base-devel git curl wget linux-headers

# 2. Install Paru (AUR helper) if missing
if ! command -v paru >/dev/null 2>&1; then
    echo ":: 2/7 Installing Paru AUR helper..."
    git clone https://aur.archlinux.org/paru-bin.git /tmp/paru-bin
    (cd /tmp/paru-bin && makepkg -si --noconfirm)
    rm -rf /tmp/paru-bin
fi

# 3. Install core Hyprland desktop environment & audio stack
echo ":: 3/7 Installing Hyprland desktop environment..."
sudo pacman -S --needed --noconfirm \
    hyprland xorg-xwayland aquamarine \
    waybar kitty rofi-wayland swaync \
    brightnessctl pamixer pavucontrol \
    cliphist wl-clipboard \
    pipewire wireplumber pipewire-pulse pipewire-alsa pipewire-jack \
    polkit-kde-agent network-manager-applet \
    ttf-jetbrains-mono-nerd noto-fonts noto-fonts-cjk noto-fonts-emoji \
    zsh yazi fastfetch btop neovim ripgrep fd fzf

# 4. Install AUR utilities and ASUS Zephyrus tools
echo ":: 4/7 Installing ASUS ROG Zephyrus & power tools from AUR..."
paru -S --needed --noconfirm \
    asusctl supergfxd rog-control-center-bin \
    power-profiles-daemon awww \
    cava bluetuith-bin wlogout

# 5. Enable hardware daemons
echo ":: 5/7 Enabling system services..."
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now asusd.service
sudo systemctl enable --now supergfxd.service
sudo systemctl enable --now power-profiles-daemon.service

# 6. Deploy dotfiles
echo ":: 6/7 Deploying dotfiles to ~/.config and ~/.local/bin..."
mkdir -p "$HOME/.config" "$HOME/.local/bin"

# Copy configurations
cp -r "$DOTFILES_DIR/.config/"* "$HOME/.config/"
cp -r "$DOTFILES_DIR/.local/bin/"* "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/"*
chmod +x "$HOME/.config/hypr/scripts/"*

# 7. Set default shell to ZSH if not already
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    echo ":: Setting ZSH as default shell..."
    chsh -s /usr/bin/zsh "$USER" 2>/dev/null || true
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ Arch Linux Hyprland Setup Complete!"
echo "  Restart your machine or run 'Hyprland' to enter your desktop."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
