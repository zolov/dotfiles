return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            sh = { "beautysh" },
            bash = { "beautysh" },
            rust = { "rustfmt" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            java = {},
            lua = { "stylua" },
            go = { "gofumpt" },
            html = { "prettierd" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            markdown = { "prettierd" },
            xml = { "xmlformat" },
            json = { "prettierd" },
            python = { "black" },
            yaml = { "yamlfmt" },
            sql = { "sqlfluff" },
            mysql = { "sqlfluff" },
            plsql = { "sqlfluff" },
        },
        formatters = {
            sqlfluff = {
                args = { "fix", "--dialect", "postgres", "-" },
            },
        },
        format_on_save = {
            timeout_ms = 5000,
            lsp_fallback = true,
        },
    },
}
