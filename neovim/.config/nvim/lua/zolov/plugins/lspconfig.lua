local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      "b0o/schemastore.nvim",
    },
  },
}

for name, icon in pairs(require("zolov.config.utils").lsp_icons) do
  name = "DiagnosticSign" .. name
  vim.fn.sign_define(name, { text = icon, texthl = name })
end

-- stylua: ignore
local function lsp_keymaps(bufnr)
  local keymap = vim.api.nvim_buf_set_keymap
  -- keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Goto Declaration", noremap = true, silent = true })
  keymap(bufnr, "n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Goto Declaration", noremap = true, silent = true })
  -- keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Goto Definition", noremap = true, silent = true })
  keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Goto Definition", noremap = true, silent = true })
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover", noremap = true, silent = true })
  -- keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Goto Implementation", noremap = true, silent = true })
  -- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "References", noremap = true, silent = true })
  keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations<CR>",{ desc = "Goto Implementation", noremap = true, silent = true })
  keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "References", noremap = true, silent = true })
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Open float", noremap = true, silent = true })
  keymap(bufnr, "n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Goto T[y]pe Definition", noremap = true, silent = true })
  keymap(bufnr, "n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature Help", noremap = true, silent = true })
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  -- require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true)
  end
end

M.toggle_inlay_hints = function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
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
    { "]d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Prev Diagnostic" },
    { "[d", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
    { "<leader>lh", "<cmd>lua require('zolov.plugins.lspconfig').toggle_inlay_hints()<CR>", desc = "Hints" },
    { "<leader>q", "<cmd>Trouble quickfix<cr>", desc = "Quickfix" },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setqflist()<cr>", desc = "Quickfix" },
    { "<leader>cr", "<cmd>lua vim.lsp.codelens.run()<CR>", desc = "CodeLens Action" },
    { "<leader>a", mode = { "n", "v" }, "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "Format" },
    { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
  })

  local lspconfig = require("lspconfig")
  local servers = {
    "lua_ls",
    "pyright",
    "bashls",
    "jsonls",
    "yamlls",
    "marksman",
    "rust_analyzer",
    "jdtls",
    "gopls",
  }

  local default_diagnostic_config = {
    signs = {
      active = true,
    },
    virtual_text = false,
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

  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = require("zolov.config.utils").border })
  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = require("zolov.config.utils").border })
  require("lspconfig.ui.windows").default_options.border = "rounded"

  for _, server in pairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = M.common_capabilities(),
    }

    local require_ok, settings = pcall(require, "zolov.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    if server == "lua_ls" then
      require("neodev").setup({})
    end

    if server ~= "jdtls" then
      lspconfig[server].setup(opts)
    end
  end
end

return M
