return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  config = function()
    require("trouble").setup({
      auto_preview = true,
      focus = true,
    })

    -- Diagnostic signs
    -- https://github.com/folke/trouble.nvim/issues/52
    local signs = {
      Error = " ",
      Warning = " ",
      Hint = " ",
      Information = " ",
      Other = "﯑ ",
    }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = hl,
      })
    end
  end,

  cmd = "Trouble",
}
