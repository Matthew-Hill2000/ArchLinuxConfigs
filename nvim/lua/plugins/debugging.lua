--[[
NVIM-DAP (DEBUG ADAPTER PROTOCOL)
=================================
Full-featured debugging support for multiple programming languages. Provides breakpoints,
step debugging, variable inspection, and call stack navigation. Includes UI integration
and automatic configuration for Python, C/C++, and Rust.

Key Bindings:
- <leader>db: Toggle breakpoint at current line
- <leader>dc: Continue/start debugging
- <leader>di: Step into function
- <leader>do: Step over current line
- <leader>du: Step out of current function
- <leader>dr: Open debug REPL/console
- <leader>dt: Toggle debug UI panels
--]]

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Setup dap-python (this handles all Python configuration automatically)
		require("dap-python").setup("python")

		-- Configure GDB adapter for C/C++/Rust
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}

		-- Configure C/C++ debugging
		dap.configurations.c = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				pid = function()
					local name = vim.fn.input("Executable name (filter): ")
					return require("dap.utils").pick_process({ filter = name })
				end,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Attach to gdbserver :1234",
				type = "gdb",
				request = "attach",
				target = "localhost:1234",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
		}

		-- Copy C config to C++ and rust
		dap.configurations.cpp = dap.configurations.c
		dap.configurations.rust = dap.configurations.c

		-- Setup dap-ui
		dapui.setup()

		-- FIXED: Use correct listener events
		dap.listeners.after.event_initialized.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Key mappings
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<leader>dc", dap.continue, {})

		-- Optional: Add more useful keymaps
		vim.keymap.set("n", "<leader>di", dap.step_into, {})
		vim.keymap.set("n", "<leader>do", dap.step_over, {})
		vim.keymap.set("n", "<leader>du", dap.step_out, {})
		vim.keymap.set("n", "<leader>dr", dap.repl.open, {})
		vim.keymap.set("n", "<leader>dt", dapui.toggle, {})
	end,
}
