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
    "basedpyright",
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
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
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
            vim.keymap.set("v", "<space>ca", vim.lsp.buf.code_action, {})
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
                            pylsp_rope = { enabled = true },
                            rope_autoimport = { enabled = true },
                            basedpyright = {
                                enabled = true,
                                config = {
                                    strict = false,
                                },
                            },
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
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require('dap')
            dap.adapters.python = {
                type = 'executable',
                command = '/usr/bin/python3.12', -- Adjust to your python path
                args = { '-m', 'debugpy.adapter' },
            }
            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = "Launch file",
                    program = "${file}",
                    pythonPath = function()
                        return '/usr/bin/python3.12' -- Adjust to your python path
                    end,
                },
            }
        end,
    },
}
