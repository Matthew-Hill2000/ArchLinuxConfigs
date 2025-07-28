--[[
LUALINE (STATUS LINE)
====================
Modern status line that displays useful information about the current buffer,
git status, diagnostics, and editor mode. Integrates with the gruvbox-material
theme for a cohesive visual experience.

Key Bindings:
- None (status display only)
--]]

return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "gruvbox-material",
			},
		})
	end,
}
