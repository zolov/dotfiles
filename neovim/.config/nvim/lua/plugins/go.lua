return {
    "ray-x/go.nvim",
    dependencies = {
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
    opts = {
        lsp_cfg = {
            settings = {
                gopls = {
                    gofumpt = true,
                    codelenses = {
                        gc_details = false,
                        regenerate_cgo = true,
                        generate = true,
                        run_govulncheck = true,
                        test = true,
                        tidy = true,
                        upgrade_dependency = true,
                        vendor = true,
                    },
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        compositeLiteralTypes = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                    analyses = {
                        fieldalignment = true,
                        nilness = true,
                        unusedparams = true,
                        unusedwrite = true,
                        useany = true,
                    },
                    diagnosticsDelay = "1s",
                    diagnosticsTrigger = "Edit",
                    usePlaceholders = true,
                    completeUnimported = true,
                    staticcheck = true,
                    directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                    semanticTokens = true,
                },
            },
        },
        lsp_keymaps = false,
        lsp_inlay_hints = {
            enable = true,
        },
        lsp_on_client_start = function()
            -- gopls doesn't differentiate between types of keywords (import, function, repeat, conditional),
            -- so we fall back to Tree-sitter highlights for these.
            vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {})
        end,
    },
}
