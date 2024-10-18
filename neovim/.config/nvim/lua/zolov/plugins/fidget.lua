-- TODO сменить цвет хайлат групп для уведомлений lsp
return {
  "j-hui/fidget.nvim",
  opts = {
    progress = {
      suppress_on_insert = false,
    },
    notification = {
      window = {
        winblend = 0, -- Background color opacity in the notification window
      },
    },
  },
}
