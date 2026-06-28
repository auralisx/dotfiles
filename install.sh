#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/old_config_$(date +%Y%m%d%H%M%S)"

# ───────────────────────────────────────────────────────────
# Packages
# ───────────────────────────────────────────────────────────

PACMAN_PACKAGES=(
    # System packages
    niri hypridle hyprlock xdg-desktop-portal-gtk xdg-desktop-portal-gnome polkit-gnome gnome-keyring gvfs-mtp xwayland-satellite
    pipewire pipewire-alsa pipewire-jack pipewire-pulse pipewire-zeroconf wireplumber qpwgraph pavucontrol sof-firmware
    waybar swaync bluez bluez-utils blueman networkmanager network-manager-applet brightnessctl fuzzel reflector wl-clipboard
    ttf-firacode-nerd woff2-font-awesome noto-fonts-emoji

    # Personal packages
    firefox-developer-edition vivaldi
    hyprpicker
    neovim zed biome tree-sitter-cli opencode
    copyq satty obs-studio awww
    ghostty
    sudo-rs
    fish exa fzf ripgrep zoxide starship lazygit zellij bat bottom ast-grep
    yazi 7zip jq resvg fd imagemagick poppler
    mpv
    tlp
    snapper btrfs-assistant snap-pac
    npm
    nwg-look
    iptables-nft ufw
    nix
)

# AUR packages
AUR_PACKAGES=(
    beautyline
)

# ───────────────────────────────────────────────────────────
# Configuration
# ───────────────────────────────────────────────────────────

# Congigurations under .config folder
CONFIG_FOLDER=(
    "fish"
    "fuzzel"
    "ghostty"
    "hypr"
    "niri"
    "nvim"
    "swaync"
    "systemd"
    "waybar"
    "xdg-desktop-portal"
    "yazi"
    "zellij"
    "code-flags.conf"
    "electron-flags.conf"
)

# Configurations under home directory
HOME_DIR=(
    ".bashrc"
    ".themes"
)

# ----------------------------------------------------------
# Flags
# ----------------------------------------------------------

RUN_PACKAGES=false
RUN_AUR=false
RUN_DOTFILES=false
RUN_SERVICES=false

SKIP_PACKAGES=false
SKIP_AUR=false
SKIP_DOTFILES=false
SKIP_SERVICES=false

# ----------------------------------------------------------
# Argument parser
# ----------------------------------------------------------

for arg in "$@"; do
    case "$arg" in
        --all) RUN_PACKAGES=true; RUN_AUR=true; RUN_DOTFILES=true; RUN_SERVICES=true ;;
        --packages) RUN_PACKAGES=true ;;
        --aur) RUN_AUR=true ;;
        --dotfiles) RUN_DOTFILES=true ;;
        --services) RUN_SERVICES=true ;;
        --no-packages) SKIP_PACKAGES=true ;;
        --no-aur) SKIP_AUR=true ;;
        --no-dotfiles) SKIP_DOTFILES=true ;;
        --no-services) SKIP_SERVICES=true ;;
    esac
done

# Apply skip flags
$SKIP_PACKAGES && RUN_PACKAGES=false
$SKIP_AUR && RUN_AUR=false
$SKIP_DOTFILES && RUN_DOTFILES=false
$SKIP_SERVICES && RUN_SERVICES=false

# If nothing is chosen, show usage
if ! $RUN_PACKAGES && ! $RUN_AUR && ! $RUN_DOTFILES && ! $RUN_SERVICES; then
    echo "Usage: $0 [--all] [--packages] [--aur] [--dotfiles] [--services]"
    echo "       Add --no-* to skip sections when using --all."
    exit 1
fi

# ───────────────────────────────────────────────────────────
# Functions
# ───────────────────────────────────────────────────────────

# Install paru if not present
install_paru() {
    if command -v paru &> /dev/null; then
        echo "paru is already installed."
        return 0
    fi

    echo "Installing paru (AUR helper)..."
    sudo pacman -Sy --needed --noconfirm base-devel git

    local tmp_dir
    tmp_dir=$(mktemp -d)
    git clone "https://aur.archlinux.org/paru.git" "$tmp_dir/paru"
    pushd "$tmp_dir/paru" > /dev/null
        makepkg -si
    popd > /dev/null
    rm -rf "$tmp_dir"
    echo "paru installed successfully."
    echo
}

install_pacman_packages() {
    sudo pacman -Sy "${PACMAN_PACKAGES[@]}"
    echo
}

install_aur_packages() {
    paru -S "${AUR_PACKAGES[@]}"
    echo
}

backup_and_link() {
    local source="$1" destination="$2"
    if [ -e "$destination" ] || [ -L "$destination" ]; then
        echo "Backing up existing $destination to $BACKUP_DIR/"
        mkdir -p "$BACKUP_DIR"
        # Preserve symlinks with -P
        cp -rLP "$destination" "$BACKUP_DIR/"
        rm -rf "$destination"
        echo "Backup created: $BACKUP_DIR/$(basename "$destination")"
        echo
    fi
    ln -sf "$source" "$destination"
    echo
}

setup_dotfiles() {
    echo "Setting up dotfiles..."
    for item in "${CONFIG_FOLDER[@]}"; do
        backup_and_link "$DOTFILES_DIR/.config/$item" "$HOME/.config/$item"
    done
    for item in "${HOME_DIR[@]}"; do
        backup_and_link "$DOTFILES_DIR/$item" "$HOME/$item"
    done
    echo
}

enable_services() {
    local services=(
        bluetooth.service
        systemd-boot-update.service
        paccache.timer
        reflector.timer
        fstrim.timer
        tlp.service
        snapper-cleanup.timer
        snapper-timeline.timer
        ufw.service
    )

    for svc in "${services[@]}"; do
        systemctl enable --now "$svc" || true
    done
}

# ----------------------------------------------------------
# Run selected tasks
# ----------------------------------------------------------

$RUN_PACKAGES && install_pacman_packages
$RUN_AUR && install_paru && install_aur_packages
$RUN_DOTFILES && setup_dotfiles
$RUN_SERVICES && enable_services

echo "Finished."
