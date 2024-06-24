return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
			vim.g.mason_python_path = "/usr/bin/python3.12"
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "pyright", "marksman" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({capabilities = capabilities})
			lspconfig.tsserver.setup({capabilities = capabilities})
			lspconfig.pyright.setup({capabilities = capabilities})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gh", vim.diagnostic.goto_next, {})
			vim.keymap.set("n", "gH", vim.diagnostic.goto_prev, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
		end,
	},
}
