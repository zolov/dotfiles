return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
	},
	opts = {},
	config = function()
		require("barbecue").setup({
			show_dirname = true,
		})
		require("barbecue.ui").toggle(true)
	end,
}
