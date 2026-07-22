vim.schedule(function()
	vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = {
				-- To fix auto-fixable lint errors.
				"ruff_fix",
				-- To run the Ruff formatter.
				"ruff_format",
				-- To organize the imports.
				"ruff_organize_imports",
			},
			rust = { "rustfmt" },
			sql = { "sql_formatter" },
			json = { "biome", "prettierd" },
			html = { "prettierd" },
			javascript = { "biome", "prettierd" },
			javascriptreact = { "biome", "prettierd" },
			typescript = { "biome", "prettierd" },
			typescriptreact = { "biome", "prettierd" },
			blade = { "blade_formatter" },
			php = { "php_cs_fixer" },
			kdl = { "kdlfmt" },
			sh = { "shfmt" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
	})

	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	-- Format on save
	-- vim.api.nvim_create_autocmd("BufWritePre", {
	-- 	group = vim.api.nvim_create_augroup("Conform", { clear = true }),
	-- 	pattern = "*",
	-- 	callback = function(args)
	-- 		require("conform").format({ bufnr = args.buf })
	-- 	end,
	-- })
end)
