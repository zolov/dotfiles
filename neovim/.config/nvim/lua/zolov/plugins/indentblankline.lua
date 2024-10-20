-- TODO Настроить отображение linebreak

local highlight = {
    "RainbowDelimiterBlue",
    "RainbowDelimiterGreen",
    "RainbowDelimiterCyan",
    "RainbowDelimiterOrange",
    "RainbowDelimiterYellow",
    "RainbowDelimiterRed",
    "RainbowDelimiterViolet",
}

local M = {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function() end,
}

function M.config()
    local hooks = require("ibl.hooks")

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
    end)

    vim.g.rainbow_delimiters = { highlight = highlight }

    require("ibl").setup({
        indent = {
            char = "·",
        },
        exclude = {
            -- filetypes = { 'rust', 'c', 'c++', 'zig', 'lua' }
        },
        -- whitespace = {
        -- 	highlight = { "Whitespace", "NonText" },
        -- },
        scope = {
            enabled = true,
            highlight = highlight,
        },
    })
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return M
