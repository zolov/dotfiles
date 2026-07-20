return {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdLineEnter" },
    version = "1.*",
    dependencies = {
        "neovim/nvim-lspconfig",
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = true,
        },
        {
            "L3MON4D3/LuaSnip",
            dependencies = {
                "rafamadriz/friendly-snippets",
            },
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        "Exafunction/codeium.nvim",
    },

    opts = {
        keymap = {
            preset = "default",
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-y>"] = { "select_and_accept" },
            ["<CR>"] = { "accept", "fallback" },
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            documentation = {
                auto_show = true,
            },
            ghost_text = {
                enabled = true,
            },
            list = {
                selection = {
                    preselect = true,
                    auto_insert = true,
                },
            },
        },
        snippets = {
            preset = "luasnip",
        },
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer", "codeium" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
                codeium = {
                    name = "Codeium",
                    module = "codeium.blink",
                    async = true,
                    score_offset = 90,
                },
                lsp = {
                    fallbacks = {},
                },
            },
        },
        signature = {
            enabled = true,
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning",
        },
    },
    opts_extend = { "sources.default" },
}
