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

  # Desktop Utilities (Noctalia replaces waybar/fuzzel/swaync/hypridle/etc.)
  noctalia reflector wl-clipboard copyq satty swayimg adw-gtk-theme

  # Audio
  pavucontrol sof-firmware

  # Fonts
  ttf-firacode-nerd

  # Desktop packages and utilities
  firefox-developer-edition vivaldi chromium mpv hyprpicker obs-studio pacman-contrib rsync

  # Snapshot
  btrfs-assistant snap-pac

  # Terminal and Shell
  ghostty fish eza fzf ripgrep zoxide starship lazygit zellij bat bottom ast-grep
  yazi jq resvg fd imagemagick poppler ouch

  # Dev (languages/runtimes come from mise and nix)
  neovim zed tree-sitter-cli opencode nix mise git-delta
)

# ───────────────────────────────────────────────────────────
# Configuration
# ───────────────────────────────────────────────────────────

CONFIGS=(
  fish
  fuzzel
  ghostty
  niri
  noctalia
  nvim
  systemd
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
  # systemd-boot-update.service
  paccache.timer
  reflector.timer
  # tlp.service
  # snapper-cleanup.timer
  # snapper-timeline.timer
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

# Snapper config for root. If /.snapshots is already a mounted subvolume
# (e.g. @snapshots from fstab), swap it for snapper's own before creating
# the config, then remount it.
setup_snapper() {
  [[ "$(findmnt -no FSTYPE /)" == "btrfs" ]] || return 0
  sudo snapper list-configs | grep -qw root && return 0

  info "Configuring snapper..."

  if findmnt -n /.snapshots >/dev/null; then
    sudo umount /.snapshots
    sudo rmdir /.snapshots
    sudo snapper -c root create-config /
    sudo btrfs subvolume delete /.snapshots
    sudo mkdir /.snapshots
    sudo mount -a
  else
    sudo snapper -c root create-config /
  fi

  sudo chmod 750 /.snapshots

  sudo snapper -c root set-config \
    TIMELINE_LIMIT_HOURLY=5 \
    TIMELINE_LIMIT_DAILY=7 \
    TIMELINE_LIMIT_WEEKLY=0 \
    TIMELINE_LIMIT_MONTHLY=0 \
    TIMELINE_LIMIT_YEARLY=0
}

# ───────────────────────────────────────────────────────────
# Run
# ───────────────────────────────────────────────────────────

[[ -d "$DOTFILES_DIR" ]] || {
  echo "Clone dotfiles to $DOTFILES_DIR first." >&2
  exit 1
}

install_packages
setup_dotfiles
enable_services
setup_snapper

info "Setup complete."
