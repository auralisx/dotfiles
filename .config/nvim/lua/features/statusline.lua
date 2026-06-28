local M = {}

---------------------------------------------------------------------
-- HIGHLIGHTS
---------------------------------------------------------------------

function M.setup_hl()
	local hl = vim.api.nvim_set_hl

	hl(0, "StatusLine", { fg = "#c0caf5", bg = "none" })
	hl(0, "StatusLineNC", { fg = "#565f89", bg = "none" })

	local colors = {
		Orange = "#ff9e64",
		Blue = "#7aa2f7",
		Purple = "#bb9af7",
		Cyan = "#73daca",
		Red = "#f7768e",
		Yellow = "#e0af68",
		Green = "#9ece6a",
		Teal = "#2ac3de",
		Fg = "#c0caf5",
	}

	for name, color in pairs(colors) do
		hl(0, "SK" .. name, {
			fg = color,
			bg = "none",
		})

		hl(0, "SK" .. name .. "Bold", {
			fg = color,
			bg = "none",
			bold = true,
		})
	end
end


function M.hl(group, text)
	if not text or text == "" then
		return ""
	end

	return string.format("%%#SK%s#%s%%*", group, text)
end

---------------------------------------------------------------------
-- EXTENSION API
---------------------------------------------------------------------

M.sections = {
	left = {},
	center_left = {},
	right = {},
}

function M.register(section, fn)
	if M.sections[section] then
		table.insert(M.sections[section], fn)
	end
end

local function render_section(section)
	local parts = {}

	for _, fn in ipairs(section) do
		local ok, value = pcall(fn)

		if ok and value and value ~= "" then
			table.insert(parts, value)
		end
	end

	return table.concat(parts, "  ")
end

---------------------------------------------------------------------
-- BUILTIN COMPONENTS
---------------------------------------------------------------------

local function get_project()
	local root = vim.fs.root(0, {
		".git",
		"package.json",
		"composer.json",
		"Cargo.toml",
	})

	if not root then
		return ""
	end

	return M.hl("Blue", "󰉋 " .. vim.fs.basename(root))
end

local function get_short_path(depth)
	local file = vim.api.nvim_buf_get_name(0)

	if file == "" then
		return ""
	end

	local root = vim.fs.root(file, {
		".git",
		"package.json",
		"composer.json",
		"Cargo.toml",
	})

	if not root then
		-- return vim.fn.fnamemodify(file, ":f")
		return " %f"
	end

	-- make path relative to project root
	local relative = vim.fs.relpath(root, file) or file

	local parts = vim.split(relative, "/", {
		plain = true,
	})

	if #parts <= depth then
		return relative
	end

	return "…/" .. table.concat(vim.list_slice(parts, #parts - depth + 1), "/")
end

local function get_lsp()
	local clients = vim.lsp.get_clients({
		bufnr = 0,
	})

	if #clients == 0 then
		return ""
	end

	local primary = clients[1].name

	if #clients == 1 then
		return M.hl("Teal", " " .. primary)
	end

	return M.hl("Teal", string.format(" %s+%d", primary, #clients - 1))
end

local function combine(parts)
	local result = {}

	for _, item in ipairs(parts) do
		if item and item ~= "" then
			table.insert(result, item)
		end
	end

	return table.concat(result, "  ")
end

---------------------------------------------------------------------
-- RENDER
---------------------------------------------------------------------

function M.render()
	local left = combine({
		get_project(),
		M.hl("Fg", "󰈙 " .. get_short_path(3)),
		-- M.hl("Fg", "󰈙 %f"),
		M.hl("Red", "%m%r"),
		vim.diagnostic.status(),
		vim.ui.progress_status(),
	})

	local right = combine({
		get_lsp(),
		vim.lsp.status(),
		M.hl("Yellow", "%y"),
		M.hl("Purple", "%l:%c"),
		M.hl("Cyan", "%P"),
	})

	return table.concat({
		render_section(M.sections.left),

		left,

		render_section(M.sections.center_left),

		"%=",

		render_section(M.sections.right),

		right,
	}, " ")
end

---------------------------------------------------------------------
-- SETUP
---------------------------------------------------------------------

function M.setup()
	M.setup_hl()

	_G.CoreStatusline = M.render

	vim.opt.statusline = "%!v:lua.CoreStatusline()"

	local group = vim.api.nvim_create_augroup("StatuslineRefresh", { clear = true })

	vim.api.nvim_create_autocmd({
		"BufEnter",
		"ModeChanged",
		"DiagnosticChanged",
		"LspAttach",
		"ColorScheme",
	}, {
		group = group,
		callback = function()
			M.setup_hl()
			vim.cmd.redrawstatus()
		end,
	})
end

return M
