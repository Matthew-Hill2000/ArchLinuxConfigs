--[[
NONE-LS (FORMATTING & LINTING)
==============================
Code formatting and linting integration that works with multiple language servers.
Automatically formats code on save and provides real-time diagnostics. Supports
Lua, Python, JavaScript/TypeScript, and C/C++ formatting and linting.

Key Bindings:
- <leader>gf: Manually format current buffer
- Auto-format on save: Automatic (no keybinding needed)
--]]

return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.cpplint,
				null_ls.builtins.diagnostics.cppcheck,
			},
		})

		-- Auto-format on save
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			callback = function()
				vim.lsp.buf.format()
			end,
		})

		-- Manual format
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
