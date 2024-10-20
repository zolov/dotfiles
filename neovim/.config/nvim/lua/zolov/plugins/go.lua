return {
    "ray-x/go.nvim",
    ft = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
    opts = {
        lsp_cfg = {
            settings = {
                gopls = {
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        constantValues = true,
                        functionTypeParameters = true,
                    },
                    diagnosticsDelay = "1s",
                    diagnosticsTrigger = "Edit",
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
