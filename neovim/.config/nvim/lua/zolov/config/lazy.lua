local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local lazy = require("lazy")
lazy.setup({
    spec = {
        import = "zolov.plugins",
    },
    defaults = {
        lazy = false,
    },
    performance = {
        cache = {
            enabled = true, -- Включение кэширования (должно обеспечивать более быстрый запуск nvim)
        },
        reset_packpath = true, -- Сбросить путь к пакету, чтобы ускорить запуск

        rtp = {
            reset = true, -- Сбросить путь выполнения к $VIMRUNTIME и каталогу конфигурации
            paths = {}, -- Добавьте сюда любые пользовательские пути, которые вы хотите включить в rtp
            -- Список плагинов для отключения
            disabled_plugins = {
                -- "2html_plugin",
                -- "tohtml",
                -- "getscript",
                -- "getscriptPlugin",
                -- "gzip",
                -- "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                -- "matchit",
                -- "tar",
                -- "tarPlugin",
                -- "rrhelper",
                -- "spellfile_plugin",
                -- "vimball",
                -- "vimballPlugin",
                -- "zip",
                -- "zipPlugin",
                -- "tutor",
                -- "rplugin",
                -- "syntax",
                -- "synmenu",
                -- "optwin",
                -- "compiler",
                -- "bugreport",
                -- "ftplugin",
            },
        },
    },

    -- Настройка внешней составляющей окна Lazy.nvim
    ui = {
        border = "rounded", -- Стиль/Тип обводки
        title = "Plugin Manager", -- Название окна
        title_pos = "center", -- Расположение названия ("center" | "left" | "right") ("центр" | "лево" | "право")
        -- Размер окна
        size = {
            width = 0.8, -- Ширина
            height = 0.8, -- Высота
        },
    },

    -- Определение иконок для различных типов данных
    icons = {
        cmd = " ",
        config = "",
        event = "",
        ft = " ",
        init = " ",
        import = " ",
        keys = " ",
        lazy = "󰂠 ",
        loaded = "●",
        not_loaded = "○",
        plugin = " ",
        runtime = " ",
        source = " ",
        start = "",
        task = "✔ ",
        list = {
            "●",
            "➜",
            "★",
            "‒",
        },
    },

    checker = {
        enabled = true,
        notify = true,
    },

    change_detection = {
        enabled = false,
        notify = false,
    },

    install = {
        colorscheme = { "catppuccin" },
        missing = true,
    },
})
