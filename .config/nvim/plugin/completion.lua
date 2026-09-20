vim.pack.add({
	"https://github.com/saghen/blink.lib",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/mikavilpas/blink-ripgrep.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/b0o/SchemaStore.nvim",
	"https://github.com/rachartier/tiny-code-action.nvim",
})

local cmp = require("blink.cmp")
cmp.build():pwait()

vim.schedule(function()
	require("blink.cmp").setup({
		keymap = {
			preset = "default",
			["<Tab>"] = { "accept", "fallback" },
		},
		completion = {
			menu = {
				auto_show = true,
				draw = {
					treesitter = { "lsp" },
					columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
				},
			},
			documentation = { auto_show = true },
		},
		signature = { enabled = true },
		fuzzy = { implementation = "rust" },
		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
				"ripgrep",
			},
			per_filetype = {
				sql = { "lsp", "snippets", "buffer" },
			},
			providers = {
				lsp = {
					score_offset = 90,
				},
				ripgrep = {
					module = "blink-ripgrep",
					name = "Ripgrep",
					opts = {
						prefix_min_len = 3,
						backend = {
							use = "gitgrep-or-ripgrep",
						},
					},
				},
			},
		},
		cmdline = {
			keymap = { preset = "inherit" },
			completion = { menu = { auto_show = true } },
		},
	})
end)

vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		vim.keymap.set({ "n", "x" }, "<leader>ca", function()
			require("tiny-code-action").code_action()
		end, { noremap = true, silent = true })
	end,
})
