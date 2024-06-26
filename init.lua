local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("mappings")
require("lazy").setup("plugins")

-- Desativar arquivos de swap e backup
vim.opt.swapfile = false
vim.opt.backup = false

-- Função para ignorar o aviso de swap file
vim.cmd [[
  function! SkipSwapFilePrompt()
    let v:swapchoice = 'e'
  endfunction
  autocmd SwapExists * call SkipSwapFilePrompt()
]]
