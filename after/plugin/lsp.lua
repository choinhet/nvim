require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "ruff",
        "cssls",
        "html",
        "jsonls",
        "marksman",
        "ts_ls",
        "tailwindcss",
        "taplo",
        "gopls",
        "eslint",
        "emmet_ls",
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})

local cmp = require('cmp')

local select_next = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    else
        fallback()
    end
end, { 'i', 's' })

local select_prev = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    else
        fallback()
    end
end, { 'i', 's' })


cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ['<Tab>'] = select_next,
        ['<S-Tab>'] = select_prev,
        ['<C-n>'] = select_next,
        ['<C-p>'] = select_prev,
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer',  keyword_length = 2 },
        { name = 'path',    keyword_length = 2 },
    }),
})
