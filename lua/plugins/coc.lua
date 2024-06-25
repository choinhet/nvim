return {
    {
        "neoclide/coc.nvim",
        branch = "release",
        config = function()
            vim.g.coc_global_extensions = {
                "coc-pyright",
                "coc-json",
                "coc-html",
                "coc-css",
                "coc-tsserver",
            }

            function _G.show_documentation()
                local filetype = vim.bo.filetype
                if vim.fn.index({"vim", "help"}, filetype) >= 0 then
                    vim.api.nvim_command("h " .. vim.fn.expand("<cword>"))
                elseif vim.fn["coc#rpc#ready"]() then
                    vim.fn.CocActionAsync("doHover")
                else
                    vim.api.nvim_command("!" .. vim.bo.keywordprg .. " " .. vim.fn.expand("<cword>"))
                end
            end

            vim.api.nvim_set_keymap("n", "K", "<cmd>lua _G.show_documentation()<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "ge", "<Plug>(coc-diagnostic-next)", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "gE", "<Plug>(coc-diagnostic-prev)", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "gu", "<Plug>(coc-references)", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "gi", "<Plug>(coc-implementation)", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<space>ca", "<Plug>(coc-codeaction)", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>rn", "<Plug>(coc-rename)", { noremap = true, silent = true })
            vim.api.nvim_set_keymap(
                "n",
                "<leader>fm",
                "<cmd>CocCommand editor.action.formatDocument<CR>",
                { noremap = true, silent = true }
            )
        end,
    },
    {
        "fannheyward/coc-pyright",
    },
}
