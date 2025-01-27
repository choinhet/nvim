require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'rust_analyzer',
        'pyright',
        'ruff',
        'cssls',
        'eslint-lsp',
        'html',
        'jsonls',
        'marksman',
        'ts_ls',
        'tailwindcss',
        'emmet_ls',
        'marksman',
        'taplo',
        'prettier',
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})

local cmp = require('cmp')
cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({}),
})

