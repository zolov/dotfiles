return {
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
        },
    },
    setup = {
        commands = {
            Format = {
                function()
                    vim.lsp.buf.format({ async = false })
                end,
            },
        },
    },
}
