vim.pack.add({ "https://github.com/mistweaverco/kulala.nvim" })

vim.api.nvim_create_autocmd("FileType", {
	once = true,
	pattern = { "http", "rest" },
	callback = function(ev)
		-- Load and setup the plugin only when an 'http' file is opened
		require("kulala").setup()

		-- Helper function for keymap options
		local opts = function(desc)
			return { desc = desc, buffer = ev.buf }
		end

		vim.keymap.set("n", "<leader>Ra", function()
			require("kulala").run_all()
		end, opts("Send all requests"))

		-- Buffer-local Keymaps
		vim.keymap.set("n", "<leader>Rc", "<cmd>lua require('kulala').copy()<cr>", opts("Copy as cURL"))
		vim.keymap.set("n", "<leader>RC", "<cmd>lua require('kulala').from_curl()<cr>", opts("Paste from curl"))
		vim.keymap.set("n", "<leader>Re", "<cmd>lua require('kulala').set_selected_env()<cr>", opts("Set environment"))
		vim.keymap.set(
			"n",
			"<leader>Rg",
			"<cmd>lua require('kulala').download_graphql_schema()<cr>",
			opts("Download GraphQL schema")
		)
		vim.keymap.set("n", "<leader>Ri", "<cmd>lua require('kulala').inspect()<cr>", opts("Inspect current request"))
		vim.keymap.set("n", "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", opts("Jump to next request"))
		vim.keymap.set(
			"n",
			"<leader>Rp",
			"<cmd>lua require('kulala').jump_prev()<cr>",
			opts("Jump to previous request")
		)
		vim.keymap.set("n", "<leader>Rq", "<cmd>lua require('kulala').close()<cr>", opts("Close window"))
		vim.keymap.set("n", "<leader>Rr", "<cmd>lua require('kulala').replay()<cr>", opts("Replay the last request"))
		vim.keymap.set("n", "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", opts("Send the request"))
		vim.keymap.set("n", "<leader>RS", "<cmd>lua require('kulala').show_stats()<cr>", opts("Show stats"))
		vim.keymap.set("n", "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", opts("Toggle headers/body"))
	end,
})

-- Global keymap to open scratchpad from anywhere (loads plugin on demand)
vim.keymap.set("n", "<leader>Rb", function()
	require("kulala").scratchpad()
end, { desc = "Open scratchpad" })
