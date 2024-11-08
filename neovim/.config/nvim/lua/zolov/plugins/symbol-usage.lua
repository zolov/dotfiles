return {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    config = function()
        require("symbol-usage").setup({
            request_pending_text = "",
        })
    end,
}
