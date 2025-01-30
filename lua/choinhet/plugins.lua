require("lazy").setup({
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
        config = function()
            local builtin = require('telescope.builtin')
            require('telescope').setup({
                defaults = {
                    cwd = function()
                        return vim.fn.getcwd()
                    end,
                    path_display = { "smart" },
                    mappings = {
                        i = {
                            ["<CR>"] = function(prompt_bufnr)
                                local action_state = require("telescope.actions.state")
                                local actions = require("telescope.actions")
                                local entry = action_state.get_selected_entry()
                                local filepath = entry.path or entry.filename

                                if filepath then
                                    filepath = filepath:gsub("\\", "/")
                                    filepath = vim.fn.fnamemodify(filepath, ":p")
                                else
                                    vim.notify("Error: Invalid file path", vim.log.levels.ERROR)
                                    return
                                end

                                actions.close(prompt_bufnr)
                                vim.cmd("edit " .. filepath)
                            end,
                        },
                    },
                },
            })

            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
            vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>')
            vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>')
        end
    },

    -- Harpoon
    {
        "theprimeagen/harpoon",
        config = function()
            require("harpoon").setup({
                menu = {
                    width = 100,
                    heigh = 15,
                },
            })

            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<C-a>", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
        end
    },

    -- Colorscheme
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup()
            require('onedark').load()
        end
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = { "help", "javascript", "typescript", "python", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
                ignore_install = { "help" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end,

    },

    -- Surround
    { "tpope/vim-surround" },

    -- Mason (LSP Manager)
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({})
        end,
        cmd = "Mason"
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "pyright",
                    "ruff",
                    "cssls",
                    "html",
                    "jsonls",
                    "marksman",
                    "tsserver",
                    "tailwindcss",
                    "taplo",
                    "gopls",
                    "eslint",
                    "emmet_ls",
                },
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                }
            })
        end,
    },

    -- Autocompletion (nvim-cmp)
    { "hrsh7th/nvim-cmp",     event = "InsertEnter" },
    { "hrsh7th/cmp-nvim-lsp", dependencies = { "hrsh7th/nvim-cmp" } },

    -- Snippets
    { "L3MON4D3/LuaSnip",     event = "InsertEnter" },

    -- Firenvim (Browser Plugin)
    {
        "glacambre/firenvim",
        build = function() vim.fn() end,
        cond = not not vim.g.started_by_firenvim,
    },

    -- Autopairs (Automatically close brackets, quotes, etc.)
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    },

    -- Oil.nvim (File Explorer)
    {
        "stevearc/oil.nvim",
        dependencies = { "echasnovski/mini.icons" },
        cmd = "Oil",
        config = function()
            require("oil").setup({
                vim.api.nvim_set_keymap('n', '<leader>pv', ':Oil<CR>', { noremap = true, silent = true }),
                vim.api.nvim_set_keymap('n', '-', ':Oil<CR>', { noremap = true, silent = true }),
                delete_to_trash = true,
                view_options = {
                    show_hidden = true,
                }
            })
        end
    },

    -- LSP Config
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })

            require('lspconfig').eslint.setup({
                settings = {
                    packageManager = 'yarn'
                },
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                    vim.keymap.set({ 'n', 'x' }, '<leader>f', function() vim.cmd("EslintFixAll") end, { buffer = bufnr })
                end,
            })

            local lspconfig_defaults = require('lspconfig').util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            require('lspconfig').tailwindcss.setup {
                cmd = { "tailwindcss-language-server", "--stdio" },
                filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
                root_dir = require('lspconfig').util.root_pattern("tailwind.config.js", "package.json"),
                settings = {},
            }


            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
                    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
                    vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
                    vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts)
                    vim.keymap.set('n', 'gh',
                        function() vim.diagnostic.open_float(nil, { focusable = true, border = "rounded" }) end, opts)
                    vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format() end, opts)
                    vim.keymap.set('n', 'ge', function()
                        vim.diagnostic.setqflist()
                        vim.cmd('copen')
                    end, opts)
                end,
            })

            local cmp = require('cmp')

            cmp.setup({
                preselect = cmp.PreselectMode.None,                 -- Disable automatic preselection
                completion = {
                    completeopt = 'menu,menuone,noinsert,noselect', -- Avoid preselecting items
                },
                mapping = {
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Confirm only if explicitly selected
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                }),
            })

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({}),
            })
        end
    },
})
