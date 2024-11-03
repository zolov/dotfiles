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
                    "github:nvim-java/mason-registry",
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
        ensure_installed = {
            "lua_ls",
            "pyright",
            "bashls",
            "jsonls",
            "yamlls",
            "marksman",
            "rust_analyzer",
            "jdtls",
            "clangd",
            "cmake",
            "dockerls",
            "gradle_ls",
            "jsonls",
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
            "rustfmt",
            "xmlformat",
        },
    })
    require("mason-tool-installer").setup({
        ensure_installed = {
            "sonarlint-language-server",
            "golangci-lint",
            "java-debug-adapter",
            "java-test",
            "google-java-format",
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
            "ltex-ls"
        },

        -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
        vim.api.nvim_command("MasonToolsInstall"),
    })
end

return M
