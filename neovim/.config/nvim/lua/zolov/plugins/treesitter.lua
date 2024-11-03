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
            },
        })
    end,
}
