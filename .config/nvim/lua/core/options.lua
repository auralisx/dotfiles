local o = vim.o
local opt = vim.opt

-- -----------------------------------------------------------------------------
-- Editing
-- -----------------------------------------------------------------------------

local indent = 2

o.autoindent = true -- Use auto intend
o.expandtab = true -- Use spaces instead of tabs
o.ignorecase = true -- Ignore case during search
o.infercase = true -- Infer case in built-in completion
o.tabstop = indent -- Number of spaces a tab counts for
o.shiftwidth = indent -- Number of spaces for each indentation step
o.softtabstop = indent -- Backspace treats spaces like tabs
o.shiftround = true -- Round indent to nearest shiftwidth
o.smartindent = true -- Enable smart auto-indenting for code
o.smarttab = true -- Use shiftwidth for tab in insert mode
o.smartcase = true -- Respect case if search pattern has upper case
o.spelloptions = "camel" -- Treat camelCase word parts as separate words
-- o.autocomplete = true -- Enable auto-completion features

o.number = true -- Show absolute line numbers
o.relativenumber = true -- Show line numbers relative to cursor
o.virtualedit = "block" -- Allow cursor to move beyond end of line
o.smoothscroll = true -- Smooth scrolling (if terminal supports it)

o.incsearch = true -- Highlight matches as you type
o.inccommand = "nosplit" -- Preview substitutions live

o.confirm = true -- Prompt before exiting with unsaved changes
o.wildmode = "longest:full,full" -- Command-line completion style
opt.wildignore:append("*/node_modules/*") -- Ignore in file completion

-- Completion menu behavior
opt.completeopt = {
	"menu",
	"menuone",
	"noselect",
	"popup",
	-- "fuzzy",
	-- "nosort",
	"preview",
}

o.formatoptions = "jcroqlnt" -- Behavior for automatic formatting

-- Use ripgrep for :grep commands
o.grepprg = "rg --vimgrep"
o.grepformat = "%f:%l:%c:%m"

-- -----------------------------------------------------------------------------
-- Code folding
-- -----------------------------------------------------------------------------

o.foldenable = true -- Enable code folding
o.foldlevel = 99 -- Default fold level
o.foldlevelstart = 99 -- Fold level when opening a file
o.foldmethod = "expr" -- Use expression to determine folds
o.foldexpr = "nvim_treesitter#foldexpr()" -- Use Treesitter for folding
o.foldtext = "" -- Use default fold line display

-- -----------------------------------------------------------------------------
-- File and buffer settings
-- -----------------------------------------------------------------------------

o.autowrite = true -- Save file when switching buffers
o.autoread = true -- Detect changes outside Nvim
o.swapfile = false -- Disable swap files
o.backup = false -- Disable backup files
o.writebackup = false -- Disable backup before write
o.undofile = true -- Enable persistent undo

opt.sessionoptions = {
	"buffers",
	"curdir",
	"tabpages",
	"winsize",
	"winpos",
	"help",
	"globals",
	"skiprtp",
	"folds",
}

-- -----------------------------------------------------------------------------
-- General
-- -----------------------------------------------------------------------------

o.mouse = "a" -- Enable mouse in all modes
o.backspace = "indent,eol,start" -- Backspace works in insert mode
opt.iskeyword:append("-") -- Treat dash as part of a word
opt.path:append("**") -- Search in subdirectories with commands like :find
o.shell = "fish" -- make fish the default shell in nvim terminal

-- -----------------------------------------------------------------------------
-- Window and split behavior
-- -----------------------------------------------------------------------------

o.splitbelow = true -- New horizontal splits open below
o.splitright = true -- New vertical splits open to the right
o.splitkeep = "screen" -- Keep view stable when loading new content

o.scrolloff = 8 -- Keep at least 8 lines around cursor
o.sidescrolloff = 8
o.winminwidth = 5 -- Minimum window width

-- -----------------------------------------------------------------------------
-- UI
-- -----------------------------------------------------------------------------

o.cursorline = true -- Highlight current line
o.signcolumn = "yes:2" -- Always show sign column (2 char width)
o.pumheight = 10 -- Limit height of completion menu
o.cmdheight = 1 -- Command line height
o.showmode = true -- Show mode in command line
o.laststatus = 3 -- Global statusline

o.wrap = false -- Wrap long lines
o.linebreak = true -- Break lines at appropriate characters
o.breakindent = true -- Indent wrapped lines to match original

o.showtabline = 1 -- Show tabline (0=never, 1=when multiple tabs, 2=always)
o.winborder = "rounded" -- Rounded borders for windows and popups

o.conceallevel = 2 -- Hide markup in files like Markdown
o.concealcursor = "" -- Show concealed text outside insert mode

o.virtualedit = "block" -- Allow cursor beyond end of line in block mode
o.smoothscroll = true -- Smooth scrolling (if terminal supports it)
o.termguicolors = true -- Enable 24 bit color

o.lazyredraw = true -- Don't redraw while executing macros. Faster scrolling

-- Characters used to draw UI elements
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- Uncomment to show invisible characters
-- o.list = true
-- o.listchars = {
--   tab = "→ ",
--   eol = "↲",
--   nbsp = "␣",
--   lead = "␣",
--   space = "␣",
--   trail = "•",
--   extends = "⟩",
--   precedes = "⟨"
-- }

-- -----------------------------------------------------------------------------
-- Misc
-- -----------------------------------------------------------------------------
o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)
