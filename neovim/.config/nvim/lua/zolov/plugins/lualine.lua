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
					"diff",
					"diagnostics",
				},
				lualine_c = {
					{
						"filename",
						file_status = true, -- Displays file status (readonly status, modified status)
						newfile_status = false, -- Display new file status (new file means no write after created)
						path = 1,
            -- 0: Just the filename
						-- 1: Relative path
						-- 2: Absolute path
						-- 3: Absolute path, with tilde as the home directory
						-- 4: Filename and parent dir, with tilde as the home directory

						symbols = {
							modified = "(+)", -- Text to show when the file is modified.
							readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
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
