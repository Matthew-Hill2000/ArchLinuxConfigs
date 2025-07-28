--[[
NEO-TREE (FILE EXPLORER)
========================
Modern file explorer with git integration, diagnostics, and beautiful icons.
Shows file structure, git status, and LSP diagnostics in a sidebar. Supports
file operations like create, rename, delete, and copy.

Key Bindings:
- Ctrl+n: Toggle file explorer
- <leader>e: Focus file explorer
- (Within neo-tree):
  - Enter: Open file
  - a: Create new file/folder
  - d: Delete file/folder
  - r: Rename file/folder
  - c: Copy file/folder
  - x: Cut file/folder
  - p: Paste file/folder
--]]

return {
	"nvim-neo-tree/neo-tree.nvim", -- Modern file explorer
	branch = "v3.x",             -- Use version 3.x branch
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required lua functions
		"nvim-tree/nvim-web-devicons", -- File icons
		"MunifTanjim/nui.nvim",  -- UI components
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = false, -- Don't close neo-tree if it's the last window
			popup_border_style = "rounded", -- Rounded borders for popups
			enable_git_status = true, -- Show git status in file explorer
			enable_diagnostics = true, -- Show LSP diagnostics in file explorer
			default_component_configs = {
				container = {
					enable_character_fade = true, -- Fade characters for better visual hierarchy
				},
				indent = {
					indent_size = 2, -- Size of each indent level
					padding = 1, -- Padding between indent and content
					with_markers = true, -- Show indent guide markers
					indent_marker = "│", -- Character for indent guides
					last_indent_marker = "└", -- Character for last indent guide
					highlight = "NeoTreeIndentMarker", -- Highlight group for markers
					with_expanders = nil, -- Use default expander settings
					expander_collapsed = "", -- Icon when folder is collapsed
					expander_expanded = "", -- Icon when folder is expanded
					expander_highlight = "NeoTreeExpander", -- Highlight group for expanders
				},
				modified = {
					symbol = "[+]", -- Symbol to show when file is modified
					highlight = "NeoTreeModified", -- Highlight group for modified files
				},
				name = {
					trailing_slash = false, -- Don't show trailing slash on folder names
					use_git_status_colors = true, -- Use git status colors for file names
					highlight = "NeoTreeFileName", -- Highlight group for file names
				},
				git_status = {
					symbols = {
						added = "✚", -- Symbol for added files
						modified = "", -- Symbol for modified files
						deleted = "✖", -- Symbol for deleted files
						renamed = "", -- Symbol for renamed files
						untracked = "", -- Symbol for untracked files
						ignored = "", -- Symbol for ignored files
						unstaged = "", -- Symbol for unstaged changes
						staged = "", -- Symbol for staged changes
						conflict = "", -- Symbol for merge conflicts
					},
				},
			},
			window = {
				position = "left", -- Show neo-tree on left side
				width = 30, -- Width of neo-tree window
				mapping_options = {
					noremap = true, -- Don't allow recursive mappings
					nowait = true, -- Don't wait for more characters
				},
			},
			filesystem = {
				filtered_items = {
					visible = false, -- Don't show filtered items by default
					hide_dotfiles = true, -- Hide files starting with dot
					hide_gitignored = true, -- Hide files ignored by git
					hide_hidden = true, -- Hide hidden files (Windows)
				},
				follow_current_file = {
					enabled = true,         -- Auto-expand to show current file
					leave_dirs_open = false, -- Close other directories when following
				},
				group_empty_dirs = false,   -- Don't group consecutive empty directories
				hijack_netrw_behavior = "open_default", -- Replace netrw with neo-tree
				use_libuv_file_watcher = false, -- Don't use libuv for file watching (can be slow)
			},
		})

		-- Keybinds for neo-tree
		vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", {}) -- Toggle neo-tree with Ctrl+n
		vim.keymap.set("n", "<leader>e", ":Neotree focus<CR>", {}) -- Focus neo-tree with leader+e
	end,
}
