return {
    -- https://github.com/rcarriga/nvim-dap-ui
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
        -- https://github.com/mfussenegger/nvim-dap
        "mfussenegger/nvim-dap",
        -- https://github.com/nvim-neotest/nvim-nio
        "nvim-neotest/nvim-nio",
        -- https://github.com/theHamsta/nvim-dap-virtual-text
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
        },
        -- https://github.com/nvim-telescope/telescope-dap.nvim
        "nvim-telescope/telescope-dap.nvim", -- telescope integration with dap

        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = "mason.nvim",
            cmd = { "DapInstall", "DapUninstall" },
            opts = {
                -- Makes a best effort to setup the various debuggers with
                -- reasonable debug configurations
                automatic_installation = true,

                -- You can provide additional configuration to the handlers,
                -- see mason-nvim-dap README for more information
                handlers = {},

                -- You'll need to check that you have the required things installed
                -- online, please don't ask me how to install them :)
                ensure_installed = {
                    -- Update this to ensure that you have the debuggers for the langs you want
                },
            },
            -- mason-nvim-dap is loaded when nvim-dap loads
            config = function() end,
        },
        {
            "jbyuki/one-small-step-for-vimkind",
			-- stylua: ignore
            config = function()
                local dap = require("dap")
                dap.adapters.nlua = function(callback, conf)
                    local adapter = {
                        type = "server",
                        host = conf.host or "127.0.0.1",
                        port = conf.port or 8086,
                    }
                    if conf.start_neovim then
                        local dap_run = dap.run
                        dap.run = function(c)
                            adapter.port = c.port
                            adapter.host = c.host
                        end
                        require("osv").run_this()
                        dap.run = dap_run
                    end
                    callback(adapter)
                end
                dap.configurations.lua = {
                    {
                        type = "nlua",
                        request = "attach",
                        name = "Run this file",
                        start_neovim = {},
                    },
                    {
                        type = "nlua",
                        request = "attach",
                        name = "Attach to running Neovim instance (port = 8086)",
                        port = 8086,
                    },
                }
            end,
        },
    },
    opts = {
        controls = {
            element = "repl",
            enabled = false,
            icons = {
                disconnect = "",
                pause = "",
                play = "",
                run_last = "",
                step_back = "",
                step_into = "",
                step_out = "",
                step_over = "",
                terminate = "",
            },
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
            border = "single",
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        force_buffers = true,
        icons = {
            collapsed = "",
            current_frame = "",
            expanded = "",
        },
        layouts = {
            {
                elements = {
                    {
                        id = "scopes",
                        size = 0.50,
                    },
                    {
                        id = "stacks",
                        size = 0.30,
                    },
                    {
                        id = "watches",
                        size = 0.10,
                    },
                    {
                        id = "breakpoints",
                        size = 0.10,
                    },
                },
                size = 40,
                position = "left", -- Can be "left" or "right"
            },
            {
                elements = {
                    "repl",
                    "console",
                },
                size = 10,
                position = "bottom", -- Can be "bottom" or "top"
            },
        },
        mappings = {
            edit = "e",
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            repl = "r",
            toggle = "t",
        },
        render = {
            indent = 1,
            max_value_lines = 100,
        },
    },

    config = function(_, opts)
        local dap = require("dap")
        require("dapui").setup(opts)

        dap.listeners.after.event_initialized["dapui_config"] = function()
            require("dapui").open()
        end

        dap.listeners.before.event_terminated["dapui_config"] = function()
            -- Commented to prevent DAP UI from closing when unit tests finish
            -- require('dapui').close()
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
            -- Commented to prevent DAP UI from closing when unit tests finish
            -- require('dapui').close()
        end

        -- Add dap configurations based on your language/adapter settings
        -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

        ---@param config {args?:string[]|fun():string[]?}
        local function get_args(config)
            local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
            config = vim.deepcopy(config)
            ---@cast args string[]
            config.args = function()
                local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
                return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
            end
            return config
        end

        local wk = require("which-key")

		-- stylua: ignore
        wk.add({
            { "<leader>d", group = "Debug", mode = { "n", "v" }, nowait = true, remap = false },
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition", },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue", },
            { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args", },
            { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor", },
            { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)", },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into", },
            { "<leader>dj", function() require("dap").down() end, desc = "Down", },
            { "<leader>dk", function() require("dap").up() end, desc = "Up", },
            { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last", },
            { "<leader>do", function() require("dap").step_out() end, desc = "Step Out", },
            { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over", },
            { "<leader>dp", function() require("dap").pause() end, desc = "Pause", },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL", },
            { "<leader>ds", function() require("dap").session() end, desc = "Session", },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate", },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets", },
            { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI", },
            { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" }, },
        })
    end,
}
