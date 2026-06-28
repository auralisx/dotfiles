-- Basic buffer settings
vim.bo.buflisted = false
vim.wo.signcolumn = 'no'
vim.wo.winfixwidth = true

-- Pretty winbar
local path = vim.fn.expand('%:p:~')
vim.opt_local.winbar = '  ' .. path

-- Quick navigation
vim.keymap.set('n', 'h', '-', { buffer = true, remap = true })    -- Go up
vim.keymap.set('n', 'l', '<CR>', { buffer = true, remap = true }) -- Go inside
