--[[
WHICH-KEY
=========
Displays available keybindings in a popup window when you start typing a key sequence.
Acts as a command palette and helps discover and remember keybindings. Shows organized
groups of commands with descriptions.

Key Bindings:
- Space (leader): Shows all leader-based commands
- Any partial key sequence: Shows available completions
--]]

return {
	"folke/which-key.nvim", -- Plugin to show available keybindings
	event = "VeryLazy",  -- Load after other plugins for better performance
	config = function()
		local wk = require("which-key")
		wk.setup({
			win = {           -- Updated from 'window' to 'win'
				border = "rounded", -- Rounded border for which-key window
				position = "bottom", -- Show window at bottom of screen
				margin = { 1, 0, 1, 0 }, -- Margin around window (top, right, bottom, left)
				padding = { 2, 2, 2, 2 }, -- Padding inside window (top, right, bottom, left)
			},
		})

		-- Register leader key mappings using new format
		wk.add({
			-- Find group (Telescope)
			{ "<leader>f",  group = "Find" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>",                   desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>",                    desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>",                      desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>",                    desc = "Help Tags" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>",                     desc = "Recent Files" },

			-- Debug group (nvim-dap)
			{ "<leader>d",  group = "Debug" },
			{ "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
			{ "<leader>dc", "<cmd>lua require('dap').continue()<cr>",          desc = "Continue" },
			{ "<leader>di", "<cmd>lua require('dap').step_into()<cr>",         desc = "Step Into" },
			{ "<leader>do", "<cmd>lua require('dap').step_over()<cr>",         desc = "Step Over" },
			{ "<leader>du", "<cmd>lua require('dap').step_out()<cr>",          desc = "Step Out" },
			{ "<leader>dr", "<cmd>lua require('dap').repl.open()<cr>",         desc = "Open REPL" },
			{ "<leader>dt", "<cmd>lua require('dapui').toggle()<cr>",          desc = "Toggle UI" },

			-- Code group (LSP)
			{ "<leader>c",  group = "Code" },
			{ "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>",          desc = "Code Action" },

			-- Git/Format group (none-ls)
			{ "<leader>g",  group = "Git/Format" },
			{ "<leader>gf", "<cmd>lua vim.lsp.buf.format()<cr>",               desc = "Format Buffer" },

			-- File Explorer group (neo-tree)
			{ "<leader>e",  "<cmd>Neotree focus<cr>",                          desc = "Focus File Explorer" },

			-- Buffer management (bufferline)
			{ "<leader>x",  "<cmd>bdelete<cr>",                                desc = "Close Buffer" },

			-- Additional useful mappings
			{ "K",          "<cmd>lua vim.lsp.buf.hover()<cr>",                desc = "Hover Documentation" },
			{ "gd",         "<cmd>lua vim.lsp.buf.definition()<cr>",           desc = "Go to Definition" },
			{ "<C-p>",      "<cmd>Telescope find_files<cr>",                   desc = "Find Files" },
			{ "<C-n>",      "<cmd>Neotree toggle<cr>",                         desc = "Toggle File Explorer" },
		})
	end,
}
