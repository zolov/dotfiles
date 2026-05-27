return {
    settings = {
        yaml = {
            schemas = require("schemastore").yaml.schemas(),
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
