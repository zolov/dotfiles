return {
  -- https://github.com/f-person/git-blame.nvim
  'f-person/git-blame.nvim',
  event = 'VeryLazy',
  opts = {
    enabled = true, -- disable by default, enabled only on keymap
    date_format = '%m/%d/%y %H:%M:%S', -- more concise date format
  }
}

