return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")
			require("dapui").setup()
			require("dap-python").setup("python3")
			require("dap-python").resolve_python = function()
				local path = require("venv-selector").get_active_path()
				return path
			end

			dap.listeners.before.attach.dapui_config = function()
				require("dapui").open()
			end
			dap.listeners.before.launch.dapui_config = function()
				require("dap-python").resolve_python = function()
					local path = require("venv-selector").get_active_path()
					return path
				end
				require("dapui").open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				require("dapui").close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				require("dapui").close()
			end

			vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<leader>dc", dap.continue, {})

			local opts = { noremap = true, silent = true }

			vim.keymap.set("n", "<leader>dn", ":lua require('dap-python').test_method()<cr>", opts)
			vim.keymap.set("n", "<leader>df", ":lua require('dap-python').test_class()<cr>", opts)
			vim.keymap.set("v", "<leader>ds", ":lua require('dap-python').debug_selection()<cr>", opts)
			vim.keymap.set("n", "<leader>e", "<cmd>lua require('dapui').eval()<cr>", opts)
			vim.keymap.set("v", "<leader>e", "<cmd>lua require('dapui').eval()<cr>", opts)
		end,
	},
}
