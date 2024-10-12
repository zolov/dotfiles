-- return {
-- 	{
-- 		-- https://github.com/catppuccin/nvim
-- 		"catppuccin/nvim",
-- 		name = "catppuccin", -- name is needed otherwise plugin shows up as "nvim" due to github URI
-- 		lazy = false, -- We want the colorscheme to load immediately when starting Neovim
-- 		priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
--     integration = {
--       cmp = true,
--     }
-- 		opts = {
-- 			-- Replace this with your scheme-specific settings or remove to use the defaults
-- 			-- transparent = true,
-- 			flavour = "mocha", -- "latte, frappe, macchiato, mocha"
-- 		},
-- 		config = function(_, opts)
-- 			require("catppuccin").setup(opts)
-- 			vim.cmd("colorscheme catppuccin") -- Replace this with your favorite colorscheme
-- 		end,
-- 	},
return {
  "catppuccin/nvim",
  name = "catppuccin",
  tag = "v1.7.0",
  enabled = true,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true

    local catppuccin = require("catppuccin")

    catppuccin.setup({
      flavour = "mocha",
      term_colors = true,
      transparent_background = false,
      styles = {
        conditionals = {},
        functions = { "italic" },
        types = { "bold" },
      },
      color_overrides = {
        mocha = {
          -- base = '#171717', -- background
          surface2 = "#9A9A9A", -- comments
          text = "#F6F6F6",
        },
      },
      highlight_overrides = {
        mocha = function(C)
          return {
            NvimTreeNormal = { bg = C.none },
            CmpBorder = { fg = C.surface2 },
            Pmenu = { bg = C.none },
            NormalFloat = { bg = C.none },
            TelescopeBorder = { link = "FloatBorder" },
          }
        end,
      },
      integrations = {
        barbar = true,
        cmp = true,
        gitsigns = true,
        native_lsp = { enabled = true },
        nvimtree = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
      },
    })

    -- Toggle background transparency
    local toggle_transparency = function()
      local cat = require("catppuccin")
      cat.options.transparent_background = not cat.options.transparent_background
      cat.compile()
      vim.cmd.colorscheme(vim.g.colors_name)
      vim.cmd([[colorscheme catppuccin]])
    end

    vim.keymap.set(
      "n",
      "<leader>ut",
      toggle_transparency,
      { desc = "Toggle transparency", noremap = true, silent = true }
    )

    vim.cmd.colorscheme("catppuccin")
  end,
}
