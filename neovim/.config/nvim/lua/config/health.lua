local M = {}

local required_nvim = { 0, 10, 0 }

local function version_at_least(version)
    local current = vim.version()
    if current.major ~= version[1] then
        return current.major > version[1]
    end
    if current.minor ~= version[2] then
        return current.minor > version[2]
    end
    return current.patch >= version[3]
end

local function executable_status(name)
    if vim.fn.executable(name) == 1 then
        return "ok"
    end
    return "missing"
end

local function plugin_status(name)
    local ok = pcall(require, "lazy.core.config")
    if not ok then
        return "lazy.nvim is not loaded"
    end

    local plugin = require("lazy.core.config").plugins[name]
    if plugin and plugin._.installed then
        return "ok"
    end
    return "missing"
end

function M.report()
    local lines = {
        "Neovim config health",
        "",
        string.format("nvim >= 0.10.0: %s", version_at_least(required_nvim) and "ok" or "outdated"),
        string.format("git: %s", executable_status("git")),
        string.format("make: %s", executable_status("make")),
        string.format("lua-language-server: %s", executable_status("lua-language-server")),
        string.format("stylua: %s", executable_status("stylua")),
        string.format("lazy.nvim: %s", plugin_status("lazy.nvim")),
        string.format("nvim-lspconfig: %s", plugin_status("nvim-lspconfig")),
        string.format("blink.cmp: %s", plugin_status("blink.cmp")),
        string.format("lazydev.nvim: %s", plugin_status("lazydev.nvim")),
    }

    vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "Config health" })
end

vim.api.nvim_create_user_command("ConfigHealth", M.report, {
    desc = "Show a compact health report for this Neovim config",
})

return M
