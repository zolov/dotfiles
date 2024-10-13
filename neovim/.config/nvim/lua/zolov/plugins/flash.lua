return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      search = { enabled = false },
    },
    prompt = {
      prefix = {
        { "  ", "FlashPromptIcon" },
        { " ", "FlashPromptSep" },
      },
    },
  },
  --- stylua: ignore
  keys = {
    {
      "s",
      mode = { "n", "o", "x" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
  },
}
