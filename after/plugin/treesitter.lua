vim.g.python3_host_prog = 'python'

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "help", "javascript", "typescript", "python", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
    ignore_install = { "help" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
