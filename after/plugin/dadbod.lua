vim.api.nvim_set_keymap('n', '<leader>db', ':DBUIToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dbo', ':DBUIOpen<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dbc', ':DBUIClose<CR>', { noremap = true, silent = true })

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_auto_execute_table_helpers = 1
