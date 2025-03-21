vim.opt.signcolumn = "yes"

local lspconfig = require("lspconfig")
local cmp_nvim = require("cmp_nvim_lsp")
local mason = require("mason")
local mason_config = require("mason-lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")

local lspconfig_defaults = lspconfig.util.default_config

mason.setup({})

mason_config.setup({
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
            lspconfig[server_name].setup({})
        end,
    }
})

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    "force",
    lspconfig_defaults.capabilities,
    cmp_nvim.default_capabilities()
)

lspconfig.tailwindcss.setup {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    root_dir = lspconfig.util.root_pattern("tailwind.config.js", "package.json"),
    settings = {},
}


vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "gh", function() vim.diagnostic.open_float(nil, { focusable = true, border = "rounded" }) end,
            opts)
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set({ "n", "x" }, "<leader>f", function() vim.lsp.buf.format() end, opts)
        vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "ge", function()
            vim.diagnostic.setqflist()
            vim.cmd("copen")
        end, opts)
    end,
})


local select_next = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    else
        fallback()
    end
end, { "i", "s" })

local select_prev = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    else
        fallback()
    end
end, { "i", "s" })


cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ["<Tab>"] = select_next,
        ["<S-Tab>"] = select_prev,
        ["<C-n>"] = select_next,
        ["<C-p>"] = select_prev,
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer",  keyword_length = 2 },
        { name = "path",    keyword_length = 2 },
    }),
})
