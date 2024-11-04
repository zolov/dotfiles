return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufReadPost", "BufNewFile" },
    dependencies = {
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "lua",
                "java",
                "bash",
                "markdown",
                "markdown_inline",
                "go",
                "gomod",
                "gowork",
                "gosum",
            },
            modules = {},
            ignore_install = {},
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                -- disable = { "markdown" },
                additional_vim_regex_highlighting = true,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            textobjects = {
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>rspn"] = "@parameter.inner",
                        ["<leader>rsfn"] = "@function.outer",
                    },
                    swap_previous = {
                        ["<leader>rspp"] = "@parameter.inner",
                        ["<leader>rsfp"] = "@function.outer",
                    },
                },
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["a="] = { "@assignment.outer", desc = "Select outer part of assignment" },
                        ["i="] = { "@assignment.inner", desc = "Select inner part of assignment" },
                        ["l="] = { "@assignment.lhs", desc = "Select left hand side of assignment" },
                        ["r="] = { "@assignment.rhs", desc = "Select right hand side of assignment" },

                        ["aa"] = { "@parameter.outer", desc = "Select outer part of a parameter" },
                        ["ia"] = { "@parameter.inner", desc = "Select inner part of a parameter" },

                        ["af"] = { "@function.outer", desc = "Select outer part of a function" },
                        ["if"] = { "@function.inner", desc = "Select inner part of a function" },

                        ["ac"] = { "@class.outer", desc = "Select outer part of a class" },
                        ["ic"] = { "@class.inner", desc = "Select inner part of a class" },

                        ["ai"] = { "@conditional.outer", desc = "Select outer part of a conditional" },
                        ["ii"] = { "@conditional.inner", desc = "Select inner part of a conditional" },

                        ["al"] = { "@loop.outer", desc = "Select outer part of a loop" },
                        ["il"] = { "@loop.inner", desc = "Select inner part of a loop" },
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]f"] = { query = "@call.outer", desc = "Next function call start" },
                        ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
                        ["]c"] = { query = "@class.outer", desc = "Next class start" },
                        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

                        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    goto_next_end = {
                        ["]F"] = { query = "@call.outer", desc = "Next function call end" },
                        ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
                        ["]C"] = { query = "@class.outer", desc = "Next class end" },
                        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
                        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                    },
                    goto_previous_start = {
                        ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
                        ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
                        ["[c"] = { query = "@class.outer", desc = "Prev class start" },
                        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
                        ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
                    },
                    goto_previous_end = {
                        ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
                        ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
                        ["[C"] = { query = "@class.outer", desc = "Prev class end" },
                        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
                        ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
                    },
                },
            },
        })
        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        -- vim way: ; goes to the direction you were moving.
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
    end,
}
