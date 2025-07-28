--[[
GRUVBOX MATERIAL THEME
======================
Warm, retro-inspired colorscheme with excellent contrast and readability. Provides
a comfortable coding environment with muted colors that reduce eye strain during
long coding sessions.

Key Bindings:
- None (theme-only plugin)
--]]

return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		-- Optionally configure and load the colorscheme
		-- directly inside the plugin declaration.
		vim.g.gruvbox_material_enable_italic = true
		vim.cmd.colorscheme("gruvbox-material")
	end,
}
