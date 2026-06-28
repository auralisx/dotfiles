# My Dotfiles (Arch Linux)

This repository contains my **personal dotfiles** for configuring a minimal, beautiful, and functional desktop environment on **Arch Linux**.

> [!CAUTION]
> The install script available in this repo is experimental and intended for personal use only. Do not use it.

| Flag         | Action                                    |
| ------------ | ----------------------------------------- |
| `--packages` | Install Pacman packages                   |
| `--aur`      | Install AUR packages (auto installs paru) |
| `--dotfiles` | Setup dotfiles + backup                   |
| `--services` | Enable & start system services            |
| `--all`      | Run everything                            |

Example:
```bash
./install.sh --all
```

Use only together with `--all`

| Flag            | Effect               |
| --------------- | -------------------- |
| `--no-packages` | Skip pacman packages |
| `--no-aur`      | Skip AUR packages    |
| `--no-dotfiles` | Skip dotfiles        |
| `--no-services` | Skip services        |

Example:
```bash
./install.sh --all --no-aur --no-services
```

> [!IMPORTANT]
> These dotfiles are part of my personal setup journey. Things may break or not work out of the box.

---

