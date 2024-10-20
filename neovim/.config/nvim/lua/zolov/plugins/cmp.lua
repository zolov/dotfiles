return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "onsails/lspkind.nvim",
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = true,
        },
        {
            "saadparwaiz1/cmp_luasnip",
            dependencies = {
                {
                    "L3MON4D3/LuaSnip",
                    dependencies = "rafamadriz/friendly-snippets",
                    build = function()
                        if string.find(vim.loop.os_uname().sysname, "Windows") then
                            return "echo Build it on WSL"
                        else
                            return "make install_jsregexp"
                        end
                    end,
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
            },
        },
    },

    config = function()
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local kind_icons = require("zolov.config.utils").cmp_icons
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        luasnip.config.setup({})

        local auto_select = true
        cmp.setup({
            sorting = require("cmp.config.default")().sorting,
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            completion = {
                completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            sources = {
                { name = "codeium" },
                { name = "path" },
                { name = "calc" },
                { name = "luasnip" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "buffer", group_index = 2 },
                { name = "nvim_lsp_signature_help" },
            },
            formatting = {
                expandable_indicator = true,
                fields = { "abbr", "kind", "menu" },
                format = function(entry, item)
                    item.kind = string.format("%s %s", string.lower(item.kind), kind_icons[item.kind])
                    item.menu = ({
                        codeium = " | AI ",
                        nvim_lsp = " | LSP",
                        luasnip = " | SNP",
                        buffer = " | BUF",
                        path = " | PATH",
                    })[entry.source.name]
                    return item
                end,
            },
            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText",
                },
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-y>"] = cmp.mapping.confirm({ select = true, behavior = "replace" }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
        })

        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "nvim_lsp_document_symbol" },
            }, {
                { name = "buffer" },
            }),
        })
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                },
            }),
        })
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
