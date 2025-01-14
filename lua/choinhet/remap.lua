vim.g.mapleader = " "
vim.opt.clipboard = "unnamed,unnamedplus"
vim.o.shell="powershell.exe"

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
