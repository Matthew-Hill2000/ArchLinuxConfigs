--[[
TELESCOPE (FUZZY FINDER)
=======================
Powerful fuzzy finder for files, text, buffers, and more. Provides fast searching
across your entire project with live preview. Essential tool for navigation and
project exploration.

Key Bindings:
- Ctrl+p: Find files in project
- <leader>fg: Live grep (search text in files)
- <leader>fb: Find open buffers
- <leader>fh: Search help documentation
- <leader>fr: Find recent files
- (Within telescope):
  - Ctrl+c/Escape: Close telescope
  - Enter: Select item
  - Ctrl+v: Open in vertical split
  - Ctrl+x: Open in horizontal split
--]]

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "node_modules", ".git/" },
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							preview_width = 0.6,
						},
					},
				},
			})

			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
