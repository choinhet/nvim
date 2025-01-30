local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("choinhet.plugins")
require("choinhet.remap")

vim.g.firenvim_config = {
    globalSettings = { alt = "all" }, -- Allow manual activation with Ctrl+E
    localSettings = {
        [".*"] = {
            cmdline  = "none",          -- Disable the command line for automatic engagement
            content  = "text",
            priority = 0,               -- Lower priority to prevent auto-engaging
            selector = "textarea",      -- Keep the selector for manual activation
            takeover = "never"          -- Disable automatic takeover
        }
    }
}

vim.api.nvim_create_autocmd({'UIEnter'}, {
    callback = function(event)
        local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
        if client ~= nil and client.name == "Firenvim" then
            vim.o.laststatus = 0
        end
    end
})
