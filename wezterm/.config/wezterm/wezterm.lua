local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font_with_fallback({
{ family = "JetBrainsMonoNL Nerd Font", scale = 1.3 },
{ family = "Hacker Nerd Font", scale = 1.3 },
})
-- config.font_size = 17
config.macos_window_background_blur = 30

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

-- config.window_background_opacity = 0.9
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000

config.default_prog = { "/opt/homebrew/bin/tmux" }

config.enable_tab_bar = false
config.mouse_bindings = {
	  -- Ctrl-click will open the link under the mouse cursor
	  {
	    event = { Up = { streak = 1, button = 'Left' } },
	    mods = 'CTRL',
	    action = wezterm.action.OpenLinkAtMouseCursor,
	  },
	}

config.keys = {
		{
			key = 'f',
			mods = 'CTRL',
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = '\'',
			mods = 'CTRL',
			action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
		},
	}

return config
