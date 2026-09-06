local M = {}

--- Copy a "path:line" or "path:start-end" reference to the clipboard,
function M.reference()
	local abs_path = vim.fn.expand("%:p")
	if abs_path == "" then
		vim.notify("No file in current buffer", vim.log.levels.WARN, { title = "Reference" })
		return
	end

	local root = vim.fs.root(0, {
		".git",
		"package.json",
		"composer.json",
		"Cargo.toml",
	})

	local path = (root and abs_path:sub(1, #root) == root) and abs_path:sub(#root + 2) or vim.fn.expand("%:.")

	local mode = vim.fn.mode()
	local start_line, end_line

	if mode == "v" or mode == "V" or mode == "\22" then
		start_line = vim.fn.line("v")
		end_line = vim.fn.line(".")
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end
	else
		start_line = vim.fn.line(".")
		end_line = start_line
	end

	local ref = start_line == end_line and ("%s:%d"):format(path, start_line)
		or ("%s:%d-%d"):format(path, start_line, end_line)

	local diags = vim.diagnostic.get(0, { lnum = start_line - 1 })
	if #diags > 0 then
		ref = ref .. " — " .. diags[1].message:gsub("\n", " ")
	end

	vim.fn.setreg("+", ref)
	vim.notify(ref, vim.log.levels.INFO, { title = "Reference copied" })
end

return M
