--BUFFERLINE.NVIM
--[[
--================
VSCode-style buffer tabs at the top of the editor. Shows all open files as clickable tabs
with file icons, close buttons, and diagnostic indicators. Integrates with neo-tree to
provide proper spacing.

Key Bindings:
- Ctrl+Tab: Next buffer/tab
- Ctrl+Shift+Tab: Previous buffer/tab
- <leader>x: Close current buffer
- Mouse left click: Switch to buffer
- Mouse right click: Close buffer
--]]

return {
	"akinsho/bufferline.nvim",                 -- Plugin for VSCode-style buffer tabs
	version = "*",                             -- Use latest stable version
	dependencies = "nvim-tree/nvim-web-devicons", -- Required for file icons
	config = function()
		require("bufferline").setup({
			options = {
				numbers = "none", -- Don't show buffer numbers in tabs
				close_command = "bdelete! %d", -- Command to close buffer on left click
				right_mouse_command = "bdelete! %d", -- Command to close buffer on right click
				left_mouse_command = "buffer %d", -- Command to switch buffer on left click
				middle_mouse_command = nil, -- Disable middle mouse button
				indicator = {
					icon = "▎", -- Icon to show for active buffer
					style = "icon", -- Use icon style indicator
				},
				buffer_close_icon = "", -- Icon for close button
				modified_icon = "●", -- Icon to show when buffer is modified
				close_icon = "", -- Icon for the close button
				left_trunc_marker = "", -- Icon when tabs are truncated on left
				right_trunc_marker = "", -- Icon when tabs are truncated on right
				max_name_length = 18, -- Maximum length of buffer name
				max_prefix_length = 15, -- Maximum length of buffer path prefix
				tab_size = 18, -- Minimum width of each tab
				diagnostics = "nvim_lsp", -- Show LSP diagnostics in tabs
				diagnostics_update_in_insert = false, -- Don't update diagnostics in insert mode
				show_buffer_icons = true, -- Show file type icons
				show_buffer_close_icons = true, -- Show close icons on each buffer
				show_close_icon = true, -- Show global close icon
				show_tab_indicators = true, -- Show tab indicators
				persist_buffer_sort = true, -- Remember buffer order between sessions
				separator_style = "thin", -- Style of separators between tabs
				enforce_regular_tabs = false, -- Allow tabs to be different sizes
				always_show_bufferline = true, -- Always show bufferline even with one buffer
				offsets = {
					{
						filetype = "neo-tree", -- Apply offset for neo-tree
						text = "File Explorer", -- Text to show in the offset area
						text_align = "left", -- Align text to the left
						separator = true, -- Show separator line
					},
				},
			},
		})

		-- Tab navigation keybinds
		vim.keymap.set("n", "<C-Tab>", ":BufferLineCycleNext<CR>", {}) -- Next tab with Ctrl+Tab
		vim.keymap.set("n", "<C-S-Tab>", ":BufferLineCyclePrev<CR>", {}) -- Previous tab with Ctrl+Shift+Tab
		vim.keymap.set("n", "<leader>x", ":bdelete<CR>", {})       -- Close current buffer with leader+x
	end,
}
