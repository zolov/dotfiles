return {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
        local rainbow_delimiters = require("rainbow-delimiters.setup")
        rainbow_delimiters.setup({
            query = {
                [""] = "rainbow-delimiters",
                latex = "rainbow-blocks",
            },
            highlight = {
                "RainbowDelimiterRed",
                "RainbowDelimiterOrange",
                "RainbowDelimiterYellow",
                "RainbowDelimiterBlue",
                "RainbowDelimiterGreen",
                -- "RainbowDelimiterViolet",
                "RainbowDelimiterCyan",
            },
            blacklist = { "c", "cpp" },
        })
    end,
}
