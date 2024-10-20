local M = {}

M.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

M.lsp_icons = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

M.cmp_icons = {
    Array = " ",
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Namespace = " ",
    Null = " ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
}

M.old_cmp_icons = {
    Text = "󰉿",
    Method = "m",
    Function = "󰊕",
    Constructor = "",
    Field = "",
    Variable = "󰆧",
    Class = "󰌗",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰇽",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰊄",
}

M.spinners = {
    "",
    "󰪞",
    "󰪟",
    "󰪠",
    "󰪡",
    "󰪢",
    "󰪣",
    "󰪤",
    "󰪥",
    "󰪤",
    "󰪣",
    "󰪢",
    "󰪡",
    "󰪠",
    "󰪟",
    "󰪞",
    "",
}

M.telescope_git_or_file = function()
    local path = vim.fn.expand("%:p:h")
    local git_dir = vim.fn.finddir(".git", path .. ";")
    if #git_dir > 0 then
        require("telescope.builtin").git_files()
    else
        require("telescope.builtin").find_files()
    end
end

M.toggle_set_color_column = function()
    if vim.wo.colorcolumn == "" then
        vim.wo.colorcolumn = "80"
    else
        vim.wo.colorcolumn = ""
    end
end

M.toggle_cursor_line = function()
    if vim.wo.cursorline then
        vim.wo.cursorline = false
    else
        vim.wo.cursorline = true
    end
end

M.toggle_go_test = function()
    -- Get the current buffer's file name
    local current_file = vim.fn.expand("%:p")
    if string.match(current_file, "_test.go$") then
        -- If the current file ends with '_test.go', try to find the corresponding non-test file
        local non_test_file = string.gsub(current_file, "_test.go$", ".go")
        if vim.fn.filereadable(non_test_file) == 1 then
            -- Open the corresponding non-test file if it exists
            vim.cmd.edit(non_test_file)
        else
            print("No corresponding non-test file found")
        end
    else
        -- If the current file is a non-test file, try to find the corresponding test file
        local test_file = string.gsub(current_file, ".go$", "_test.go")
        if vim.fn.filereadable(test_file) == 1 then
            -- Open the corresponding test file if it exists
            vim.cmd.edit(test_file)
        else
            print("No corresponding test file found")
        end
    end
end

-- Copy the current file path and line number to the clipboard, use GitHub URL if in a Git repository
M.copyFilePathAndLineNumber = function()
    local current_file = vim.fn.expand("%:p")
    local current_line = vim.fn.line(".")
    local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree"):match("true")

    if is_git_repo then
        local current_repo = vim.fn.systemlist("git remote get-url origin")[1]
        local current_branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]

        -- Convert Git URL to GitHub web URL format
        current_repo = current_repo:gsub("git@github.com:", "https://github.com/")
        current_repo = current_repo:gsub("%.git$", "")

        -- Remove leading system path to repository root
        local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        if repo_root then
            current_file = current_file:sub(#repo_root + 2)
        end

        local url = string.format("%s/blob/%s/%s#L%s", current_repo, current_branch, current_file, current_line)
        vim.fn.setreg("+", url)
        print("Copied to clipboard: " .. url)
    else
        -- If not in a Git directory, copy the full file path
        vim.fn.setreg("+", current_file .. "#L" .. current_line)
        print("Copied full path to clipboard: " .. current_file .. "#L" .. current_line)
    end
end

---@alias lsp.Client.filter {id?: number, bufnr?: number, name?: string, method?: string, filter?:fun(client: lsp.Client):boolean}

---@param opts? lsp.Client.filter
function M.get_clients(opts)
    local ret = {} ---@type vim.lsp.Client[]
    if vim.lsp.get_clients then
        ret = vim.lsp.get_clients(opts)
    else
        ---@diagnostic disable-next-line: deprecated
        ret = vim.lsp.get_active_clients(opts)
        if opts and opts.method then
            ---@param client vim.lsp.Client
            ret = vim.tbl_filter(function(client)
                return client.supports_method(opts.method, { bufnr = opts.bufnr })
            end, ret)
        end
    end
    return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

---@param on_attach fun(client:vim.lsp.Client, buffer)
---@param name? string
function M.on_attach(on_attach, name)
    return vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf ---@type number
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and (not name or client.name == name) then
                return on_attach(client, buffer)
            end
        end,
    })
end

return M
