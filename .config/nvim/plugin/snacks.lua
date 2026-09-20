vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})
require("snacks").setup({
	picker = { enabled = true },
	lazygit = { enabled = true },
	notifier = { enabled = true },
	bufdelete = { enabled = true },
	indent = { enabled = true },
	statuscolumn = { enabled = true },
})

vim.keymap.set("n", "<leader><space>", function()
	Snacks.picker.smart()
end, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>/", function()
	Snacks.picker.grep()
end, { desc = "Grep" })

-- find
vim.keymap.set("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", function()
	Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })
vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fp", function()
	Snacks.picker.projects()
end, { desc = "Projects" })
vim.keymap.set("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent" })

-- Grep
vim.keymap.set("n", "<leader>sb", function()
	Snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })
vim.keymap.set("n", "<leader>sg", function()
	Snacks.picker.grep()
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>sw", function()
	Snacks.picker.grep_word()
end, { desc = "Visual selection or word" })

-- search
vim.keymap.set("n", '<leader>s"', function()
	Snacks.picker.registers()
end, { desc = "Registers" })
vim.keymap.set("n", "<leader>sl", function()
	Snacks.picker.lines()
end, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sd", function()
	Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", function()
	Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>sj", function()
	Snacks.picker.jumps()
end, { desc = "Jumps" })
vim.keymap.set("n", "<leader>sk", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sL", function()
	Snacks.picker.loclist()
end, { desc = "Location List" })
vim.keymap.set("n", "<leader>sm", function()
	Snacks.picker.marks()
end, { desc = "Marks" })
vim.keymap.set("n", "<leader>sq", function()
	Snacks.picker.qflist()
end, { desc = "Quickfix List" })

-- LSP
vim.keymap.set("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", function()
	Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })
vim.keymap.set("n", "gr", function()
	Snacks.picker.lsp_references()
end, { nowait = true, desc = "References" })
vim.keymap.set("n", "gI", function()
	Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "Goto T[y]pe Definition" })
vim.keymap.set("n", "gai", function()
	Snacks.picker.lsp_incoming_calls()
end, { desc = "C[a]lls Incoming" })
vim.keymap.set("n", "gao", function()
	Snacks.picker.lsp_outgoing_calls()
end, { desc = "C[a]lls Outgoing" })
vim.keymap.set("n", "<leader>ss", function()
	Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>sS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })

-- Buffer
vim.keymap.set("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bx", function()
	Snacks.bufdelete.all()
end, { desc = "Delete All Buffers" })
vim.keymap.set("n", "<leader>bc", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

-- Lazygit
vim.keymap.set("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })

-- Open notes (Snacks.nvim or similar)
vim.keymap.set("n", "<leader>on", function()
	Snacks.picker.files({
		cwd = vim.fn.expand("~/git_repos/notes"),
	})
end, {
	desc = "Open notes",
	noremap = true,
	silent = true,
})

-- Notifcations
vim.keymap.set("n", "<leader>nn", function()
	Snacks.picker.notifications()
end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>nd", function()
	Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })

