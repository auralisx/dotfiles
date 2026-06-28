vim.schedule(function()
	vim.pack.add({
		"https://github.com/nvim-mini/mini.ai",
		"https://github.com/nvim-mini/mini.align",
		"https://github.com/nvim-mini/mini.pairs",
		"https://github.com/nvim-mini/mini.surround",
		"https://github.com/folke/flash.nvim",
	})
	require("mini.ai").setup()
	require("mini.align").setup()
	require("mini.pairs").setup({
		modes = { insert = true, command = true, terminal = false },
	})
	require("mini.surround").setup({
		-- Module mappings. Use `''` (empty string) to disable one.
		mappings = {
			add = "gsa", -- Add surrounding in Normal and Visual modes
			delete = "ds", -- Delete surrounding
			find = "gsf", -- Find surrounding (to the right)
			find_left = "gsF", -- Find surrounding (to the left)
			highlight = "gsh", -- Highlight surrounding
			replace = "cs", -- Replace surrounding

			suffix_last = "l", -- Suffix to search with "prev" method
			suffix_next = "n", -- Suffix to search with "next" method
		},
	})

	-- Flash
	vim.keymap.set({ "n", "x", "o" }, "s", function()
		require("flash").jump()
	end, { desc = "Flash" })
	vim.keymap.set({ "n", "x", "o" }, "S", function()
		require("flash").treesitter()
	end, { desc = "Flash Treesitter" })
	vim.keymap.set("o", "r", function()
		require("flash").remote()
	end, { desc = "Remote Flash" })
	vim.keymap.set({ "o", "x" }, "R", function()
		require("flash").treesitter_search()
	end, { desc = "Treesitter Search" })
	vim.keymap.set({ "c" }, "<c-s>", function()
		require("flash").toggle()
	end, { desc = "Toggle Flash Search" })
	vim.keymap.set({ "n", "x", "o" }, "<c-space>", function()
		require("flash").treesitter()({
			actions = {
				["<c-space>"] = "next",
				["<BS>"] = "prev",
			},
		})
	end, { desc = "Treesitter Incremental Selection" })
end)
