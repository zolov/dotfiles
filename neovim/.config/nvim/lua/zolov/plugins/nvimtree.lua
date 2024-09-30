local M = {}
local HEIGHT_RATIO = 0.6 -- You can change this
local WIDTH_RATIO = 0.3 -- You can change this too

M.width = function()
	return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
end

M.build_win_cfg = function()
	local screen_w = vim.opt.columns:get()
	local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
	local window_w = screen_w * WIDTH_RATIO
	local window_h = screen_h * HEIGHT_RATIO
	local window_w_int = math.floor(window_w)
	local window_h_int = math.floor(window_h)
	local center_x = (screen_w - window_w) / 2
	local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
	return {
		border = "rounded",
		relative = "editor",
		row = center_y,
		col = center_x,
		width = window_w_int,
		height = window_h_int,
	}
end

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- Fancy icon support
	},

	cmd = { "NvimTreeToggle", "NvimTreeFocus" },
	config = function()
		require("nvim-tree").setup({
			disable_netrw = true,
			hijack_netrw = true,
			respect_buf_cwd = true,
			sync_root_with_cwd = true,
			update_cwd = true,

			actions = {
				open_file = { window_picker = { enable = false } },
			},

			update_focused_file = {
				enable = true,
				update_cwd = true,
			},

			view = {
				relativenumber = true,
				float = {
					enable = true,
					open_win_config = M.build_win_cfg(),
				},
				width = M.width(),
			},
		})
	end,
}
