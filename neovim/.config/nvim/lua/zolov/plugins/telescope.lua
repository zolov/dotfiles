return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false,
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-ui-select.nvim",
            "telescope-dap.nvim",
            { "nvim-telescope/telescope-file-browser.nvim", enabled = true },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "TelescopeResults",
                callback = function(ctx)
                    vim.api.nvim_buf_call(ctx.buf, function()
                        vim.fn.matchadd("TelescopeParent", "\t\t.*$")
                        vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
                    end)
                end,
            })

            telescope.setup({
                file_ignore_patterns = { "%.git/." },
                defaults = {
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                            ["<C-j>"] = actions.move_selection_next, -- move to next result
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
                        },
                    },
                    path_display = {
                        "filename_first",
                    },
                    previewer = true,
                    initial_mode = "insert",
                    select_strategy = "reset",
                    sorting_strategy = "ascending",
                    color_devicons = true,
                    layout_strategy = "horizontal",
                    layout_config = {
                        prompt_position = "top",
                        preview_cutoff = 120,
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--glob=!.git/",
                    },
                },
                pickers = {
                    find_files = {
                        previewer = true,
                        layout_config = {
                            height = 0.4,
                            prompt_position = "top",
                            preview_cutoff = 120,
                        },
                    },
                    git_files = {
                        previewer = true,
                        -- path_display = formattedName,
                        layout_config = {
                            height = 0.4,
                            prompt_position = "top",
                            preview_cutoff = 120,
                        },
                    },
                    buffers = {
                        mappings = {
                            i = {
                                ["<c-d>"] = actions.delete_buffer,
                            },
                            n = {
                                ["<c-d>"] = actions.delete_buffer,
                            },
                        },
                        previewer = true,
                        initial_mode = "normal",
                        -- theme = "dropdown",
                        layout_config = {
                            height = 0.4,
                            width = 0.6,
                            prompt_position = "top",
                            preview_cutoff = 120,
                        },
                    },
                    current_buffer_fuzzy_find = {
                        previewer = true,
                        layout_config = {
                            prompt_position = "top",
                            preview_cutoff = 120,
                        },
                    },
                    live_grep = {
                        only_sort_text = true,
                        previewer = true,
                    },
                    grep_string = {
                        only_sort_text = true,
                        previewer = true,
                    },
                    lsp_references = {
                        show_line = false,
                        previewer = true,
                    },
                    treesitter = {
                        show_line = false,
                        previewer = true,
                    },
                    colorscheme = {
                        enable_preview = true,
                    },
                },
                extensions = {
                    file_browser = {
                        path = "%:p:h", -- open from within the folder of your current buffer
                        display_stat = false, -- don't show file stat
                        grouped = true, -- group initial sorting by directories and then files
                        hidden = true, -- show hidden files
                        hide_parent_dir = true, -- hide `../` in the file browser
                        hijack_netrw = true, -- use telescope file browser when opening directory paths
                        prompt_path = true, -- show the current relative path from cwd as the prompt prefix
                        use_fd = true, -- use `fd` instead of plenary, make sure to install `fd`
                    },
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            previewer = false,
                            initial_mode = "normal",
                            sorting_strategy = "ascending",
                            layout_strategy = "horizontal",
                            layout_config = {
                                horizontal = {
                                    width = 0.5,
                                    height = 0.4,
                                    preview_width = 0.6,
                                },
                            },
                        }),
                    },
                },
            })
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
            telescope.load_extension("file_browser")
			telescope.load_extension("projects")
        end,
    },
}
