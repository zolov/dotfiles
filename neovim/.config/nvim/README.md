# Neovim Config

Personal Neovim configuration built around `lazy.nvim`, native LSP configuration,
Treesitter, Telescope/FZF, DAP, formatting/linting, Git integrations, and focused
language support for Lua, Go, Rust, Python, YAML/JSON, Terraform/OpenTofu, and
Markdown.

## Requirements

- Neovim 0.10+; currently verified with Neovim 0.12.4.
- `git` for plugin bootstrap and updates.
- `make` for native plugin/snippet build steps.
- Optional CLI tools managed through Mason: `lua-language-server`, `stylua`,
  `gopls`, `goimports`, `gofumpt`, `shellcheck`, `shfmt`, `golangci-lint`,
  `delve`, and related language servers/formatters.

## Layout

- `init.lua` is intentionally small and only wires modules together.
- `lua/core/lazy.lua` bootstraps and configures `lazy.nvim`.
- `lua/config/` contains editor options, keymaps, autocommands, helpers, icons,
  compatibility shims, and a compact health command.
- `lua/plugins/` contains one lazy.nvim spec per plugin or plugin area.
- `lua/plugins/lsp/` configures native LSP setup with per-server overrides in
  `lua/plugins/lsp/servers/`.
- `after/ftplugin/` contains filetype-specific overrides.

## Useful Commands

- `:Lazy` opens plugin management.
- `:Mason` opens external tool management.
- `:ConfigHealth` shows a compact status report for key local requirements.
- `:checkhealth` runs Neovim's full health checks.

## Maintenance Notes

- Plugin versions are pinned in `lazy-lock.json`.
- Lua development uses `lazydev.nvim`; `neodev.nvim` was removed because it is
  archived and EOL for modern Neovim versions.
- LSP servers are enabled through `vim.lsp.config()` and `vim.lsp.enable()`, so
  new servers should be added to `lua/plugins/lsp/init.lua` plus an optional
  file in `lua/plugins/lsp/servers/`.
- Formatting settings for this repository live in `.stylua.toml`.
