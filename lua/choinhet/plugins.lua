require("lazy").setup({
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
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

    -- LSP Config
    { "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },

    -- Autocompletion (nvim-cmp)
    { "hrsh7th/nvim-cmp",      event = "InsertEnter" },
    { "hrsh7th/cmp-nvim-lsp",  dependencies = { "hrsh7th/nvim-cmp" } },

    -- Snippets
    { "L3MON4D3/LuaSnip",      event = "InsertEnter" },

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
    },
})
