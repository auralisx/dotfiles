vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")

vim.keymap.set("n", "<leader>u", ":Undotree<CR>", { desc = "Toggle Undotree" })

-- Enable the new UI
require("vim._core.ui2").enable({})

-- Initialize the statusline module
local statusline = require("features.statusline")
statusline.setup()

