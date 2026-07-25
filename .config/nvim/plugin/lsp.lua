vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

vim.schedule(function()
	require("mason").setup()
	require("mason-lspconfig").setup()
	require("mason-tool-installer").setup({
		ensure_installed = {
			"lua_ls",
			"stylua",
			"phpantom_lsp",
			"php-cs-fixer",
			"html-lsp",
			"css-lsp",
			"biome",
			"prettierd",
			"ruff",
			"ty",
			"markdown-oxide",
			"bash-language-server",
			"shfmt",
		},
	})
end)
