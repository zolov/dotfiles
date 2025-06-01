return {
    "olimorris/persisted.nvim",
    lazy = false,
    opts = {
        autostart = true, -- Automatically start the plugin on load?

        -- Function to determine if a session should be saved
        ---@type fun(): boolean
        should_save = function()
            -- Do not save if the alpha dashboard is the current filetype
            if vim.bo.filetype == "alpha" then
                return false
            end
            vim.notify("Session saved")
            return true
        end,

        save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- Directory where session files are saved

        follow_cwd = false, -- Change the session file to match any change in the cwd?
        use_git_branch = true, -- Include the git branch in the session file name?
        autoload = false, -- Automatically load the session for the cwd on Neovim startup?

        -- Function to run when `autoload = true` but there is no session to load
        ---@type fun(): any
        on_autoload_no_session = function()
            vim.notify("No existing session to load")
        end,

        -- Table of dirs that the plugin will start and autoload from
        allowed_dirs = {
            "~/dotfiles",
            "~/Projects",
            "~/Dropbox/work-vault",
            "~/Dropbox/Zettelkasten",
        },

        -- Table of dirs that are ignored for starting and autoloading
        ignored_dirs = {},

        telescope = {
            mappings = { -- Mappings for managing sessions in Telescope
                copy_session = "<C-c>",
                change_branch = "<C-b>",
                delete_session = "<C-d>",
            },
            icons = { -- icons displayed in the Telescope picker
                selected = " ",
                dir = "  ",
                branch = " ",
            },
        },
    },
}
