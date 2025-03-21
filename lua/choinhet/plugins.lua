require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
    },
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "tpope/vim-surround",
        event = "VeryLazy",
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        dependencies = { "hrsh7th/nvim-cmp" },
    },
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
    },
    {
        "saadparwaiz1/cmp_luasnip",
        event = "InsertEnter",
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "echasnovski/mini.icons" },
        cmd = "Oil",
    },
    {
        "mfussenegger/nvim-dap",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
    },
    {
        "dhruvasagar/vim-table-mode",
    }
})
