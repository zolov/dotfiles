return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.opt.laststatus = 0
  end,
  config = function()
    vim.opt.laststatus = 3
    local lualine = require("lualine")
    local icons = require("zolov.config.icons")
    lualine.setup({
      options = {
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha" },
      },
      sections = {
        lualine_a = {
          -- { "mode", right_padding = 2 },
          { "mode", separator = { left = "", right = "" }, right_padding = 2 },
        },
        lualine_b = {
          "branch",
          "diagnostics",
          {
            "diff",
            colored = true, -- Displays a colored diff status if set to true
            symbols = {
              added = icons.git.LineAdded .. " ",
              modified = icons.git.LineModified .. " ",
              removed = icons.git.LineRemoved .. " ",
            }, -- Changes the symbols used by the diff.
            source = nil, -- A function that works as a data source for diff.
            -- It must return a table as such:
            --   { added = add_count, modified = modified_count, removed = removed_count }
            -- or nil on failure. count <= 0 won't be displayed.
          },
        },
        lualine_c = {
          {

            "filename",
            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 0,
            -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory

            symbols = {
              modified = icons.ui.Pencil .. " ", -- Text to show when the file is modified.
              readonly = icons.ui.Lock .. " ", -- Text to show when the file is non-modifiable or readonly.
            },
          },
        },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        -- lualine_z = {
        -- 	{ "location", left_padding = 2 },
        -- },
        lualine_z = {
          { "location", separator = { right = "", left = "" }, left_padding = 2 },
        },
      },
      extensions = { "nvim-tree", "fzf" },
    })
  end,
}
