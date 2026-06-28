-- Netrw Appearance & Behavior
-- vim.g.netrw_banner = 0       -- Hide the help banner (crucial for a clean look)
-- vim.g.netrw_liststyle = 3    -- Use Tree View
-- vim.g.netrw_browse_split = 4 -- Open files in the previous window
-- vim.g.netrw_winsize = 20     -- Set width to 20% of the screen
-- vim.g.netrw_clipboard = 0    -- Prevent netrw from copying to clipboard
-- vim.g.netrw_keepdir = 1      -- Keep Netrw focused on the directory where you started Neovim

-- vim.keymap.set('n', '<leader>te', ':Lexplore! %:p:h<cr>', { desc = 'Toggle Netrw' })

-- built-in undotree
vim.cmd.packadd("nvim.undotree")

vim.keymap.set("n", "<leader>u", ":Undotree<CR>", { desc = "Toggle Undotree" })

vim.cmd.packadd("nvim.difftool")
