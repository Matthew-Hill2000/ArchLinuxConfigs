--[[
INDENT BLANKLINE
================
Visual indentation guides that show code structure with vertical lines. Helps with
code readability by clearly showing indentation levels and code blocks. Integrates
with treesitter for intelligent scope highlighting.

Key Bindings:
- None (visual enhancement only)
--]]

return {
	"lukas-reineke/indent-blankline.nvim", -- Plugin for indentation guides
	main = "ibl",                       -- Main module name
	config = function()
		require("ibl").setup({
			indent = {
				char = "│", -- Character to use for indent lines
				tab_char = "│", -- Character to use for tab indents
			},
			scope = {
				enabled = true, -- Enable scope highlighting (current code block)
				show_start = true, -- Show start of scope
				show_end = false, -- Don't show end of scope
			},
			exclude = {
				filetypes = {
					"help", -- Don't show guides in help files
					"alpha", -- Don't show guides in alpha (dashboard)
					"dashboard", -- Don't show guides in dashboard
					"neo-tree", -- Don't show guides in file explorer
					"Trouble", -- Don't show guides in trouble (diagnostics)
					"lazy", -- Don't show guides in lazy (plugin manager)
				},
			},
		})
	end,
}
