local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "folke/neodev.nvim",
        "b0o/schemastore.nvim",
        "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    },
}

local function lsp_keymaps(bufnr)
    local opts = { buffer = bufnr, silent = true }
    local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
    end

    map("gD", "<cmd>Telescope lsp_type_definitions<CR>", "Goto Declaration")
    map("gd", "<cmd>Lspsaga goto_definition<CR>", "Goto Definition")
    map("gi", "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation")
    map("gr", "<cmd>Telescope lsp_references<CR>", "References")
    map("gl", vim.diagnostic.open_float, "Open float")
    map("gy", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
    map("gk", vim.lsp.buf.signature_help, "Signature Help")
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)

    -- require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

    if client:supports_method("textDocument/inlayHint", bufnr) then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

M.toggle_inlay_hints = function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end

function M.common_capabilities()
    local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if status_ok then
        return cmp_nvim_lsp.default_capabilities()
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    }
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    return capabilities
end

function M.config()
    local wk = require("which-key")
    wk.add({
        {
            "]d",
            function()
                vim.diagnostic.jump({ count = 1, float = true })
            end,
            desc = "Next Diagnostic",
        },
        {
            "[d",
            function()
                vim.diagnostic.jump({ count = -1, float = true })
            end,
            desc = "Prev Diagnostic",
        },
        { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
        { "<leader>lh", "<cmd>lua require('plugins.lsp').toggle_inlay_hints()<CR>", desc = "Hints" },
        { "<leader>q", "<cmd>Trouble quickfix<cr>", desc = "Quickfix" },
        { "<leader>lq", "<cmd>lua vim.diagnostic.setqflist()<cr>", desc = "Quickfix" },
        { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", desc = "CodeLens Action" },
        { "<leader>a", mode = { "n", "v" }, "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
        -- { "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "Format" },
        { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
    })

    local servers = {
        "lua_ls",
        "pyright",
        "bashls",
        "jsonls",
        "yamlls",
        "marksman",
        "rust_analyzer",
        "gopls",
        "terraformls",
        "tofu_ls",
    }

    local default_diagnostic_config = {
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = require("config.utils").lsp_icons.Error,
                [vim.diagnostic.severity.WARN] = require("config.utils").lsp_icons.Warn,
                [vim.diagnostic.severity.INFO] = require("config.utils").lsp_icons.Info,
                [vim.diagnostic.severity.HINT] = require("config.utils").lsp_icons.Hint,
            },
        },
        virtual_text = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(default_diagnostic_config)

    local border = require("config.utils").border
    vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
        return vim.lsp.handlers.hover(err, result, ctx, vim.tbl_deep_extend("force", config or {}, { border = border }))
    end
    vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
        return vim.lsp.handlers.signature_help(
            err,
            result,
            ctx,
            vim.tbl_deep_extend("force", config or {}, { border = border })
        )
    end
    require("lspconfig.ui.windows").default_options.border = "rounded"

    for _, server in pairs(servers) do
        local opts = {
            on_attach = M.on_attach,
            capabilities = M.common_capabilities(),
        }

        local require_ok, settings = pcall(require, "plugins.lsp.servers." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
        end

        if server == "lua_ls" then
            require("neodev").setup({})
        end

        vim.lsp.config(server, opts)
    end

    vim.lsp.enable(servers)
end

return M
