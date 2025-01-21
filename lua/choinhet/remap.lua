vim.g.mapleader = " "
vim.opt.clipboard = "unnamed,unnamedplus"

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

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
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

-- Prevent copying empty lines to the clipboard when deleting in normal mode
vim.keymap.set('n', 'dd', function()
    if vim.api.nvim_get_current_line():match("^%s*$") then
        return [["_dd]]
    else
        return "dd"
    end
end, { expr = true, desc = "Delete line without copying if empty" })

-- Prevent copying empty lines to the clipboard when deleting in visual mode
vim.keymap.set('v', 'd', function()
    local lines = vim.fn.getline("'<", "'>") -- Get all lines in the visual selection
    local all_empty = true
    for _, line in ipairs(lines) do
        if not line:match("^%s*$") then
            all_empty = false
            break
        end
    end
    if all_empty then
        return [["_d]]
    else
        return "d"
    end
end, { expr = true, desc = "Delete selection without copying if all lines are empty" })

vim.keymap.set('n', '<leader>o', function() vim.ui.open(vim.fn.expand("%")) end)


