local function augroup(name)
	return vim.api.nvim_create_augroup("SK_" .. name, { clear = true })
end

-- BUFFER & FILE BEHAVIOR
local buffer_group = augroup("buffer_behavior")

-- Autosave on specific events (Zed-style)
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertLeave" }, {
	group = buffer_group,
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
			vim.cmd("silent! update | redraw")
		end
	end,
	desc = "Autosave on focus change or exiting insert mode",
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	group = buffer_group,
	pattern = "help",
	command = "wincmd L",
	desc = "Open help in vertical split",
})

-- Return to last edit position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = buffer_group,
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- Auto-create parent directories
vim.api.nvim_create_autocmd("BufWritePre", {
	group = buffer_group,
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		local dir = vim.fn.fnamemodify(file, ":p:h")
		vim.fn.mkdir(dir, "p")
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = buffer_group,
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = buffer_group,
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- UI & APPEARANCE
local ui_group = augroup("ui_tweaks")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = ui_group,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Resize splits evenly on terminal resize
vim.api.nvim_create_autocmd("VimResized", {
	group = ui_group,
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- Dynamic Relative Numbers (Zed-style)
-- Shows relative numbers in normal mode, absolute in insert/unfocused
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	group = ui_group,
	callback = function()
		if vim.wo.number and vim.api.nvim_get_mode().mode ~= "i" then
			vim.wo.relativenumber = true
		end
	end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	group = ui_group,
	callback = function()
		if vim.wo.number then
			vim.wo.relativenumber = false
		end
	end,
})

-- TERMINAL & SPECIAL BUFFERS
local special_group = augroup("special_buffers")

-- Better Terminal defaults
vim.api.nvim_create_autocmd("TermOpen", {
	group = special_group,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.cmd("startinsert") -- Auto-enter insert mode
	end,
})

-- Undotree settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = "nvim-undotree",
	group = special_group,
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.keymap.set("n", "q", ":q<CR>", { buffer = true })
	end,
})

-- LANGUAGE SPECIFIC (FileType)
local lang_group = augroup("language_settings")

-- Disable diagnostics in node_modules
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = lang_group,
	pattern = "*/node_modules/*",
	callback = function()
		vim.diagnostic.enable(false, { bufnr = 0 })
	end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
	group = lang_group,
	pattern = { ".env", ".env.*" },
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})

-- Vim Pack
-- local pack_group = augroup("package_manager")
