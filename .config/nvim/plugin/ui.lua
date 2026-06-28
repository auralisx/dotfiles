-- Enable the new UI
require("vim._core.ui2").enable({})

-- Initialize the statusline module
local statusline = require("features.statusline")
statusline.setup()

vim.pack.add({
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/nvim-mini/mini.tabline",
	"https://github.com/nvim-mini/mini.icons",
})

require("tokyonight").setup({})
vim.cmd.colorscheme("tokyonight-night")
require("mini.tabline").setup()
require("mini.icons").setup()
vim.schedule(MiniIcons.mock_nvim_web_devicons)
vim.schedule(MiniIcons.tweak_lsp_kind)

vim.schedule(function()
	vim.pack.add({
		"https://github.com/nvim-mini/mini.clue",
	})
	local miniclue = require("mini.clue")
	miniclue.setup({
		triggers = {
			-- Leader triggers
			{ mode = { "n", "x" }, keys = "<Leader>" },
			-- `[` and `]` keys
			{ mode = "n", keys = "[" },
			{ mode = "n", keys = "]" },

			-- Built-in completion
			{ mode = "i", keys = "<C-x>" },

			-- `g` key
			{ mode = { "n", "x" }, keys = "g" },

			-- Marks
			{ mode = { "n", "x" }, keys = "'" },
			{ mode = { "n", "x" }, keys = "`" },

			-- Registers
			{ mode = { "n", "x" }, keys = '"' },
			{ mode = { "i", "c" }, keys = "<C-r>" },

			-- Window commands
			{ mode = "n", keys = "<C-w>" },

			-- `z` key
			{ mode = { "n", "x" }, keys = "z" },
		},

		clues = {
			-- Enhance this by adding descriptions for <Leader> mapping groups
			miniclue.gen_clues.square_brackets(),
			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.windows(),
			miniclue.gen_clues.z(),
		},
	})
end)
