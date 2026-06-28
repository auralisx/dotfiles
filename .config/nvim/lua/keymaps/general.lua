-- Quality-of-life keymaps that enhance core editing behavior.

-- Make `j` and `k` move by display line, not logical line
-- Useful when lines wrap (e.g., in prose or long code lines)
vim.keymap.set(
	{ "n", "x" },
	"j",
	"v:count == 0 ? 'gj' : 'j'",
	{ expr = true, noremap = true, desc = "Move down (by screen line)" }
)
vim.keymap.set(
	{ "n", "x" },
	"k",
	"v:count == 0 ? 'gk' : 'k'",
	{ expr = true, noremap = true, desc = "Move up (by screen line)" }
)

-- Better indenting in visual mode: reselect after shifting
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true, desc = "Indent left and preserve selection" })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true, desc = "Indent right and preserve selection" })

-- Center screen and re-highlight when jumping to search results
vim.keymap.set(
	"n",
	"n",
	"'Nn'[v:searchforward].'zzzv'",
	{ expr = true, noremap = true, desc = "Next search result (centered)" }
)
vim.keymap.set(
	"n",
	"N",
	"'nN'[v:searchforward].'zzzv'",
	{ expr = true, noremap = true, desc = "Previous search result (centered)" }
)

-- Also apply to operator-pending and visual modes
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, noremap = true, desc = "Next search result" })
vim.keymap.set(
	"o",
	"n",
	"'Nn'[v:searchforward]",
	{ expr = true, noremap = true, desc = "Next search result (operator-pending)" }
)
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, noremap = true, desc = "Previous search result" })
vim.keymap.set(
	"o",
	"N",
	"'nN'[v:searchforward]",
	{ expr = true, noremap = true, desc = "Previous search result (operator-pending)" }
)

-- Clear search highlight with <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear search highlight" })

-- Center view when scrolling half-page
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Scroll up and center" })

-- Center after jumping to next/previous paragraph
vim.keymap.set("n", "{", "{zz", { noremap = true, silent = true, desc = "Previous paragraph (centered)" })
vim.keymap.set("n", "}", "}zz", { noremap = true, silent = true, desc = "Next paragraph (centered)" })

-- Center after jumping to next/previous change
vim.keymap.set("n", "g;", "g;zvzz", { noremap = true, silent = true, desc = "Next change (centered)" })
vim.keymap.set("n", "g,", "g,zvzz", { noremap = true, silent = true, desc = "Previous change (centered)" })

-- Add undo breakpoints before punctuation
-- This allows finer-grained undo (e.g., undo one sentence at a time)
for _, key in ipairs({
	",",
	".",
	";",
	"?",
	"!",
}) do
	vim.keymap.set("i", key, key .. "<C-g>u", {
		noremap = true,
		desc = "Insert '" .. key .. "' with undo break",
	})
end

-- Join lines without moving cursor far
vim.keymap.set("n", "J", "mzJ`z", { noremap = true, silent = true, desc = "Join lines, restore cursor position" })
