local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local colors = require("lua/rose-pine").colors()

--config.color_scheme = "Catppuccin Mocha"

config.colors = colors

config.use_fancy_tab_bar = false

config.font_size = 20.0

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.80
config.enable_tab_bar = false

config.macos_window_background_blur = 60

return config
