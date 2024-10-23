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

        local springboot = require("springboot-nvim")
        --stylua: ignore
        which_key.add({

            -- Dashboard
            { "<leader>;", ":Alpha<CR>", nowait = true, remap = false, },
            
            -- Windows
            { "<leader>w", group = "Windows", nowait = true, remap = false, },
            { "<leader>wv", ":vsplit<CR>", desc = "Vsplit", nowait = true, remap = false, },
            { "<leader>ws", ":split<CR>", desc = "Split", nowait = true, remap = false, },
            { "<leader>wm", ":MaximizerToggle<CR>", desc = "Maximize", nowait = true, remap = false, },
            { "<leader>wx", ":bd<CR>", desc = "Close", nowait = true, remap = false, },
            { "<leader>wb", "<C-w>=", desc = "Balance", nowait = true, remap = false, },

            -- Tabs
            { "<leader>t", group = "Tabs", nowait = true, remap = false, },
            { "<leader>to", ":tabnew<CR>", desc = "New tab", nowait = true, remap = false, },
            { "<leader>tx", ":tabclose<CR>", desc = "Close tab", nowait = true, remap = false, },
            { "<leader>tn", ":tabn<CR>", desc = "Next tab", nowait = true, remap = false, },
            { "<leader>tp", ":tabp<CR>", desc = "Previous tab", nowait = true, remap = false, },

            -- Utils
            { "<leader>u", group = "Utils", nowait = true, remap = false, },
            { "<leader>uc", ":Telescope commands<CR>", desc = "[C]ommands", silent = true, nowait = true, remap = false, },
            { "<leader>us", ":Telescope spell_suggest<CR>", desc = "[S]pelling Suggestions", silent = true, nowait = true, remap = false, },
            { "<leader>uH", ":Telescope highlights<cr>", desc = "[H]ighlights", silent = true, nowait = true, remap = false },
            { "<leader>uh", ":Telescope help_tags<cr>", desc = "Find [H]elp Tags", silent = true, nowait = true, remap = false },
            { "<leader>?", ":Telescope keymaps<cr>", desc = "Find [K]eymaps", nowait = true, remap = false },
            { "<leader>uq", ":qa!<cr>", desc = "Force [Q]uit", nowait = true, remap = false },

            -- Bookmarks
            { "<leader>b", group = "Bookmarks", nowait = true, remap = false },
            { "<leader>bp", ":Telescope bookmarks<CR>", silent = true, nowait = true, remap = false },
            { "<leader>ba", ":lua require('bookmarks').add_bookmarks(false)<CR>", desc = "Add bookmark", silent = true, nowait = true, remap = false, },
            { "<leader>bd", ":lua require('bookmarks.list').delete_on_virt()<CR>", desc = "Delete bookmark", silent = true, nowait = true, remap = false, },

			-- Projects and Sessions
            { "<leader>p", group = "Projects and Sessions", nowait = true, remap = false },
            { "<leader>po", ":Telescope projects<CR>", silent = true, nowait = true, remap = false },
            { "<leader>ps", ":SessionSave<CR>", desc = "Save session", nowait = true, remap = false, },
            { "<leader>pl", ":SessionLoad<CR>", desc = "Load session", nowait = true, remap = false, },
            { "<leader>pp", ":Telescope persisted<CR>", desc = "Select session", nowait = true, remap = false, },
            { "<leader>pd", ":SessionDelete<CR>", desc = "Delete session", nowait = true, remap = false, },

            -- Buffers
            { "<leader>o", ":Telescope buffers<cr>", desc = "[O]pen Buffer list", nowait = true, remap = false },

            -- NvimTree
            { "<leader>e", ":NvimTreeToggle<CR>", desc = "[E]xplorer", nowait = true, remap = false },
            { "<leader>E", ":cd", desc = "Change Working Directory", silent = false, nowait = true, remap = false },

            -- Fuzzy Find
            { "<leader>f", group = "Find *", nowait = true, remap = false },
            { "<leader>ff", ":lua require('zolov.config.utils').telescope_git_or_file()<cr>", desc = "Find files", nowait = true, remap = false, },
            { "<leader>fg", ":Telescope live_grep<CR>", desc = "Find Text", nowait = true, remap = false },
            { "<leader>fr", ":Telescope oldfiles<cr>", desc = "Find recent files", nowait = true, remap = false },
            { "<leader>fs", ":Telescope lsp_document_symbols<cr>", desc = "Find workspace symbols", nowait = true, remap = false, },
            { "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "File [B]rowser", nowait = true, remap = false, },
			{ "<leader>/", ":Telescope current_buffer_fuzzy_find<CR>", desc="Search current buffer", nowait = true, remap = false, },

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

            
            -- Diagnostics
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)", },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)", },
            { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)", },
            { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
            { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)", },
            { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)", },

            -- Refactor
            { "<leader>r", group = "Refactor", nowait = true, remap = false },
            { "<leader>rr", ":lua require('telescope').extensions.refactoring.refactors()<CR>", desc = "Refactor", mode = { "n", "x" }, nowait = true, remap = false, },
            { "<leader>rn", ":Lspsaga rename<CR>", desc = "[R]ename", silent = true, nowait = true, remap = false, },
            { "<leader>rf", ":Refactor extract_func<CR>", desc = "Extract function", mode = "x", silent = true, nowait = true, remap = false, },
            { "<leader>rv", ":Refactor extract_var<CR>", desc = "Extract variable", mode = "x", silent = true, nowait = true, remap = false, },
            { "<leader>ri", ":Refactor inline_var<CR>", desc = "inline var", mode = { "x", "n" }, silent = true, nowait = true, remap = false, },
            { "<leader>rI", ":Refactor inline_func<CR>", desc = "inline func", silent = true, nowait = true, remap = false, },
            { "<leader>rR", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Replace all in file" },

            -- LSP
            { "d]", ":lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic", nowait = true, remap = false },
            { "[d", ":lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic", nowait = true, remap = false },
            { "<leader>ld", ":Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics", nowait = true, remap = false, },

            { "<leader>l", group = "LSP", nowait = true, remap = false },
            { "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", desc = "Code Action", nowait = true, remap = false },
            { "<leader>lr", ":Telescope lsp_references<cr>", desc = "References", nowait = true, remap = false },
            { "<leader>lS", ":Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = true, remap = false, },
            { "<leader>la", ":lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
            { "<leader>lf", ":lua require('conform').format()<cr>", desc = "Format", nowait = true, remap = false },
            { "<leader>lq", ":Telescope quickfix<cr>", desc = "Quickfix List", nowait = true, remap = false },
            { "<leader>ls", ":Telescope lsp_document_symbols<cr>", desc = "Document Symbols", nowait = true, remap = false, },
            -- vim.keymap.set({ "n", "v" }, "<Leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Code action" })
            -- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover" })
            -- vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", { desc = "Rename" })

            { "<leader>lh", "<cmd>lua require('zolov.plugins.lspconfig').toggle_inlay_hints()<CR>", desc = "Hints" },
            { "<leader>q", "<cmd>Trouble quickfix<cr>", desc = "Quickfix" },
            { "<leader>lq", "<cmd>lua vim.diagnostic.setqflist()<cr>", desc = "Quickfix" },
            { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", desc = "CodeLens Action" },
            { "<leader>a", mode = { "n", "v" }, "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
            -- { "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "Format" },
            { "<leader>ca", mode = {"n", "v" }, "<cmd>Lspsaga code_action<cr>", desc = "Code action" },
            { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover" },

            -- Terminal
            { "<leader>t", group = "Terminal", nowait = true, remap = false },
            { "<leader>tf", ":ToggleTerm direction=float<cr>", desc = "Terminal Float", nowait = true, remap = false },
            { "<leader>tt", ":ToggleTerm size=10 direction=horizontal<cr>", desc = "Terminal Horizontal", nowait = true, remap = false, },
            { "<leader>tv", ":ToggleTerm size=50 direction=vertical<cr>", desc = "Terminal Vertical", nowait = true, remap = false, },

            -- Notes
            {"<leader>n", group = "Notes", nowait = true, remap = false},
            {"<leader>nt", ":Markview toggle<cr>", desc = "[T]oggle Markview Rendering", nowait = true, remap = false},
            {"<leader>nn", ":ObsidianNew<cr>", desc = "Create [N]ew Note", nowait = true, remap = false},
            {"<leader>nf", ":ObsidianFollowLink<cr>", desc = "Follow [L]ink", nowait = true, remap = false},

            {"<leader>np", group = "Notes preview", nowait = true, remap = false},
            {"<leader>npp", ":MarkdownPreview<cr>", desc = "Open Markdown [P]review", nowait = true, remap = false},
            {"<leader>nps", ":MarkdownPreviewStop<cr>", desc = "[S]top Markdown Preview", nowait = true, remap = false},
            {"<leader>npt", ":MarkdownPreviewToggle<cr>", desc = "[T]oggle Markdown Preview", nowait = true, remap = false},

            -- Java 
            { "<leader>j", group = "Java", nowait = true, remap = false },
            { "<leader>jb", group = "Java [B]uild and Run", nowait = true, remap = false },
            { "<leader>jbi", ":TermExec cmd='mvn clean install -U -X'<CR>", desc = "Clean Install - with tests", nowait = true, remap = false, },
            { "<leader>jbb", ":TermExec cmd='mvn clean install -U -X -DskipTests'<CR>", desc = "Clean Install - skip tests", nowait = true, remap = false, },
            { "<leader>jbs", ":TermExec cmd='sh start", desc = "Run start script", nowait = true, remap = false, },
            { "<leader>jbd", ":TermExec cmd='mvn spring-boot:run -Pdev'", desc = "Run Dev Profile", nowait = true, remap = false, },
            { "<leader>jbr", springboot.boot_run, desc = "Spring Boot Run", nowait = true, remap = false },

            -- Refactoring
            { "<leader>jo", ":lua require('jdtls').organize_imports()<CR>", desc = "Organize Imports" },
            { "<leader>jv", mode = { "v" }, "<Esc><cmd>lua require('jdtls').extract_variable(true)<CR>", desc = "Extract variable", nowait = true, remap = false, },
            { "<leader>jv", mode = { "n" }, "<cmd>lua require('jdtls').extract_variable()<CR>", desc = "Extract variable", nowait = true, remap = false, },
            { "<leader>jm", mode = { "v" }, "<Esc><cmd>lua require('jdtls').extract_method()<CR>", desc = "Extract method", nowait = true, remap = false, },

            -- Tests
            { "<leader>jt", group = "Test", nowait = true, remap = false },
            { "<leader>jtc", ":lua require('jdtls').test_class()<CR>", desc = "Class" },
            { "<leader>jtm", ":lua require('jdtls').test_nearest_method()<CR>", desc = "Nearest Method" },

            -- Generate
            { "<leader>jg", group = "Generate", nowait = true, remap = false },
            { "<leader>jgc", springboot.generate_class, desc = "Generate Class", nowait = true, remap = false },
            { "<leader>jgi", springboot.generate_interface, desc = "Generate Interface", nowait = true, remap = false },
            { "<leader>jge", springboot.generate_enum, desc = "Generate Enum", nowait = true, remap = false },
            { "<leader>jgr", springboot.generate_record, desc = "Generate Record", nowait = true, remap = false },
        })
    end,
}