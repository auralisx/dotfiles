vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/windwp/nvim-ts-autotag",
})

-- Update treesitter when nvim-treesitter is updated
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("TS-Update", { clear = true }),
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

require("nvim-treesitter").install({
	"bash",
	"diff",
	"html",
	"css",
	"javascript",
	"json",
	"lua",
	"markdown",
	"typescript",
	"rust",
	"php",
	"markdown",
})
require("nvim-ts-autotag").setup()
