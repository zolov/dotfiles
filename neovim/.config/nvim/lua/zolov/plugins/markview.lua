return {
    "OXY2DEV/markview.nvim",
    lazy = true,
    ft = "markdown",

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("markview.extras.editor").setup({
            ---@type [ number, number ]
            width = { 50, 0.75 },

            ---@type [ number, number ]
            height = { 10, 0.75 },

            ---@type integer
            debounce = 50,

            ---@type fun(buf:integer, win:integer): nil
            callback = function(buf, win) end,
        })
    end,
}
