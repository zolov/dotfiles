return {
    "mrcjkb/rustaceanvim",
    ft = { "rust", "toml" },
    config = function()
        vim.g.rustaceanvim = {
            tools = {
                code_actions = {
                    ui_select_fallback = true,
                },
                float_win_config = {
                    border = require("zolov.config.utils").border,
                },
            },
            server = {
                on_attach = function(_, bufnr)
                    vim.keymap.set({ "n", "x" }, "gra", require("rustaceanvim.commands.code_action_group"), {
                        buffer = bufnr,
                        desc = "Code Actions",
                    })
                end,
            },
        }
    end,
}
