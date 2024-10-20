return {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
        local rainbow_delimiters = require("rainbow-delimiters.setup")
        rainbow_delimiters.setup({
            -- strategy = {
            --     [""] = rainbow_delimiters.strategy["global"],
            --     vim = rainbow_delimiters.strategy["local"],
            -- },
            query = {
                [""] = "rainbow-delimiters",
                lua = "rainbow-blocks",
            },
            highlight = {
                "RainbowDelimiterBlue",
                "RainbowDelimiterGreen",
                "RainbowDelimiterOrange",
                "RainbowDelimiterCyan",
                "RainbowDelimiterRed",
                "RainbowDelimiterYellow",
                "RainbowDelimiterViolet",
            },
            -- blacklist = { "c", "cpp" },
        })
    end,
}
