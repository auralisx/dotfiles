-- Buffer navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer", noremap = true, silent = true })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer", noremap = true, silent = true })

-- Tabs
vim.keymap.set("n", "<leader><Tab>n", ":tabnew<CR>", { silent = true, desc = "New tab" })
vim.keymap.set("n", "<leader><Tab>q", ":tabclose<CR>", { silent = true, desc = "Close tab" })
vim.keymap.set("n", "<leader><Tab>s", ":tab split<CR>", { silent = true, desc = "Split to new tab" })
vim.keymap.set("n", "<leader><Tab>]", ":tabnext<CR>", { silent = true, desc = "Next tab" })
vim.keymap.set("n", "<leader><Tab>[", ":tabprevious<CR>", { silent = true, desc = "Previous tab" })

-- Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", noremap = true })
vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide terminal", noremap = true, silent = true })
