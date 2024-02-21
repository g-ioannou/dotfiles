local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local colors = require("lua/rose-pine").colors()

config.colors = colors
config.audible_bell = "Disabled"

config.use_fancy_tab_bar = false
config.enable_tab_bar = false

config.font_size = 20.0

config.window_padding = {
	top = 0,
	bottom = 0,
	left = 4,
	right = 4,
}

config.window_background_opacity = 0.80

config.macos_window_background_blur = 60

config.keys = {
	{ key = "UpArrow", mods = "SHIFT", action = act.ScrollByLine(-1) },
	{ key = "DownArrow", mods = "SHIFT", action = act.ScrollByLine(1) },
	{ key = "PageUp", action = act.ScrollByPage(-0.5) },
	{ key = "PageDown", action = act.ScrollByPage(0.5) },
}

return config
