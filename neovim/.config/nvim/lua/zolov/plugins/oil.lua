return {
  "stevearc/oil.nvim",
  opts = {},
  config = function()
    require("oil").setup({
      lsp_file_methods = {
        -- Enable or disable LSP file operations
        enabled = false,
      },
      keymaps = {
        ["q"] = "actions.close",
      },
      float = {
        -- Padding around the floating window
        padding = 10,
      },
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
      },
      win_options = {
        wrap = true,
      },
      -- Open parent directory in current window
    })
    vim.keymap.set("n", "<space>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

    -- Open parent directory in floating window
    vim.keymap.set("n", "-", require("oil").toggle_float, { desc = "Oil float" })
  end,
}
