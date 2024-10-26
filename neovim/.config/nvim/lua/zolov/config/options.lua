local options = {
    spelllang = "ru,en",
    foldmethod = "marker",
    backup = false, -- creates a backup file
    -- use xclip in X and wl-copy/wl-paste in wayland
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    -- completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 1,
    fileencoding = "utf-8", -- the encoding written to a file
    ignorecase = true, -- ignore case in search patterns
    -- guicursor = "i-r:block-Cursor",
    mouse = "a", -- allow the mouse to be used in neovim
    pumheight = 15, -- pop up menu height
    winblend = 0,
    pumblend = 0, -- transparency of pop-up menu
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = true, -- creates a swapfile
    timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
    termguicolors = true,
    undofile = true, -- enable persistent undo
    updatetime = 500, -- faster completion (4000ms default)
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = false, -- convert tabs to spaces
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    tabstop = 4, -- insert 2 spaces for a tab
    softtabstop = 4,

    showtabline = 0,
    cursorline = true, -- highlight the current line
    cmdheight = 0,
    laststatus = 3, -- global status line
    number = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    numberwidth = 2, -- set number column width to 4 {default 4}
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    wrap = false, -- display lines as one long line
    scrolloff = 8, -- minimal number of columns to scroll horizontally.
    sidescrolloff = 8, -- minimal number of screen columns
    -- lazyredraw = true, -- Won't be redrawn while executing macros, register and other commands.
    -- shell = vim.fn.executable "pwsh" and "pwsh" or "powershell",
    -- shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    -- shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    -- shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    -- shellquote = "",
    -- shellxquote = "",
    background = "dark",
    backspace = "indent,eol,start",
}

local global = {
    did_load_filetypes = false,
    mkdp_auto_close = 0, -- Don't Exit Preview When Switching Buffers
    highlighturl_enabled = true, -- highlight URLs by default
    -- disable netrw at the very start of your init.lua (strongly advised)
    loaded = true,
    loaded_netrwPlugin = true,
    zipPlugin = true, -- disable zip
    load_black = true, -- disable black
    loaded_2html_plugin = true, -- disable 2html
    loaded_getscript = true, -- disable getscript
    loaded_getscriptPlugin = true, -- disable getscript
    loaded_gzip = true, -- disable gzip
    loaded_logipat = true, -- disable logipat
    loaded_matchit = true, -- disable matchit
    loaded_remote_plugins = true, -- disable remote plugins
    loaded_tar = true, -- disable tar
}

vim.opt.shortmess:append("A") -- Disable asking when editing file with swapfile.
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

-- Set the char for the indent line
vim.g.indentline_char = "·"

for k, v in pairs(options) do
    vim.opt[k] = v
end

for k, v in pairs(global) do
    vim.g[k] = v
end

-- refresh buffers when files change on disk
vim.cmd([[
  set autoread
  au CursorHold * checktime
]])

if vim.fn.exists("g:neovide") == 1 then
    vim.opt.guifont = "JetBrainsMono Nerd Font:h16"

    -- NEOVIDE CONFIGURATIONS
    vim.g.neovide_fullscreen = false
    vim.g.neovide_floating_blur_amount_x = 4.0
    vim.g.floaterm_winblend = 15
    vim.g.neovide_floating_blur_amount_y = 4.0
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_transparency = 0.7
    vim.g.neovide_window_blurred = true
    vim.g.neovide_padding_top = 10
    vim.g.neovide_padding_bottom = 10
    vim.g.neovide_padding_right = 10
    vim.g.neovide_padding_left = 10
    vim.g.neovide_cursor_animation_length = 0.13
    vim.g.neovide_cursor_trail_length = 0.8
    vim.g.neovide_cursor_vfx_mode = "railgun" -- Railgun particles behind cursor
    vim.g.neovide_cursor_vfx_opacity = 200.0
    vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
    vim.g.neovide_cursor_vfx_particle_density = 7.0
    vim.g.neovide_cursor_vfx_particle_speed = 10.0
    vim.g.neovide_cursor_vfx_particle_phase = 1.5
    vim.g.neovide_cursor_vfx_particle_curl = 1.0
    vim.g.neovide_cursor_unfocused_outline_width = 0.125

    local function toggleTransparency()
        if vim.g.neovide_transparency == 1.0 then
            vim.cmd("let g:neovide_transparency=0.7")
            vim.g.neovide_window_blurred = true
        else
            vim.cmd("let g:neovide_transparency=1.0")
            vim.g.neovide_window_blurred = false
        end
    end

    local function toggleFullscreen()
        if vim.g.neovide_fullscreen == false then
            vim.cmd("let g:neovide_fullscreen=v:true")
        else
            vim.cmd("let g:neovide_fullscreen=v:false")
        end
    end

    vim.keymap.set("n", "<F11>", toggleFullscreen, { silent = true })
    vim.keymap.set("n", "<F10>", toggleTransparency, { silent = true })
end

vim.diagnostic.config({
    float = { border = "rounded" }, -- add border to diagnostic popups
})
