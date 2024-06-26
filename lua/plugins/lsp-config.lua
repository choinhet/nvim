local servers = {
	"biome",
	"kotlin_language_server",
	"lua_ls",
	"marksman",
	"elixirls",
	"jsonls",
	"html",
	"cssls",
	"pylsp",
}

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
			vim.g.mason_python_path = "/usr/bin/python3.12"
		end,
		init = function(_)
			local pylsp = require("mason-registry").get_package("python-lsp-server")
			pylsp:on("install:success", function()
				local function mason_package_path(package)
					local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
					return path
				end

				local path = mason_package_path("python-lsp-server")
				local command = path .. "/venv/bin/pip"
				local args = {
					"install",
					"-U",
					"pylsp-rope",
					"python-lsp-black",
					"python-lsp-isort",
					"python-lsp-ruff",
					"pyls-memestra",
					"pylsp-mypy",
				}

				require("plenary.job")
					:new({
						command = command,
						args = args,
						cwd = path,
					})
					:start()
			end)
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
			vim.keymap.set("v", "<space>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
				})
			end

			lspconfig.pylsp.setup({
				cmd = { "pylsp" },
				settings = {
					pylsp = {
						plugins = {
							pylsp_rope = { enabled = true, { rename = { enabled = true } } },
							rope_autoimport = { enabled = true },
						},
					},
				},
				flags = {
					debounce_text_changes = 200,
				},
				capabilities = capabilities,
			})
		end,
	},
}
