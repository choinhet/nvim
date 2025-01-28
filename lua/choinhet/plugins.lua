require("lazy").setup({
    -- Plugin Manager
    { "wbthomason/packer.nvim", lazy = true },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
    },

    -- Colorscheme
    { "navarasu/onedark.nvim", lazy = false, priority = 1000, config = function() require("onedark").setup() end },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
    },

    -- Visual Multi-cursor
    { "mg979/vim-visual-multi", branch = "master", lazy = false },

    -- Harpoon
    { "theprimeagen/harpoon", event = "VeryLazy" },

    -- Surround
    { "tpope/vim-surround", event = "VeryLazy" },

    -- Mason (LSP Manager)
    { "williamboman/mason.nvim", cmd = "Mason" },
    { "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },

    -- LSP Config
    { "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },

    -- Autocompletion (nvim-cmp)
    { "hrsh7th/nvim-cmp", event = "InsertEnter" },
    { "hrsh7th/cmp-nvim-lsp", dependencies = { "hrsh7th/nvim-cmp" } },

    -- Snippets
    { "L3MON4D3/LuaSnip", event = "InsertEnter" },

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

