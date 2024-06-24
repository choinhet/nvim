return {
    "anekos/tailiscope.nvim",
    branch="fix/support-case-sensitive-filesystems",
    config = function()
        require("telescope").load_extension("tailiscope")
        vim.keymap.set("n", "<leader>fw", "<cmd>Telescope tailiscope<cr>")
    end,
}
