local oil = require("oil")

oil.setup({
    vim.api.nvim_set_keymap("n", "-", ":Oil<CR>", { noremap = true, silent = true }),
    delete_to_trash = true,
    view_options = {
        show_hidden = true,
    }
})
