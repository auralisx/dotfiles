local M = {}

function M.reference()
	local path = vim.fn.expand("%:.")

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

	vim.fn.setreg("+", ref)
	vim.notify(ref, vim.log.levels.INFO, { title = "Reference copied" })
end

return M
