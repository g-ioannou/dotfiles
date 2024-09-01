local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local colors = require("lua/rose-pine").colors()

config.window_decorations = "RESIZE"

config.default_prog = { "/usr/bin/zsh" }

config.colors = colors
config.audible_bell = "Disabled"

colors.cursor_bg = "red"

config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane
	local title = basename(pane.foreground_process_name) .. " " .. pane.pane_id

	return {
		{ Text = " " .. title .. " " },
	}
end)

config.font_size = 20.0
config.font = wezterm.font_with_fallback({ "JetBrainsMono NFM", "FiraCode Nerd Font Mono" })

config.window_padding = {
	top = 0,
	bottom = 0,
	left = 0,
	right = 0,
}

config.window_background_opacity = 1

config.macos_window_background_blur = 60
config.scrollback_lines = 30000
config.adjust_window_size_when_changing_font_size = false

config.hyperlink_rules = {
	-- Linkify things that look like URLs and the host has a TLD name.
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.

	-- linkify email addresses
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
		format = "mailto:$0",
	},

	-- file:// URI
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = [[\bfile://\S*\b]],
		format = "$0",
	},

	-- Linkify things that look like URLs with numeric addresses as hosts.
	-- E.g. http://127.0.0.1:8000 for a local development server,
	-- or http://192.168.1.1 for the web interface of many routers.
	{
		regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
		format = "$0",
	},

	-- Make task numbers clickable
	-- The first matched regex group is captured in $1.
	-- {
	-- 	regex = [[\b[tT](\d+)\b]],
	-- 	format = "https://example.com/tasks/?t=$1",
	-- },

	-- Make username/project paths clickable. This implies paths like the following are for GitHub.
	-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
	-- As long as a full URL hyperlink regex exists above this it should not match a full URL to
	-- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
	{
		regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
		format = "https://www.github.com/$1/$3",
	},
}

--config.leader = { key = "\\", mods = "CTRL", timeoute_milliseconds = 1000 }

config.keys = {
	--	{ key = "UpArrow", mods = "CTRL|LEADER", action = act.ScrollByLine(-1) },
	--	{ key = "DownArrow", mods = "CTRL|LEADER", action = act.ScrollByLine(1) },
	--	{ key = "PageUp", action = act.ScrollByPage(-0.5) },
	--	{ key = "PageDown", action = act.ScrollByPage(0.5) },
	--	{ key = '"', mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	--	{ key = "%", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	--	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	--	{ key = "f", mods = "LEADER", action = act.ShowTabNavigator },
	--	{
	--		key = "h",
	--		mods = "CTRL",
	--		action = act.ActivatePaneDirection("Left"),
	--	},
	--	{
	--		key = "l",
	--		mods = "CTRL",
	--		action = act.ActivatePaneDirection("Right"),
	--	},
	--	{
	--		key = "k",
	--		mods = "CTRL",
	--		action = act.ActivatePaneDirection("Up"),
	--	},
	--	{
	--		key = "j",
	--		mods = "CTRL",
	--		action = act.ActivatePaneDirection("Down"),
	--	},
	--	{
	--
	--		key = "s",
	--		mods = "LEADER",
	--		action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	--	},
	--	{ key = "n", mods = "LEADER", action = act.ActivateTabRelativeNoWrap(1) },
	--	{ key = "p", mods = "LEADER", action = act.ActivateTabRelativeNoWrap(-1) },
	--	{ key = "l", mods = "LEADER", action = wezterm.action.ShowLauncher },
	--	{ key = "c", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
	--	{
	--		key = ",",
	--		mods = "LEADER",
	--		action = act.PromptInputLine({
	--			description = wezterm.format({
	--				{ Attribute = { Intensity = "Bold" } },
	--				{ Foreground = { AnsiColor = "Fuchsia" } },
	--				{ Text = "Rename tab:" },
	--			}),
	--			action = wezterm.action_callback(function(window, pane, line)
	--				if line then
	--					window:active_tab():set_title(line)
	--				end
	--			end),
	--		}),
	--	},
	--	{
	--		key = "N",
	--		mods = "LEADER",
	--		action = act.PromptInputLine({
	--			description = wezterm.format({
	--				{ Text = "\n\nCreating new workspace\n\n" },
	--				{ Attribute = { Intensity = "Bold" } },
	--				{ Foreground = { AnsiColor = "Fuchsia" } },
	--				{ Text = "Enter name" },
	--			}),
	--			action = wezterm.action_callback(function(window, pane, line)
	--				-- line will be `nil` if they hit escape without entering anything
	--				-- An empty string if they just hit enter
	--				-- Or the actual line of text they wrote
	--				if line then
	--					window:perform_action(
	--						act.SwitchToWorkspace({
	--							name = line,
	--						}),
	--						pane
	--					)
	--				end
	--			end),
	--		}),
	--	},
}

config.mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

wezterm.on("update-status", function(window, pane)
	-- Workspace name
	local stat = window:active_workspace()
	local stat_color = "#f7768e"
	-- It's a little silly to have workspace name all the time
	-- Utilize this to display LDR or current key table name
	if window:active_key_table() then
		stat = window:active_key_table()
		stat_color = "#7dcfff"
	end
	if window:leader_is_active() then
		stat = "LDR"
		stat_color = "#bb9af7"
	end

	local basename = function(s)
		-- Nothing a little regex can't fix
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	-- Current working directory
	local cwd = pane:get_current_working_dir()
	if cwd then
		if type(cwd) == "userdata" then
			-- Wezterm introduced the URL object in 20240127-113634-bbcac864
			cwd = basename(cwd.file_path)
		else
			-- 20230712-072601-f4abf8fd or earlier version
			cwd = basename(cwd)
		end
	else
		cwd = ""
	end

	-- Current command
	local cmd = pane:get_foreground_process_name()
	-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
	cmd = cmd and basename(cmd) or ""

	-- Time
	local time = wezterm.strftime("%H:%M")

	-- Left status (left of the tab line)
	window:set_left_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = "  " },
		{ Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
		{ Text = " |" },
	}))

	-- Right status
	window:set_right_status(wezterm.format({
		-- Wezterm has a built-in nerd fonts
		-- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = "  " },
	}))
end)
return config
