vim.schedule(function()
	vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			rust = { "rustfmt" },
			sql = { "sql_formatter" },
			json = { "biome" },
			html = { "prettierd" },
			javascript = { "biome" },
			typescript = { "biome" },
			blade = { "blade_formatter" },
			php = { "php_cs_fixer" },
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
