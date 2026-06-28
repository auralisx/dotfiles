vim.loader.enable()

local g = vim.g

-- Indicate that a Nerd Font is available (used by plugins for icons)
g.have_nerd_font = true

-- Disable unused language providers to improve startup performance
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Disable aggressive default Markdown syntax rules
g.markdown_recommended_style = 0

local disabled_built_ins = {
	"netrw",
	"gzip",
	"zip",
	"tar",
	"tutor",
}

for _, plugin in ipairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

-- Entry point for Neovim configuration.
-- Core keymap loader. define <leader> and <localleader> keys
g.mapleader = vim.keycode("<space>")
g.maplocalleader = vim.keycode("\\")

-- Core options and settings
require("core.options")
require("core.autocmds")
require("keymaps.editing")
require("keymaps.general")
require("keymaps.navigation")
