vim.opt.signcolumn = 'yes'

require('lspconfig').lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                -- virtual_text = false, -- disable inline diagnostics
                globals = { 'vim' }
                -- float = {
                --     source = 'always',
                --     border = 'rounded'
                -- }
            }
        }
    }
})

require('lspconfig').eslint.setup({
    settings = {
        packageManager = 'yarn'
    },
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
        vim.keymap.set({ 'n', 'x' }, '<leader>f', function() vim.cmd("EslintFixAll") end, { buffer = bufnr })
    end,
})

local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

require('lspconfig').tailwindcss.setup {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    root_dir = require('lspconfig').util.root_pattern("tailwind.config.js", "package.json"),
    settings = {},
}


vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
        vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
        vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set('n', 'gh', function() vim.diagnostic.open_float(nil, { focusable = true, border = "rounded" }) end, opts)
        vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format() end, opts)
        vim.keymap.set('n', 'ge', function()
            vim.diagnostic.setqflist()
            vim.cmd('copen')
        end, opts)
    end,
})

local cmp = require('cmp')

cmp.setup({
    preselect = cmp.PreselectMode.None, -- Disable automatic preselection
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect', -- Avoid preselecting items
    },
    mapping = {
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Confirm only if explicitly selected
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    }),
})
