return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local status_ok, which_key = pcall(require, "which-key")
        if not status_ok then
            return
        end

        which_key.setup({
            plugins = {
                marks = true, -- shows a list of your marks on ' and `
                registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                spelling = {
                    enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                    suggestions = 20, -- how many suggestions should be shown in the list?
                },
                presets = {
                    operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                    motions = true, -- adds help for motions
                    text_objects = true, -- help for text objects triggered after entering an operator					windows = true, -- default bindings on <c-w>
                    nav = true, -- misc bindings to work with windows
                    z = true, -- bindings for folds, spelling and others prefixed with z
                    g = false, -- bindings for prefixed with g
                },
            },
            icons = {
                breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                separator = "➜", -- symbol used between a key and it's label
                group = "+", -- symbol prepended to a group
            },
            keys = {
                scroll_down = "<c-d>", -- binding to scroll down inside the popup
                scroll_up = "<c-u>", -- binding to scroll up inside the popup
            },
            layout = {
                height = { min = 4, max = 25 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
                spacing = 3, -- spacing between columns
                align = "left", -- align columns left, center or right
            },
            show_help = false, -- show help message on the command line when the popup is visible
        })

        --stylua: ignore
        which_key.add({
            -- Refactor
            { "<leader>rf", ":Refactor extract_func<CR>", desc = "Extract function", mode = "x", silent = true, nowait = true, remap = false, },
            { "<leader>re", ":Refactor extract_block_to_file<CR>", desc = "Extract to file", mode = "x", silent = true, nowait = true, remap = false, },
            { "<leader>rv", ":Refactor extract_var<CR>", desc = "Extract variable", mode = "x", silent = true, nowait = true, remap = false, },
            { "<leader>ri", ":Refactor inline_var<CR>", desc = "inline var", mode = { "x", "n" }, silent = true, nowait = true, remap = false, },
            { "<leader>rI", ":Refactor inline_func<CR>", desc = "inline func", silent = true, nowait = true, remap = false, },
            { "<leader>rb", ":Refactor extract_block<CR>", desc = "Extract block", silent = true, nowait = true, remap = false, },
            { "<leader>rt", ":Refactor extract_block_to_file<CR>", desc = "Extract block to file", silent = true, nowait = true, remap = false, },
            { "<leader>rr", ":lua require('telescope').extensions.refactoring.refactors()<CR>", mode = { "n", "x" }, nowait = true, remap = false, },
            -- { "<leader>R", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Replace all in file" },

            -- Bookmarks
            { "<leader>b", group = "Bookmarks", nowait = true, remap = false },

            { "<leader>bp", ":Telescope bookmarks<CR>", silent = true, nowait = true, remap = false },
            { "<leader>ba", ":lua require('bookmarks').add_bookmarks(false)<CR>", silent = true, nowait = true, remap = false, },
            { "<leader>bd", ":lua require('bookmarks.list').delete_on_virt()<CR>", silent = true, nowait = true, remap = false, },

			-- Projects
            { "<leader>p", group = "Projects", nowait = true, remap = false },
            { "<leader>po", ":Telescope projects<CR>", silent = true, nowait = true, remap = false },

            -- SEARCH
            { "<leader>S", group = "Search", nowait = true, remap = false },
            { "<leader>SC", ":Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
            { "<leader>SH", ":Telescope highlights<cr>", desc = "Highlights", nowait = true, remap = false },
            { "<leader>Sb", ":Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
            { "<leader>Sc", ":Telescope colorschemes<cr>", desc = "Colorscheme", nowait = true, remap = false },
            { "<leader>Sh", ":Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
            { "<leader>Sk", ":Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
            { "<leader>o", ":Telescope buffers<cr>", desc = "Find Buffers", nowait = true, remap = false },

            -- NvimTree
            { "<leader>e", ":NvimTreeToggle<CR>", desc = "Explorer", nowait = true, remap = false },

            -- FZF Find
            { "<leader>f", group = "Files", nowait = true, remap = false },
            -- { "<leader>ff", ":lua require('fzf-lua').files()<cr>", desc = "Find files", nowait = true, remap = false },
            { "<leader>ff", ":lua require('zolov.config.utils').telescope_git_or_file()<cr>", desc = "Find files", nowait = true, remap = false, },
            { "<leader>fg", ":Telescope live_grep<CR>", desc = "Find Text", nowait = true, remap = false },
            { "<leader>fr", ":Telescope oldfiles<cr>", desc = "Find recent files", nowait = true, remap = false },
            { "<leader>fs", ":Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Find workspace symbols", nowait = true, remap = false, },
            { "<leader>fS", ":Telescope spell_suggest<CR>", desc = "Spelling suggestions", silent = true, nowait = true, remap = false, },
            { "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "Telescope file browser", nowait = true, remap = false, },
			{ "<leader>ft", ":Telescope current_buffer_fuzzy_find<CR>", desc="Telescope find string in current buffer", nowait = true, remap = false, },

            -- Git
            { "<leader>g", group = "Git", nowait = true, remap = false },
            { "<leader>gR", ":lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", nowait = true, remap = false, },
            { "<leader>gb", ":Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
            { "<leader>gc", ":Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
            { "<leader>gd", ":Gitsigns diffthis HEAD<cr>", desc = "Diff", nowait = true, remap = false },
            { "<leader>gf", ":Telescope git_files<cr>", desc = "Find tracked files", nowait = true, remap = false },
            { "<leader>gg", ":LazyGit<cr>", desc = "Lazygit", nowait = true, remap = false },
            { "<leader>gj", ":lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", nowait = true, remap = false, },
            { "<leader>gk", ":lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", nowait = true, remap = false, },
            { "<leader>gl", ":lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
            { "<leader>gL", ":GitBlameToggle<cr>", desc = "Blame toggle", nowait = true, remap = false },
            { "<leader>go", ":Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
            { "<leader>gp", ":lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", nowait = true, remap = false, },
            { "<leader>gr", ":lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", nowait = true, remap = false, },
            { "<leader>gs", ":lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk", nowait = true, remap = false, },
            { "<leader>gu", ":lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", nowait = true, remap = false, },

            -- LSP
            { "<leader>l", group = "LSP", nowait = true, remap = false },
            { "<leader>lr", ":Telescope lsp_references<cr>", desc = "References", nowait = true, remap = false },
            { "<leader>lS", ":Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = true, remap = false, },
            { "<leader>la", ":lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
            { "<leader>ld", ":Telescope diagnostics<cr>", desc = "Workspace Diagnostics", nowait = true, remap = false, },
            { "<leader>lf", ":lua require('conform').format()<cr>", desc = "Format", nowait = true, remap = false },
            { "<leader>li", ":LspInfo<cr>", desc = "Info", nowait = true, remap = false },
            { "d]", ":lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic", nowait = true, remap = false },
            { "[d", ":lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic", nowait = true, remap = false },
            { "<leader>lm", ":Mason<cr>", desc = "Mason Installer", nowait = true, remap = false },
            { "<leader>lq", ":Telescope quickfix<cr>", desc = "Quickfix List", nowait = true, remap = false },
            { "<leader>ls", ":Telescope lsp_document_symbols<cr>", desc = "Document Symbols", nowait = true, remap = false, },

            -- Terminal
            { "<leader>t", group = "Terminal", nowait = true, remap = false },
            { "<leader>tf", ":ToggleTerm direction=float<cr>", desc = "Terminal Float", nowait = true, remap = false },
            { "<leader>tt", ":ToggleTerm size=10 direction=horizontal<cr>", desc = "Terminal Horizontal", nowait = true, remap = false, },
            { "<leader>tv", ":ToggleTerm size=50 direction=vertical<cr>", desc = "Terminal Vertical", nowait = true, remap = false, },

            -- { "<leader>xx", ":qa!<cr>", desc = "Exit", nowait = true, remap = false },
            -- Notes
            {"<leader>n", group = "Notes", nowait = true, remap = false},
            {"<leader>nt", ":Markview toggle<cr>", desc = "[T]oggle Markview Rendering", nowait = true, remap = false},
            {"<leader>nn", ":ObsidianNew<cr>", desc = "Create [N]ew Note", nowait = true, remap = false},
            {"<leader>nf", ":ObsidianFollowLink<cr>", desc = "Follow [L]ink", nowait = true, remap = false},
            -- {"<leader>nl", ":ObsidianFollowLink<cr>", desc = "Follow [L]ink", nowait = true, remap = false},

            {"<leader>np", group = "Notes preview", nowait = true, remap = false},
            {"<leader>npp", ":MarkdownPreview<cr>", desc = "Open Markdown [P]review", nowait = true, remap = false},
            {"<leader>nps", ":MarkdownPreviewStop<cr>", desc = "[S]top Markdown Preview", nowait = true, remap = false},
            {"<leader>npt", ":MarkdownPreviewToggle<cr>", desc = "[T]oggle Markdown Preview", nowait = true, remap = false},
        })
    end,
}
