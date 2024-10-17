return {
  "epwalsh/obsidian.nvim",
  version = "*",
  -- ft = "markdown",
  lazy = false,
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    ui = {
      enable = false,
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    -- stylua: ignore
    mappings = {
      -- "Obsidian follow"
      ["gf"] = { action = function() return require("obsidian").util.gf_passthrough() end, opts = { desc = "", noremap = false, expr = true, buffer = true }, },
      ["<leader>nf"] = { action = function() return require("obsidian").util.gf_passthrough() end, opts = { noremap = false, expr = true, buffer = true }, },
      -- Toggle check-boxes "obsidian done"
      ["<leader>nd"] = { action = function() return require("obsidian").util.toggle_checkbox() end, opts = { buffer = true }, },
      -- Create a new newsletter issue
      -- ["<leader>nn"] = { action = function() return require("obsidian").commands.new_note("Newsletter-Issue") end, opts = { buffer = true }, },
      -- ["<leader>nt"] = { action = function() return require("obsidian").util.insert_template("Newsletter-Issue") end, opts = { buffer = true }, }, 
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "Notes/dailies",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },
    workspaces = {
      {
        name = "Zettelkasten",
        path = "~/Dropbox/Zettelkasten",
        overrides = {
          notes_subdir = "notes",
        },
      },
      {
        name = "old notes",
        path = "~/Dropbox/NOTES",
      },
    },
  },

  new_notes_location = "current_dir",
  wiki_link_func = function(opts)
    if opts.id == nil then
      return string.format("[[%s]]", opts.label)
    elseif opts.label ~= opts.id then
      return string.format("[[%s|%s]]", opts.id, opts.label)
    else
      return string.format("[[%s]]", opts.id)
    end
  end,

  note_frontmatter_func = function(note)
    -- This is equivalent to the default frontmatter function.
    local out = { id = note.id, aliases = note.aliases, tags = note.tags, area = "", project = "" }

    -- `note.metadata` contains any manually added fields in the frontmatter.
    -- So here we just make sure those fields are kept in the frontmatter.
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end
    return out
  end,

  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    -- In this case a note with the title 'My new note' will be given an ID that looks
    -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    local suffix = ""
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.time()) .. "-" .. suffix
  end,

  templates = {
    subdir = "Templates",
    date_format = "%Y-%m-%d-%a",
    time_format = "%H:%M",
    tags = "",
  },
}
