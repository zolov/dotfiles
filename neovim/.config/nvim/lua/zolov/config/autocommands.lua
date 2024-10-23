local fn = vim.fn

local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
  return vim.api.nvim_create_augroup("skaiivim_" .. name, { clear = true })
end

-- General Settings
local general = augroup("general")

-- Disable Bufferline And Lualine in Alpha
autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    vim.opt.cmdheight = vim.opt.cmdheight:get()
    vim.opt.laststatus = 0
    autocmd("BufUnload", {
      pattern = "<buffer>",
      callback = function()
        vim.opt.cmdheight = vim.opt.cmdheight:get()
        vim.opt.laststatus = 3
      end,
    })
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "DiagnosticChanged" }, {
  group = augroup("diagnostics"),
  callback = function()
    vim.diagnostic.setloclist({ open = false })
  end,
})

-- Toggle relative line numbers on focus change
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = augroup("init"),
  pattern = "*",
  callback = function()
    if vim.o.nu and vim.fn.mode() ~= "i" then
      vim.o.rnu = true
    end
  end,
})

-- Go To The Last Cursor Postion
autocmd("BufReadPost", {
  callback = function()
    if fn.line("'\"") > 1 and fn.line("'\"") <= fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
  group = general,
})

-- Highlight when yanking
autocmd("TextYankPost", {
  callback = function()
    require("vim.highlight").on_yank({ higroup = "Visual", timeout = 200 })
  end,
  group = general,
})

-- Disable New Line Comment
autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = general,
})

-- Update file
autocmd("FocusGained", {
  callback = function()
    vim.cmd("checktime")
  end,
  group = general,
})

-- Equalize Splits
autocmd("VimResized", {
  callback = function()
    vim.cmd("wincmd =")
  end,
  group = general,
})

-- Highlighting match words when searching
autocmd("ModeChanged", {
  callback = function()
    if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
      vim.opt.hlsearch = true
    else
      vim.opt.hlsearch = false
    end
  end,
  group = general,
})

-- Enable Wrap in these filetypes
autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown", "text", "plaintex", "log" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Close NvimTree
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if
      layout[1] == "leaf"
      and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
      and layout[3] == nil
    then
      vim.cmd("confirm quit")
    end
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- this function will update session on pre-leave
vim.api.nvim_create_autocmd("VimLeavePre", {
  pattern = "*",
  callback = function()
    if vim.g.savesession then
      if vim.g.sessionfile ~= "" then
        vim.api.nvim_command(string.format("mks! %s", vim.g.sessionfile))
      end
    end
  end,
})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    vim.cmd([[
      set laststatus=1 | autocmd BufUnload <buffer> set laststatus=3
    ]])
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "qf",
    "help",
    "man",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "notify",
    "nofile",
    "lspinfo",
    "terminal",
    "prompt",
    "toggleterm",
    "copilot",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
    "fugitive",
    "dap-repl",
    "neotest-summary",
    "neotest-output-panel",
    "dbout",
    "gitsigns-blame",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer",
    })
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.go",
--   callback = function()
--     require("go.format").goimports()
--   end,
--   group = format_sync_grp,
-- })

autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd([[Trouble qflist open]])
  end,
})

