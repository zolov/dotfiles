return {
    "rcarriga/nvim-notify",
    keys = {
        {
            "<leader>un",
            function()
                require("notify").dismiss({ silent = true, pending = true })
            end,
            desc = "Delete all notifications",
        },
    },
    opts = {
        background_colour = "#000000",
        timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
    },
}
