local indent = 4

vim.opt_local.tabstop = indent
vim.opt_local.shiftwidth = indent
vim.opt_local.softtabstop = indent

if vim.fs.root(0, { "wp-config.php", "wp-load.php" }) then
	vim.opt_local.expandtab = false
end
