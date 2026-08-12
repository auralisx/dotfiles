#!/bin/bash

set -Eeuo pipefail
IFS=$'\n\t'

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d%H%M%S)"

# ───────────────────────────────────────────────────────────
# Packages
# ───────────────────────────────────────────────────────────

PACMAN_PACKAGES=(
  # Desktop Env (Wayland)
  niri  xdg-desktop-portal-gtk xdg-desktop-portal-gnome polkit-gnome gnome-keyring gvfs-mtp xwayland-satellite

  # hypridle hyprlock waybar swaync blueman network-manager-applet brightnessctl awww nwg-look
  # Above packages are replaced by Noctalia

  # Desktop Utilities
  noctalia fuzzel reflector wl-clipboard copyq satty bluez bluez-utils networkmanager

  # Audio
  pipewire pipewire-alsa pipewire-jack pipewire-pulse pipewire-zeroconf wireplumber qpwgraph pavucontrol sof-firmware

  # Fonts
  ttf-firacode-nerd woff2-font-awesome noto-fonts-emoji

  # Personal packages
  # Browsers
  firefox-developer-edition vivaldi chromium

  # Dev
  neovim zed tree-sitter-cli opencode npm pnpm nix rustup

  # Terminal and Shell
  ghostty sudo-rs fish eza fzf ripgrep zoxide starship lazygit zellij bat bottom ast-grep
  yazi jq resvg fd imagemagick poppler ouch

  # System
  snapper btrfs-assistant snap-pac
  mpv tlp iptables-nft ufw

  # Misc
  hyprpicker obs-studio
)

# AUR packages
AUR_PACKAGES=(
  beautyline
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
  .themes
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

# Install paru if not present
install_paru() {
  if command -v paru &>/dev/null; then
    echo "paru is already installed."
    return 0
  fi

  echo "Installing paru (AUR helper)..."
  sudo pacman -Sy --needed --noconfirm base-devel git

  local tmp_dir
  tmp_dir=$(mktemp -d)
  git clone "https://aur.archlinux.org/paru.git" "$tmp_dir/paru"
  pushd "$tmp_dir/paru" >/dev/null
  makepkg -si
  popd >/dev/null
  rm -rf "$tmp_dir"
  echo "paru installed successfully."
  echo
}

install_packages() {
  info "Installing pacman packages..."

  sudo pacman -Syu --needed "${PACMAN_PACKAGES[@]}"

  if ((${#AUR_PACKAGES[@]})); then
    info "Installing AUR packages..."
    paru -S --needed "${AUR_PACKAGES[@]}"
  fi
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

    if systemctl list-unit-files | grep -q "^$svc"; then
      sudo systemctl enable --now "$svc"
    else
      echo "Skipping missing service: $svc"
    fi

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

install_npm_packages
install_cargo_packages

info "Setup complete"
