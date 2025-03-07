vim.g.mapleader = " "
vim.opt.clipboard = "unnamed,unnamedplus"
vim.g.omni_sql_no_default_maps = 1

vim.opt.shell = "pwsh"
vim.opt.shellcmdflag = "-NoLogo -Command"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 50

vim.keymap.set("n", "<space>a", "ggVG", { noremap = true, silent = true })
vim.keymap.set("n", "<space>f", "")

-- Visual mode mappings for indentation
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Normal mode mappings
vim.keymap.set('n', 'Y', 'y$', { desc = 'Yank to the end of the line' })
vim.keymap.set('n', '*', '*``', { desc = 'Search for word under cursor and return cursor to original position' })

-- Visual mode paste mappings
vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste and reselect, keeping register intact' })

-- Scroll mappings with cursor centering
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center cursor' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center cursor' })

vim.keymap.set('n', '<leader>o', function() vim.ui.open(vim.fn.expand("%")) end)

vim.keymap.set('n', '<leader>rp', function()
    local current_filepath = vim.fn.expand("%:.:r")
    local module_path = current_filepath:gsub("[\\/]", ".")
    local command = string.format("python -m %s", module_path)
    vim.api.nvim_command("vsplit | terminal " .. command)
end)

vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand("%:t"))
end, { desc = "Copy current file name to clipboard" })
