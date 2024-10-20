-- TODO Сравнить с Comform
-- TODO Добавить comform и проверить форматирование в Java
local M = {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
}

function M.config()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting

    null_ls.setup({
        debug = true,
        sources = {
            formatting.stylua,
            formatting.prettier,
        },
    })
end

return M
