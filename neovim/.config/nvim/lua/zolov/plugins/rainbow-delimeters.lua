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
