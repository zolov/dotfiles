return {
    "OXY2DEV/foldtext.nvim",
    lazy = false,
    config = function()
        local def = require("foldtext").configuration
        local handler = function(_, buf)
            local ln = table.concat(vim.fn.getbufline(buf, vim.v.foldstart))
            local markers = ln:match("^%s*([#]+)")
            local heading_txt = ln:match("^%s*[#]+(.+)$")

            local icons = {
                "󰎤",
                "󰎩",
                "󰎪",
                "󰎮",
                "󰎱",
                "󰎵",
            }

            return {
                icons[vim.fn.strchars(markers or "")] .. heading_txt,
                "MarkviewHeading" .. vim.fn.strchars(markers or ""),
            }
        end
        local spaces = function(_, buf)
            local ln = table.concat(vim.fn.getbufline(buf, vim.v.foldstart))
            local markers = ln:match("^%s*([#]+)")
            local heading_txt = ln:match("^%s*[#]+(.+)$")

            return {
                string.rep(" ", vim.o.columns - vim.fn.strchars(heading_txt) - 1),
                "MarkviewHeading" .. vim.fn.strchars(markers or ""),
            }
        end
        custom = vim.list_extend(def, {
            {
                ft = { "markdown" },
                config = {
                    { type = "indent" },
                    {
                        type = "custom",
                        handler = handler,
                    },
                    {
                        type = "custom",
                        handler = spaces,
                    },
                },
            },
        })
    end,
}
