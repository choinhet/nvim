return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap",
        "mfussenegger/nvim-dap-python",
        { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = false,
    branch = "regexp",
    config = function()
        require("venv-selector").setup({
            settings = {
                search = {
                    my_venvs = {
                        command = "fd python$ ~/IdeaProjects",
                    },
                    find_code_venvs = {
                        command = "fd /bin/python([\\d.]+)?$ ~/IdeaProjects --full-path",
                    },
                    find_programming_venvs = {
                        command = "fd /bin/python$ ~/IdeaProjects --full-path -IHL -E /proc",
                    },
                },
            },
        })
    end,
    keys = {
        { "lv", "<cmd>VenvSelect<cr>" },
    },
}
