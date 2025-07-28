--[[
NVIM-TREESITTER
===============
Advanced syntax highlighting and code parsing engine. Provides accurate syntax
highlighting, smart indentation, and text objects for multiple programming
languages. Much more accurate than traditional regex-based highlighting.

Key Bindings:
- None (automatic syntax highlighting)
- Enhanced text objects and motions are provided automatically
--]]

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"python",
				"cpp",
				"c", -- C++ parser also needs C
				"javascript",
				"html",
				"css", -- Usually helpful with HTML
				"lua",
				"vim", -- For editing Neovim config
				"vimdoc", -- For Neovim help files
				"query", -- For treesitter queries
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
