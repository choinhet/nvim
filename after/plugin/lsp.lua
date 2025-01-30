require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
    "lua_ls",                   -- Lua
    "rust_analyzer",            -- Rust
    "pyright",                  -- Python LSP
    "ruff",                     -- Python linter
    "cssls",                    -- CSS LSP (CSS, SCSS, LESS)
    "html",                     -- HTML LSP
    "jsonls",                   -- JSON LSP
    "marksman",                 -- Markdown LSP
    "tsserver",                 -- TypeScript/JavaScript LSP
    "tailwindcss",              -- Tailwind CSS LSP
    "taplo",                    -- TOML LSP
    "gopls",                    -- Go LSP
    "eslint",                   -- ESLint for JS/TS
    "emmet_ls",                 -- Emmet LSP
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

