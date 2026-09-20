vim.pack.add({
	"https://github.com/mikavilpas/yazi.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/MagicDuck/grug-far.nvim",
})
require("yazi").setup({
	open_for_directories = true,
})

vim.schedule(function()
	require("grug-far").setup({
		-- options, see Configuration section below
		-- there are no required options atm
	})
	-- Yazi
	vim.keymap.set("n", "<leader>ty", "<cmd>Yazi toggle<cr>", { desc = "Resume the last yazi session" })

	-- Search and Replace
	vim.keymap.set({ "n", "v", "x" }, "<leader>sr", function()
		local grug = require("grug-far")
		local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
		grug.open({
			transient = true,
			prefills = {
				filesFilter = ext and ext ~= "" and "*." .. ext or nil,
			},
		})
	end, { desc = "Search and Replace" })
end)
