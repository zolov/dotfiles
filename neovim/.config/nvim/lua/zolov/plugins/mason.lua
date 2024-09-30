local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = {
				ui = {
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
	require("mason").setup({
		ui = {
			border = "rounded",
		},
	})
	require("mason-lspconfig").setup({
		ensure_installed = {
			"lua_ls",
			"cssls",
			"html",
			"ts_ls",
			"astro",
			"pyright",
			"bashls",
			"jsonls",
			"yamlls",
			"marksman",
			"tailwindcss",
			"rust_analyzer",
			"eslint",
			"jdtls",
			-- "lombok-nightly",
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
		},

		-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
		vim.api.nvim_command("MasonToolsInstall"),
	})
end

return M
