return {
    "nvimdev/lspsaga.nvim",
    opts = {
        code_action_prompt = {
            virtual_text = false,
        },
    },
    config = function(opts)
        require("lspsaga").setup(opts)

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
