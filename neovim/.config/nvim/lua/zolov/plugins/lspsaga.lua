return {
    "nvimdev/lspsaga.nvim",
    config = function()
        require("lspsaga").setup({
            ui = {
                code_action = require("zolov.config.icons").diagnostics.BoldHint,
            },
            lightbulb = {
                enable = true,
                sign = true,
                debounce = 10,
                sign_priority = 40,
                virtual_text = false,
                enable_in_insert = false,
                ignore = {
                    clients = {},
                    ft = {},
                },
            },
        })
        vim.keymap.set({ "n", "v" }, "<Leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Code action" })
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover" })
        vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", { desc = "Rename" })
    end,
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
}
