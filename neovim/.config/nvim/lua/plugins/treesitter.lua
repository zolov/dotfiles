local parsers = {
    "html",
    "lua",
    "java",
    "bash",
    "markdown",
    "markdown_inline",
    "go",
    "gomod",
    "gowork",
    "gosum",
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    dependencies = {
        "windwp/nvim-ts-autotag",
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            branch = "main",
        },
    },
    config = function()
        require("nvim-treesitter").setup()

        vim.api.nvim_create_autocmd("FileType", {
            pattern = parsers,
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })

        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,
            },
            move = {
                set_jumps = true,
            },
        })

        local select = require("nvim-treesitter-textobjects.select")
        local swap = require("nvim-treesitter-textobjects.swap")
        local move = require("nvim-treesitter-textobjects.move")
        local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

        vim.keymap.set({ "x", "o" }, "a=", function()
            select.select_textobject("@assignment.outer", "textobjects")
        end, { desc = "Select outer part of assignment" })
        vim.keymap.set({ "x", "o" }, "i=", function()
            select.select_textobject("@assignment.inner", "textobjects")
        end, { desc = "Select inner part of assignment" })
        vim.keymap.set({ "x", "o" }, "l=", function()
            select.select_textobject("@assignment.lhs", "textobjects")
        end, { desc = "Select left hand side of assignment" })
        vim.keymap.set({ "x", "o" }, "r=", function()
            select.select_textobject("@assignment.rhs", "textobjects")
        end, { desc = "Select right hand side of assignment" })
        vim.keymap.set({ "x", "o" }, "aa", function()
            select.select_textobject("@parameter.outer", "textobjects")
        end, { desc = "Select outer part of a parameter" })
        vim.keymap.set({ "x", "o" }, "ia", function()
            select.select_textobject("@parameter.inner", "textobjects")
        end, { desc = "Select inner part of a parameter" })
        vim.keymap.set({ "x", "o" }, "af", function()
            select.select_textobject("@function.outer", "textobjects")
        end, { desc = "Select outer part of a function" })
        vim.keymap.set({ "x", "o" }, "if", function()
            select.select_textobject("@function.inner", "textobjects")
        end, { desc = "Select inner part of a function" })
        vim.keymap.set({ "x", "o" }, "ac", function()
            select.select_textobject("@class.outer", "textobjects")
        end, { desc = "Select outer part of a class" })
        vim.keymap.set({ "x", "o" }, "ic", function()
            select.select_textobject("@class.inner", "textobjects")
        end, { desc = "Select inner part of a class" })
        vim.keymap.set({ "x", "o" }, "ai", function()
            select.select_textobject("@conditional.outer", "textobjects")
        end, { desc = "Select outer part of a conditional" })
        vim.keymap.set({ "x", "o" }, "ii", function()
            select.select_textobject("@conditional.inner", "textobjects")
        end, { desc = "Select inner part of a conditional" })
        vim.keymap.set({ "x", "o" }, "al", function()
            select.select_textobject("@loop.outer", "textobjects")
        end, { desc = "Select outer part of a loop" })
        vim.keymap.set({ "x", "o" }, "il", function()
            select.select_textobject("@loop.inner", "textobjects")
        end, { desc = "Select inner part of a loop" })

        vim.keymap.set("n", "<leader>rspn", function()
            swap.swap_next("@parameter.inner")
        end, { desc = "Swap next parameter" })
        vim.keymap.set("n", "<leader>rsfn", function()
            swap.swap_next("@function.outer")
        end, { desc = "Swap next function" })
        vim.keymap.set("n", "<leader>rspp", function()
            swap.swap_previous("@parameter.inner")
        end, { desc = "Swap previous parameter" })
        vim.keymap.set("n", "<leader>rsfp", function()
            swap.swap_previous("@function.outer")
        end, { desc = "Swap previous function" })

        vim.keymap.set({ "n", "x", "o" }, "]f", function()
            move.goto_next_start("@call.outer", "textobjects")
        end, { desc = "Next function call start" })
        vim.keymap.set({ "n", "x", "o" }, "]m", function()
            move.goto_next_start("@function.outer", "textobjects")
        end, { desc = "Next method/function def start" })
        vim.keymap.set({ "n", "x", "o" }, "]c", function()
            move.goto_next_start("@class.outer", "textobjects")
        end, { desc = "Next class start" })
        vim.keymap.set({ "n", "x", "o" }, "]i", function()
            move.goto_next_start("@conditional.outer", "textobjects")
        end, { desc = "Next conditional start" })
        vim.keymap.set({ "n", "x", "o" }, "]l", function()
            move.goto_next_start("@loop.outer", "textobjects")
        end, { desc = "Next loop start" })
        vim.keymap.set({ "n", "x", "o" }, "]s", function()
            move.goto_next_start("@local.scope", "locals")
        end, { desc = "Next scope" })
        vim.keymap.set({ "n", "x", "o" }, "]z", function()
            move.goto_next_start("@fold", "folds")
        end, { desc = "Next fold" })
        vim.keymap.set({ "n", "x", "o" }, "]F", function()
            move.goto_next_end("@call.outer", "textobjects")
        end, { desc = "Next function call end" })
        vim.keymap.set({ "n", "x", "o" }, "]M", function()
            move.goto_next_end("@function.outer", "textobjects")
        end, { desc = "Next method/function def end" })
        vim.keymap.set({ "n", "x", "o" }, "]C", function()
            move.goto_next_end("@class.outer", "textobjects")
        end, { desc = "Next class end" })
        vim.keymap.set({ "n", "x", "o" }, "]I", function()
            move.goto_next_end("@conditional.outer", "textobjects")
        end, { desc = "Next conditional end" })
        vim.keymap.set({ "n", "x", "o" }, "]L", function()
            move.goto_next_end("@loop.outer", "textobjects")
        end, { desc = "Next loop end" })
        vim.keymap.set({ "n", "x", "o" }, "[f", function()
            move.goto_previous_start("@call.outer", "textobjects")
        end, { desc = "Prev function call start" })
        vim.keymap.set({ "n", "x", "o" }, "[m", function()
            move.goto_previous_start("@function.outer", "textobjects")
        end, { desc = "Prev method/function def start" })
        vim.keymap.set({ "n", "x", "o" }, "[c", function()
            move.goto_previous_start("@class.outer", "textobjects")
        end, { desc = "Prev class start" })
        vim.keymap.set({ "n", "x", "o" }, "[i", function()
            move.goto_previous_start("@conditional.outer", "textobjects")
        end, { desc = "Prev conditional start" })
        vim.keymap.set({ "n", "x", "o" }, "[l", function()
            move.goto_previous_start("@loop.outer", "textobjects")
        end, { desc = "Prev loop start" })
        vim.keymap.set({ "n", "x", "o" }, "[F", function()
            move.goto_previous_end("@call.outer", "textobjects")
        end, { desc = "Prev function call end" })
        vim.keymap.set({ "n", "x", "o" }, "[M", function()
            move.goto_previous_end("@function.outer", "textobjects")
        end, { desc = "Prev method/function def end" })
        vim.keymap.set({ "n", "x", "o" }, "[C", function()
            move.goto_previous_end("@class.outer", "textobjects")
        end, { desc = "Prev class end" })
        vim.keymap.set({ "n", "x", "o" }, "[I", function()
            move.goto_previous_end("@conditional.outer", "textobjects")
        end, { desc = "Prev conditional end" })
        vim.keymap.set({ "n", "x", "o" }, "[L", function()
            move.goto_previous_end("@loop.outer", "textobjects")
        end, { desc = "Prev loop end" })

        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
}
