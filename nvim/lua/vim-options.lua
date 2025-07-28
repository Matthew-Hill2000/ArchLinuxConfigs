-- Tab and indentation settings
vim.cmd("set tabstop=2")     -- Width of a tab character
vim.cmd("set softtabstop=2") -- Number of spaces for tab in insert mode
vim.cmd("set shiftwidth=2")  -- Number of spaces for auto-indent
vim.g.mapleader = " "        -- Set space as the leader key for custom shortcuts

-- Clipboard configuration for Wayland
vim.g.clipboard = {
	name = "wl-clipboard", -- Use wl-clipboard for Wayland systems
	copy = {
		["+"] = "wl-copy", -- Copy to system clipboard
		["*"] = "wl-copy", -- Copy to selection clipboard
	},
	paste = {
		["+"] = "wl-paste --no-newline", -- Paste from system clipboard without extra newline
		["*"] = "wl-paste --no-newline", -- Paste from selection clipboard without extra newline
	},
	cache_enabled = 0,             -- Disable clipboard caching for real-time sync
}

-- Basic editor options
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for all operations
vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true     -- Show relative line numbers (current line shows absolute)
vim.opt.cursorline = true         -- Highlight the current line
vim.opt.termguicolors = true      -- Enable 24-bit RGB colors
vim.opt.signcolumn = "yes"        -- Always show sign column (for git, diagnostics, etc.)
vim.opt.wrap = false              -- Don't wrap long lines
vim.opt.scrolloff = 8             -- Keep 8 lines visible above/below cursor when scrolling
vim.opt.sidescrolloff = 8         -- Keep 8 columns visible left/right of cursor
vim.opt.mouse = "a"               -- Enable mouse support in all modes

-- Better search behavior
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true  -- Override ignorecase if search contains uppercase
vim.opt.hlsearch = true   -- Highlight all search matches
vim.opt.incsearch = true  -- Show matches as you type

-- Better window splitting
vim.opt.splitbelow = true -- New horizontal splits open below current window
vim.opt.splitright = true -- New vertical splits open to the right

-- Better window navigation (move between split windows)
vim.keymap.set("n", "<C-h>", "<C-w>h", {}) -- Move to left window
vim.keymap.set("n", "<C-j>", "<C-w>j", {}) -- Move to window below
vim.keymap.set("n", "<C-k>", "<C-w>k", {}) -- Move to window above
vim.keymap.set("n", "<C-l>", "<C-w>l", {}) -- Move to right window

-- Utility keybinds
vim.keymap.set("n", "<Esc>", ":noh<CR>", {}) -- Clear search highlights with Escape

-- keybinding cheatsheet
-- Force override the help menu keybinding
vim.keymap.set("n", "<leader>hh", function()
	local cheatsheet = {
		"=== NEOVIM KEYBINDINGS CHEATSHEET ===",
		"",
		"FILE MANAGEMENT:",
		"  Ctrl+p          - Find files",
		"  Ctrl+n          - Toggle file explorer",
		"  <leader>e       - Focus file explorer",
		"",
		"SEARCH:",
		"  <leader>fg      - Live grep (search in files)",
		"  <leader>fb      - Find buffers",
		"  <leader>fh      - Help tags",
		"  <leader>fr      - Recent files",
		"",
		"CODE FEATURES:",
		"  K               - Hover documentation",
		"  gd              - Go to definition",
		"  <leader>ca      - Code actions",
		"  <leader>gf      - Format buffer",
		"",
		"DEBUGGING:",
		"  <leader>db      - Toggle breakpoint",
		"  <leader>dc      - Continue debugging",
		"  <leader>di      - Step into",
		"  <leader>do      - Step over",
		"  <leader>du      - Step out",
		"  <leader>dr      - Open debug REPL",
		"  <leader>dt      - Toggle debug UI",
		"",
		"BUFFERS/TABS:",
		"  Ctrl+Tab        - Next buffer",
		"  Ctrl+Shift+Tab  - Previous buffer",
		"  <leader>x       - Close buffer",
		"",
		"COMPLETION:",
		"  Ctrl+Space      - Trigger completion",
		"  Ctrl+e          - Cancel completion",
		"  Enter           - Accept completion",
		"  Ctrl+b/f        - Scroll docs",
		"",
		"SPLITS:",
		"  :vsplit         - Vertical split",
		"  :split          - Horizontal split",
		"  Ctrl+w c        - Close split",
		"  Ctrl+h/j/k/l    - Navigate splits",
		"",
		"Press 'q' or 'Esc' to close this window",
	}

	-- Create a new buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, cheatsheet)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "filetype", "help")

	-- Create a floating window
	local width = 60
	local height = math.min(#cheatsheet + 2, vim.o.lines - 4)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		border = "rounded",
		title = " Keybindings ",
		title_pos = "center",
	})

	-- Close with 'q' or Escape
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "<cmd>close<cr>", { noremap = true, silent = true })
end, {
	desc = "Show Keybinding Cheatsheet",
	noremap = true, -- Don't allow remapping
	silent = true, -- Don't show command in command line
})

-- Diagnostic viewing and navigation
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Show All Diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- Configure diagnostic display
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		source = "if_many",   -- Only show source if multiple sources
		spacing = 2,          -- Add some spacing
		severity_limit = "Warning", -- Only show warnings and errors as virtual text
	},
	signs = true,             -- Keep the W/E signs in gutter
	underline = true,         -- Underline problematic text
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		focusable = false,
	},
})

-- Customize diagnostic signs
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
