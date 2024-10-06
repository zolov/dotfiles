local opts = { silent = true }
local command_opts = { expr = true }
local fn = vim.fn

local modes = {
	normal_mode = "n",
	insert_mode = "i",
	terminal_mode = "t",
	visual_mode = "v",
	visual_block_mode = "x",
	command_mode = "c",
}

local function forward_search()
	if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
		return "<CR>/<C-r>/"
	end
	return "<C-z>"
end

local function backward_search()
	if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
		return "<CR>?<C-r>/"
	end
	return "<S-Tab>"
end

local keymaps = {
	normal_mode = {
    -- Line movement
    ["H"] = "^",
    ["L"] = "$",
		-- Better window navigation
    ["<Leader>wv"] = "<C-w>v",
    ["<Leader>ws"] = "<C-w>s",
    ["<Leader>wb"] = "<C-w>=",
    ["<Leader>wx"] = ":close<CR>",
		["<C-j>"] = "<C-w>j",
		["<C-k>"] = "<C-w>k",
		["<C-h>"] = "<C-w>h",
		["<C-l>"] = "<C-w>l",
		-- Move Next Window
		["<Leader>w"] = "<C-w>w",
		-- Close Window
		-- ["Q"] = ":bp|bd #<CR>",
    ["<Leader>x"] = ":bp|bd #<CR>",
    -- Tabs 
		["<Leader>to"] = ":tabnew<CR>",
		["<Leader>tx"] = ":tabclose<CR>",
		["<Leader>tn"] = ":tabn<CR>",
		["<Leader>tp"] = ":tabp<CR>",
		-- Center screen on up and down half page
		["<C-u>"] = "<C-u>zz",
		["<C-d>"] = "<C-d>zz",

		-- Resize with arrows
		["<C-Up>"] = ":resize +2<CR>",
		["<C-Down>"] = ":resize -2<CR>",
		["<C-Left>"] = ":vertical resize +2<CR>",
		["<C-Right>"] = ":vertical resize -2<CR>",
		-- Navigate buffers
		["<M-.>"] = ":bnext<CR>",
		["<M-,>"] = ":bprevious<CR>",
		-- Indent lines
		["<"] = "<<",
		[">"] = ">>",
    ["<C-q>"] = "<cmd> q <CR>",
    ["<C-s>"] = "<cmd> w <CR>",
    ["<Leader>sn"] = "<cmd> noautocmd w <CR>",
    ["x"] = '"_x',
    -- Refactor
    ["<Leader>ri"] = ":Refactor inline_var",
    ["<Leader>rI"] = ":Refactor inline_func",
    ["<Leader>rb"] = ":Refactor extract_block",
    ["<Leader>rbf"] = ":Refactor extract_block_to_file",
	},
	insert_mode = {
		-- exit other mode
		["jk"] = "<Esc>",
	},
	terminal_mode = {},
	visual_mode = {
    -- Line movement
    ["H"] = "^",
    ["L"] = "$",
		-- Better Paste
		["p"] = '"_dP',
		-- exit other modes
		-- ["jk"] = "<Esc>",
		-- Indent lines
		["<"] = "<gv",
		[">"] = ">gv",
		-- Move text up and down
		["<A-J>"] = ":m '>+1<CR>gv=gv",
		["<A-K>"] = ":m '<-2<CR>gv=gv",
    -- Refactor
    ["<Leader>re"] = ":Refactor extract ",
    ["<Leader>rf"] = ":Refactor extract_to_file ",
    ["<Leader>rv"] = ":Refactor extract_var",
	},
	visual_block_mode = {
		-- Better Paste 
		["<leader>p"] = '"_dP',
    -- Refactor
    ["<Leader>re"] = ":Refactor extract ",
    ["<Leader>rf"] = ":Refactor extract_to_file ",
    ["<Leader>rv"] = ":Refactor extract_var",
	},
	command_mode = {
		-- Word Search Increment and Decrement
		["ab>"] = forward_search,
		["<S-Tab>"] = backward_search,
	},
}

for i, k in pairs(keymaps.normal_mode) do
	vim.keymap.set(modes.normal_mode, i, k, opts)
end

for i, k in pairs(keymaps.insert_mode) do
	vim.keymap.set(modes.insert_mode, i, k, opts)
end

for i, k in pairs(keymaps.terminal_mode) do
	vim.keymap.set(modes.terminal_mode, i, k, opts)
end

for i, k in pairs(keymaps.visual_mode) do
	vim.keymap.set(modes.visual_mode, i, k, opts)
end

for i, k in pairs(keymaps.visual_block_mode) do
	vim.keymap.set(modes.visual_block_mode, i, k, opts)
end

for i, k in pairs(keymaps.command_mode) do
	vim.keymap.set(modes.command_mode, i, k, command_opts)
end

-- vim.api.nvim_set_keymap("i", "<CR>", "v:lua._G.cr_action()", { noremap = true, expr = true })

-- tabs complete
vim.api.nvim_set_keymap("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", [[pumvisible() ? "\<c-P>" : "\<S-Tab>"]], { noremap = true, expr = true })

