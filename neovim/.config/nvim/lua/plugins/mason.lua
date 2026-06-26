local M = {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        {
            "williamboman/mason.nvim",
            opts = {
                config = true,
                build = ":MasonUpdate",
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
                registries = {
                    "github:mason-org/mason-registry",
                },
            },
        },
        "stevearc/conform.nvim",
        "zapling/mason-conform.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "nvim-lua/plenary.nvim",
        "jay-babu/mason-nvim-dap.nvim",
    },
}

function M.config()
    require("mason-lspconfig").setup({
        automatic_enable = false,
        ensure_installed = {
            "lua_ls",
            "pyright",
            "bashls",
            "jsonls",
            "yamlls",
            "marksman",
            "rust_analyzer",
            "clangd",
            "cmake",
            "dockerls",
            "gradle_ls",
            "kotlin_language_server",
            "sqlls",
        },
    })
    require("mason-nvim-dap").setup()
    require("mason-conform").setup({
        ensure_installed = {
            -- Formatters
            "beautysh",
            "black",
            "gofumpt",
            "rustfmt",
            "stylua",
            "xmlformat",
            "yamlfmt",
            "sqlfluff",
        },
    })
    require("mason-tool-installer").setup({
        ensure_installed = {
            "golangci-lint",
            "stylua",
            "shellcheck",
            "shfmt",
            "gopls",
            "goimports",
            "gofumpt",
            "gomodifytags",
            "impl",
            "delve",
            "clang-format",
            "ltex-ls",
        },
        run_on_start = true,
    })
end

return M
