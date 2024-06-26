local servers = {
    "biome",
    "kotlin_language_server",
    "lua_ls",
    "marksman",
    "elixirls",
    "jsonls",
    "html",
    "cssls",
    "pyright",
    "ruff_lsp",
    "tsserver",
}

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
				ensure_installed = servers,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "ge", vim.diagnostic.goto_next, {})
            vim.keymap.set("n", "gE", vim.diagnostic.goto_prev, {})
            vim.keymap.set("n", "gu", vim.lsp.buf.references, {})
            vim.keymap.set("n", "gh", vim.diagnostic.open_float, {})
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
            vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})

            for _, server in ipairs(servers) do
                lspconfig[server].setup({
                    capabilities = capabilities,
                })
            end

		end,
	},
}
