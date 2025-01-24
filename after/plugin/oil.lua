require("oil").setup({
    vim.api.nvim_set_keymap('n', '<leader>pv', ':Oil<CR>', { noremap = true, silent = true }),
    vim.api.nvim_set_keymap('n', '-', ':Oil<CR>', { noremap = true, silent = true }),
})

