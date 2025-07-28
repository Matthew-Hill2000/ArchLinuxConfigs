--[[
NVIM-AUTOPAIRS
==============
Automatic bracket, quote, and parentheses pairing. Intelligently inserts closing
brackets and quotes when typing opening ones. Integrates with treesitter and
completion for smart behavior in different code contexts.

Key Bindings:
- Auto-insertion: Automatic when typing (, [, {, ", '
- Alt+e: Fast wrap (surround selection with brackets)
- Backspace: Smart deletion of pairs
--]]

return {
	"windwp/nvim-autopairs", -- Plugin for automatically closing brackets, quotes, etc.
	event = "InsertEnter", -- Load only when entering insert mode for performance
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true,                                    -- Use treesitter to check for valid pairs
			ts_config = {
				lua = { "string", "source" },                   -- Don't auto-pair in lua strings
				javascript = { "string", "template_string" },   -- Don't auto-pair in JS strings
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" }, -- Disable in these filetypes
			fast_wrap = {
				map = "<M-e>",                                  -- Alt+e to trigger fast wrap
				chars = { "{", "[", "(", '"', "'" },            -- Characters that can be wrapped
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""), -- Pattern for wrapping
				offset = 0,                                     -- Cursor offset after wrapping
				end_key = "$",                                  -- Key to move to end of wrapped text
				keys = "qwertyuiopzxcvbnmasdfghjkl",            -- Keys available for fast wrap selection
				check_comma = true,                             -- Check for comma when wrapping
				highlight = "PmenuSel",                         -- Highlight group for selection
				highlight_grey = "LineNr",                      -- Highlight group for non-selected options
			},
		})

		-- Integration with nvim-cmp (completion)
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done()) -- Auto-pair after completion
	end,
}
