-- TODO сменить цвет хайлат групп для уведомлений lsp
return {
  "j-hui/fidget.nvim",
  opts = {
    progress = {
      suppress_on_insert = false,
      display = {
        render_limit = 16, -- How many LSP messages to show at once
        done_ttl = 3, -- How long a message should persist after completion
        done_icon = require("zolov.config.icons").ui.Circle, -- Icon shown when all LSP progress tasks are complete
        done_style = "Constant", -- Highlight group for completed LSP tasks
        progress_ttl = math.huge, -- How long a message should persist when in progress
        -- Icon shown when LSP progress tasks are in progress
        progress_icon = { pattern = require("zolov.config.utils").spinners, period = 1 },
      },
    },
    notification = {
      window = {
        winblend = 0, -- Background color opacity in the notification window
      },
    },
    integration = {
      ["nvim-tree"] = {
        enable = false, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
      },
    },
  },
}
