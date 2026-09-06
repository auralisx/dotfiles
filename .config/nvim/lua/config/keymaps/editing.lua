-- Copy, cut, paste using system clipboard
vim.keymap.set({ "n", "x" }, "<C-c>", '"+y', { desc = "Copy to clipboard", noremap = true })
vim.keymap.set({ "n" }, "gp", '"+p', { desc = "Paste from clipboard", noremap = true })
vim.keymap.set({ "x" }, "gp", '"+P', { desc = "Paste from clipboard", noremap = true })
vim.keymap.set({ "x" }, "<C-x>", '"+y<cmd>normal! d<cr>', { desc = "Cut to clipboard", noremap = true })

-- Paste below with marker
vim.keymap.set("n", "]p", "m`o<Esc>p``", { desc = "Paste below", noremap = true, silent = true })
vim.keymap.set("n", "[p", "m`O<Esc>p``", { desc = "Paste above", noremap = true, silent = true })

-- Yank file path (relative and absolute)
vim.keymap.set("n", "<leader>yrp", function()
	local path = vim.fn.expand("%:.")
	vim.fn.setreg("+", path)
	vim.notify(path, vim.log.levels.INFO, {
		title = "Yanked relative path",
	})
end, {
	desc = "Yank relative path",
	noremap = true,
	silent = true,
})

vim.keymap.set({ "n", "x" }, "<leader>yar", require("features.ai").reference, { desc = "Copy file:line reference" })

vim.keymap.set("n", "<leader>yap", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify(path, vim.log.levels.INFO, {
		title = "Yanked absolute path",
	})
end, {
	desc = "Yank absolute path",
	noremap = true,
	silent = true,
})

vim.keymap.set("n", "<leader>yy", "ggVG", { desc = "Select all" })

-- Reselect latest changed, put, or yanked text
vim.keymap.set(
	"n",
	"gV",
	'"g`[" . strpart(getregtype(), 0, 1) . "g`]"',
	{ expr = true, replace_keycodes = false, desc = "Visually select changed text", noremap = true }
)

-- Search inside visually highlighted text. Use `silent = false` for it to
-- make effect immediately.
vim.keymap.set("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection", noremap = true })

-- Move lines up/down
vim.keymap.set("n", "<A-down>", ":m .+1<CR>==", { desc = "Move line down", noremap = true, silent = true })
vim.keymap.set("n", "<A-up>", ":m .-2<CR>==", { desc = "Move line up", noremap = true, silent = true })
vim.keymap.set("i", "<A-down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down", noremap = true, silent = true })
vim.keymap.set("i", "<A-up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up", noremap = true, silent = true })
vim.keymap.set("v", "<A-down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", noremap = true, silent = true })
vim.keymap.set("v", "<A-up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", noremap = true, silent = true })

-- Fold all except current context
vim.keymap.set("n", "<leader>zf", "zMzvzz", { desc = "Focus current fold", noremap = true, silent = true })

-- Close current fold, open next/previous
vim.keymap.set("n", "zj", "zcjzOzz", { desc = "Close fold, open next", noremap = true, silent = true })
vim.keymap.set("n", "zk", "zckzOzz", { desc = "Close fold, open previous", noremap = true, silent = true })

-- Fast escape from insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode", noremap = true })

-- Insert semicolon or comma at end of line
vim.keymap.set("i", "<A-;>", "<Esc>m`A;<Esc>``i", { desc = "Insert semicolon at end", noremap = true })
vim.keymap.set("i", "<A-,>", "<Esc>m`A,<Esc>``i", { desc = "Insert comma at end", noremap = true })

-- Select all in insert mode
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { desc = "Select all", noremap = true })

-- Undo in insert mode
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo", noremap = true })

-- Paste in insert mode
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste from clipboard", noremap = true })

-- Toggle case of word
vim.keymap.set("n", "gu", "g~iw", { noremap = true, desc = "Toggle case of word" })
vim.keymap.set("x", "gu", "g~", { noremap = true, desc = "Toggle case of selection" })
