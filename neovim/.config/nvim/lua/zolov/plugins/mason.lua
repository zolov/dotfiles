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

            -- Formatters
            "beautysh",
            "black",
            "clang_format",
            "gofumpt",
            "rustfmt",
            "stylua",
            "xmlformat",
        },
    })
    require("mason-nvim-dap").setup()
    require("mason-tool-installer").setup({
        ensure_installed = {
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
        },

        -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
        vim.api.nvim_command("MasonToolsInstall"),
    })
end

return M
