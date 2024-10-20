-- TODO Настроить отображение linebreak 

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
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
		vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
		vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
		vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
		vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
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
