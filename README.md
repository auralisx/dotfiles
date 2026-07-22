# Dotfiles

My personal Linux desktop configuration for Arch Linux.

The repository contains configuration files for my Wayland desktop, terminal, editor, shell, and development tools. It is primarily intended for restoring my setup on a fresh Arch installation.

## Components

### Desktop

* Niri
* Hyprlock
* Hypridle
* Waybar
* Sway Notification Center (swaync)
* Fuzzel
* Ghostty
* GTK themes (`.themes`)

### User Services

Custom `systemd --user` services for:

* Waybar
* NetworkManager applet
* Bluetooth applet
* Polkit agent
* Udiskie
* Wallpaper daemon (`awww`)

### Miscellaneous

* Electron/Chromium flags
* CopyQ configuration
* User shell configuration (`.bashrc`)

## Installation

Clone the repository into your home directory:

```bash
git clone <repository-url> ~/dotfiles
```

Run the installation script:

```bash
cd ~/dotfiles
./install.sh
```

The script installs the required packages, creates backups of existing configuration files, links the dotfiles into place, and enables the required services.

## Notes

* Designed for Arch Linux.
* Intended for personal use.
* Package installation is handled by `pacman` and `paru`.
* Development tooling managed by Nix, Cargo, and npm.
