return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        -- { "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
        "hrsh7th/cmp-nvim-lsp-signature-help",
        {
            "L3MON4D3/LuaSnip",
            dependencies = {
                "saadparwaiz1/cmp_luasnip",
                "rafamadriz/friendly-snippets",
            },
            version = "2.*",
        },
        build = "make install_jsregexp",
    },

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local kind_icons = require("zolov.config.utils").old_cmp_icons

        require("luasnip.loaders.from_vscode").lazy_load()

        luasnip.config.setup({})

        cmp.setup({
            formatting = {
                expandable_indicator = true,
                fields = { "abbr", "kind", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = string.format("%s %s", string.lower(vim_item.kind), kind_icons[vim_item.kind])
                    vim_item.menu = ({
                        nvim_lsp = " | lsp",
                        luasnip = " | snp",
                        buffer = " | buf",
                        path = " | path",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<C-y>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
                -- ["<Tab>"] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         cmp.select_next_item()
                --     elseif luasnip.expand_or_locally_jumpable() then
                --         luasnip.expand_or_jump()
                --     else
                --         fallback()
                --     end
                -- end, { "i", "s" }),
                -- ["<S-Tab>"] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         cmp.select_prev_item()
                --     elseif luasnip.locally_jumpable(-1) then
                --         luasnip.jump(-1)
                --     else
                --         fallback()
                --     end
                -- end, { "i", "s" }),
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = {
                { name = "nvim_lsp_signature_help" },
                { name = "nvim_lsp", keyword_length = 1, max_item_count = 10 },
                { name = "nvim_lua", keyword_length = 1, max_item_count = 5 },
                { name = "luasnip", keyword_length = 1, max_item_count = 8 },
                { name = "path" },
                { name = "buffer", keyword_length = 5 },
            },
        })
    end,
}
