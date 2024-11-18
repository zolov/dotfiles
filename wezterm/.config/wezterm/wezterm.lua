local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.enable_kitty_graphics = true
config.animation_fps = 120
config.max_fps= 240

config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMonoNL Nerd Font", scale = 1.3 },
	{ family = "Hacker Nerd Font", scale = 1.3 },
})

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE|MACOS_FORCE_ENABLE_SHADOW"

local opaque_bg = 0.80
local blured_bg = 35
local default_opacity = 1.0
local default_blur = 0

config.window_background_opacity = default_opacity
config.macos_window_background_blur = default_blur

config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000

config.default_prog = {
	"/bin/zsh",
}

config.cursor_blink_ease_out = "Constant"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_rate = 400

config.enable_tab_bar = false
config.mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

wezterm.on("toggle-opacity", function(window, _)
	local overrides = window:get_config_overrides() or {}
local opacity = overrides.window_background_opacity
	if opacity < default_opacity then
		overrides.window_background_opacity = default_opacity
		overrides.macos_window_background_blur = default_blur
	else
        overrides.window_background_opacity = opaque_bg
        overrides.macos_window_background_blur = blured_bg
	end
	window:set_config_overrides(overrides)
end)

config.keys = {
	{
		key = "f",
		mods = "CTRL|OPT",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "'",
		mods = "CTRL",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
	{
		key = "p",
		mods = "CTRL|OPT",
		action = wezterm.action.ActivateCommandPalette,
	},
	{ -- open t - tmux smart session manager instead of <leader>(ctrl+a)+t
		key = "j",
		mods = "CMD",
		action = wezterm.action.SendString("\x01\x74"),
	},
	{
		key = "b",
		mods = "CTRL|OPT",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	},
}

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

config.color_scheme = scheme_for_appearance(get_appearance())

return config
