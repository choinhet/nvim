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
        config = function()
            require("onedark").setup()
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "theprimeagen/harpoon",
        event = "VeryLazy",
    },
    {
        "tpope/vim-surround",
        event = "VeryLazy",
    },
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>g", ":G<CR>", { desc = "Open Fugitive" })
            vim.keymap.set("n", "<leader>gc", ":G add -A | Git commit<CR>", { desc = "Commit All" })
            vim.keymap.set("n", "<leader>ga", ":G add -A | Git commit --amend --no-edit<CR>",
                { desc = "Ammend commit all" })
            vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git Push" })
        end,
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
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "echasnovski/mini.icons" },
        cmd = "Oil",
    },
    {
        'mfussenegger/nvim-dap',
        config = function()
            -- Key mappings for nvim-dap
            local dap = require('dap')
            vim.keymap.set('n', '<leader>dn', dap.continue, { desc = 'Start Python Debugging' })
            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
            vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step Over' })
            vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step Into' })
            vim.keymap.set('n', '<leader>du', dap.step_out, { desc = 'Step Out' })
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
        config = function()
            require('dapui').setup({
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.5 },
                            { id = "repl",   size = 0.5 },
                        },
                        size = 40,
                        position = "right",
                    },
                },
            })
            local dap, dapui = require('dap'), require('dapui')
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end

            vim.keymap.set('n', '<leader>dc', require('dap.repl').clear, { desc = 'Clear DAP REPL' })
        end,
    },
    {
        'mfussenegger/nvim-dap-python',
        ft = 'python',
        config = function()
            local dap_python = require('dap-python')
            local function get_python_path()
                local venv_path = os.getenv('VIRTUAL_ENV')
                if venv_path then
                    return venv_path .. '\\Scripts\\python.exe'
                end
                return 'python'
            end
            dap_python.setup(get_python_path())

            require('dap').configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = 'Launch Module',
                    module = function()
                        local current_filepath = vim.fn.expand("%:.:r")
                        return current_filepath:gsub("[\\/]", ".")
                    end,
                },
            }
        end,
    },
    {
        'dhruvasagar/vim-table-mode',
        config = function()
        end
    }
})
