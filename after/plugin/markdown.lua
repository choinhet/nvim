local markdown = require("render-markdown")

markdown.setup({
    completions = { lsp = { enabled = true } }
})

markdown.enable()
