return {
    "catppuccin/nvim",
    name = "catppuccin",
    tag = "v1.7.0",
    enabled = true,
    priority = 1000,
    config = function()
        vim.opt.termguicolors = true

        local catppuccin = require("catppuccin")

        catppuccin.setup({
            flavour = "mocha",
            term_colors = true,
            transparent_background = false,
            styles = {
                conditionals = {},
                functions = { "italic" },
                types = { "bold" },
            },
            highlight_overrides = {
                mocha = function(C)
                    return {
                        LspInlayHint = { bg = C.none },
                        NvimTreeNormal = { bg = C.none },
                        NormalFloat = { bg = C.none },
                        TelescopeBorder = { link = "FloatBorder" },
                        NotifyBackground = { bg = C.none },
                    }
                end,
            },
            integrations = {
                barbar = true,
                cmp = true,
                gitsigns = true,
                native_lsp = { enabled = true },
                nvimtree = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
            },
        })

        -- Toggle background transparency
        local toggle_transparency = function()
            local cat = require("catppuccin")
            cat.options.transparent_background = not cat.options.transparent_background
            cat.compile()
            vim.cmd.colorscheme(vim.g.colors_name)
            vim.cmd([[colorscheme catppuccin]])
        end

		-- stylua: ignore
        vim.keymap.set( "n", "<leader>ut", toggle_transparency, { desc = "Toggle transparency", noremap = true, silent = true })

        vim.cmd.colorscheme("catppuccin")
    end,
}
