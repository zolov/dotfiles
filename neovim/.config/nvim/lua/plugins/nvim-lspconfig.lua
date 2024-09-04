-- LSP Support
return {
  -- LSP Configuration
  -- https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- LSP Management
    -- https://github.com/williamboman/mason.nvim
    { 'williamboman/mason.nvim' },
    -- https://github.com/williamboman/mason-lspconfig.nvim
    { 'williamboman/mason-lspconfig.nvim' },

    -- Auto-Install LSPs, linters, formatters, debuggers
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

    -- Useful status updates for LSP
    -- https://github.com/j-hui/fidget.nvim
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    -- https://github.com/folke/neodev.nvim
    {'folke/neodev.nvim' },
  -- Java LSP
  { "mfussenegger/nvim-jdtls", ft = "java" },

  -- DAP (Required to run Java unit tests and Debugging)--
  { "mfussenegger/nvim-dap",   ft = "java" },
  { "rcarriga/nvim-dap-ui",    ft = "java", dependencies= {"nvim-neotest/nvim-nio"}, opts = {} },
  { "Pocco81/dap-buddy.nvim",  ft = "java" },
    {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = { 'jdtls', "tsserver" },
        handlers = {
          lsp_zero.default_setup,
          jdtls = lsp_zero.noop, -- This means don't setup jdtls with default setup, because there is special config for it.
        }
      })
    end
  },
  {
    'nvimdev/lspsaga.nvim',
    event = "LspAttach",
    opts = {
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        folder_level = 6,
      }
    }
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },

  --LSP Diagnostics
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = "TroubleToggle",
    opts = {auto_preview = false } -- automatically preview the location of the diagnostic
  },
  },
  config = function ()
    require('mason').setup()
    require('mason-lspconfig').setup({
      -- Install these LSPs automatically
      ensure_installed = {
        'bashls',
        'cssls',
        'html',
        'gradle_ls',
        'groovyls',
        'lua_ls',
        'jdtls',
        'jsonls',
        'lemminx',
        'marksman',
        'quick_lint_js',
        'yamlls',
      }
    })

    require('mason-tool-installer').setup({
      -- Install these linters, formatters, debuggers automatically
      ensure_installed = {
          'bash-language-server',
          'google-java-format',
          'stylua',
          'shellcheck',
          'shfmt',
          'java-test',
          'java-debug-adapter'
      },
    })

    -- There is an issue with mason-tools-installer running with VeryLazy, since it triggers on VimEnter which has already occurred prior to this plugin loading so we need to call install explicitly
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
    vim.api.nvim_command('MasonToolsInstall')

    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp_attach = function(client, bufnr)
      -- Create your keybindings here...
    end

    -- Call setup on each LSP server
    require('mason-lspconfig').setup_handlers({
      function(server_name)
        -- Don't call setup for JDTLS Java LSP because it will be setup from a separate config
        if server_name ~= 'jdtls' then
          lspconfig[server_name].setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
          })
        end
      end
    })

    -- Lua LSP settings
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
        },
      },
    }

    require "config.jdtls"

    -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded" -- Set border to rounded
      return open_floating_preview(contents, syntax, opts, ...)
    end

  end
}
