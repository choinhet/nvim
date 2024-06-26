return {
	"choinhet/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python",
	},
	branch = "regexp",
	event = "VeryLazy",
	config = function()
		require("venv-selector").setup()
		vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", {})
	end,
}
