# Neovim Configuration

A lightweight, modular Neovim configuration focused on a fast startup, sensible defaults, and an IDE-like experience without unnecessary complexity.

## Features

* Native Neovim APIs where possible
* Built-in LSP support
* Treesitter for syntax highlighting
* Autocompletion
* Formatting and diagnostics
* Git integration
* AI-assisted development
* Custom statusline
* Markdown enhancements

## Directory Structure

```text
.
├── after/
│   └── ftplugin/      # Filetype-specific settings
├── lua/
│   ├── core/          # Core editor configuration
│   ├── features/      # Custom features (eg. custom statusline)
│   └── keymaps/       # Key mappings
├── plugin/            # Plugin specifications and setup
├── init.lua           # Entry point
└── nvim-pack-lock.json
```

## Configuration Layout

### Core

Contains the editor's fundamental configuration.

* Options
* Autocommands
* General editor behavior

### Keymaps

Key bindings are grouped by purpose instead of being placed in a single file.

* General
* Navigation
* Editing

### Plugins

Each plugin or feature has its own configuration file, making the setup easier to maintain and modify.

Examples include:

* LSP
* Completion
* Treesitter
* Git
* Diagnostics
* Formatting
* UI
* AI

## Philosophy

This configuration aims to:

* Stay modular and easy to navigate.
* Prefer Neovim built-in functionality when practical.
* Keep plugin configurations isolated.
* Avoid unnecessary abstractions.
* Make adding or removing plugins straightforward.
