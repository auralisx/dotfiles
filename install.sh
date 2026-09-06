#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d%H%M%S)"

# ───────────────────────────────────────────────────────────
# Packages
# ───────────────────────────────────────────────────────────

PACMAN_PACKAGES=(
  # Desktop Env (Wayland)
  niri xdg-desktop-portal-gtk xdg-desktop-portal-gnome polkit-gnome gnome-keyring gvfs-mtp xwayland-satellite

  # hypridle hyprlock fuzzel waybar swaync blueman network-manager-applet brightnessctl awww
  # Above packages are replaced by Noctalia

  # Desktop Utilities
  noctalia reflector wl-clipboard copyq satty bluez bluez-utils networkmanager swayimg adw-gtk-theme

  # Audio
  pipewire pipewire-alsa pipewire-jack pipewire-pulse pipewire-zeroconf wireplumber pavucontrol sof-firmware

  # Fonts
  ttf-firacode-nerd woff2-font-awesome noto-fonts-emoji

  # Desktop packages and utilities
  firefox-developer-edition vivaldi chromium snapper btrfs-assistant snap-pac mpv tlp iptables-nft ufw hyprpicker obs-studio pacman-contrib

  # Terminal and Shell
  ghostty fish eza fzf ripgrep zoxide starship lazygit zellij bat bottom ast-grep
  yazi jq resvg fd imagemagick poppler ouch

  # Dev
  neovim zed tree-sitter-cli opencode npm pnpm nix rustup mise

)

# ───────────────────────────────────────────────────────────
# Configuration
# ───────────────────────────────────────────────────────────

CONFIGS=(
  fish
  fuzzel
  ghostty
  # hypr
  niri
  noctalia
  nvim
  # swaync
  systemd
  # waybar
  xdg-desktop-portal
  yazi
  zellij
  code-flags.conf
  electron-flags.conf
)

HOME_FILES=(
  .bashrc
)

SYSTEM_SERVICES=(
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

NPM_PACKAGES=(
)

CARGO_PACKAGES=(
)

info() {
  printf "\n==> %s\n" "$*"
}

# ───────────────────────────────────────────────────────────
# Functions
# ───────────────────────────────────────────────────────────

install_packages() {
  info "Installing pacman packages..."

  sudo pacman -Syu --needed "${PACMAN_PACKAGES[@]}"
}

backup_and_link() {

  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  if [[ -e "$dst" || -L "$dst" ]]; then
    mkdir -p "$BACKUP_DIR"

    mv "$dst" "$BACKUP_DIR/"
  fi

  ln -sfn "$src" "$dst"
}

setup_dotfiles() {

  info "Linking dotfiles..."

  for item in "${CONFIGS[@]}"; do
    backup_and_link \
      "$DOTFILES_DIR/.config/$item" \
      "$HOME/.config/$item"
  done

  for item in "${HOME_FILES[@]}"; do
    backup_and_link \
      "$DOTFILES_DIR/$item" \
      "$HOME/$item"
  done
}

enable_services() {

  info "Enabling services..."

  for svc in "${SYSTEM_SERVICES[@]}"; do

    sudo systemctl enable --now "$svc"

  done
}

install_npm_packages() {

  ((${#NPM_PACKAGES[@]})) || return

  info "Installing global npm packages..."

  npm install -g "${NPM_PACKAGES[@]}"
}

install_cargo_packages() {

  ((${#CARGO_PACKAGES[@]})) || return

  info "Installing cargo packages..."

  cargo install "${CARGO_PACKAGES[@]}"
}

install_packages
setup_dotfiles
enable_services

# install_npm_packages
# install_cargo_packages

info "Setup complete"
