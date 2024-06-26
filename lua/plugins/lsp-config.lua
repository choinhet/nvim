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
    "jedi_language_server",
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
            local cmp = require("cmp")
			local lspconfig = require("lspconfig")

            vim.opt.winhighlight = cmp.config.window.bordered().winhighlight -- Hover window looks nice

            vim.diagnostic.config({
                float = { border = "rounded" },
                virtual_text = true,
                signs = true,
                update_in_insert = true,
                underline = true,
            })
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })

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
