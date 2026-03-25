local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local config = wezterm.config_builder()
local home = os.getenv("HOME") or ""

local FONT_FAMILY = "Maple Mono NF CN"
local FONT_SIZE = 12.0
local WINDOW_PADDING = 12
local STATUS_PADDING = 2
local LEADER_TIMEOUT = 600
local RESIZE_STEP = 5
local RESIZE_TIMEOUT = 1200
local USE_NATIVE_WAYLAND = true
local ENABLE_CUSTOM_STATUS = false
local DEBUG_KEY_EVENTS = false
local SCHEME_PATH = string.format("%s/.config/wezterm/colors/Noctalia.toml", home)
local TMUX_THEME_PATH = string.format("%s/.config/tmux/noctalia.conf", home)

-- Runtime and input
-- Toggle this when comparing native Wayland against Xwayland/XIM behavior.
config.enable_wayland = USE_NATIVE_WAYLAND
config.automatically_reload_config = true
config.front_end = USE_NATIVE_WAYLAND and "WebGpu" or "OpenGL"
config.use_ime = true
config.debug_key_events = DEBUG_KEY_EVENTS

if not USE_NATIVE_WAYLAND then
	config.xim_im_name = "fcitx"
end

-- Typography and window chrome
config.font = wezterm.font(FONT_FAMILY)
config.font_size = FONT_SIZE
config.line_height = 1.0

config.window_decorations = "NONE"
config.window_padding = {
	left = WINDOW_PADDING,
	right = WINDOW_PADDING,
	top = WINDOW_PADDING,
	bottom = WINDOW_PADDING,
}

-- Tab/status area
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.show_tabs_in_tab_bar = not ENABLE_CUSTOM_STATUS
config.show_new_tab_button_in_tab_bar = false
config.status_update_interval = ENABLE_CUSTOM_STATUS and 2000 or 10000

config.leader = {
	key = "q",
	mods = "CTRL",
	timeout_milliseconds = LEADER_TIMEOUT,
}

local ok, noctalia_scheme = pcall(function()
	local colors, _metadata = wezterm.color.load_scheme(SCHEME_PATH)
	return colors
end)

-- Theme loading
local function read_file(path)
	local file = io.open(path, "r")
	if not file then
		return nil
	end

	local content = file:read("*a")
	file:close()
	return content
end

local function match_color(text, pattern)
	local color = text and text:match(pattern) or nil
	return color
end

local function load_tmux_ui_colors()
	local conf = read_file(TMUX_THEME_PATH)
	if not conf then
		return nil
	end

	local primary = match_color(conf, 'status%-left ".-#%[fg=(#%x%x%x%x%x%x)%]')
	local error_color = match_color(conf, 'status%-left ".-#%[fg=#%x%x%x%x%x%x%].-#%[fg=(#%x%x%x%x%x%x)%]')
	local inactive = match_color(conf, 'window%-status%-format ".-#%[fg=(#%x%x%x%x%x%x)%]')
	local active = match_color(conf, 'window%-status%-current%-format ".-#%[fg=(#%x%x%x%x%x%x)%]')
	local secondary = match_color(conf, "status%-right '#%[fg=(#%x%x%x%x%x%x)%]")

	if not (primary and error_color and inactive and active and secondary) then
		return nil
	end

	return {
		active = active,
		inactive = inactive,
		muted = inactive,
		workspace_label = primary,
		workspace_name = error_color,
	}
end

if ok and noctalia_scheme then
	config.color_schemes = {
		Noctalia = noctalia_scheme,
	}
	config.color_scheme = "Noctalia"
end

local ui = load_tmux_ui_colors()
	or (ok and noctalia_scheme and {
		active = noctalia_scheme.ansi[3] or noctalia_scheme.foreground,
		inactive = noctalia_scheme.brights[1] or noctalia_scheme.scrollbar_thumb or noctalia_scheme.foreground,
		muted = noctalia_scheme.brights[1] or noctalia_scheme.scrollbar_thumb or noctalia_scheme.foreground,
		workspace_label = noctalia_scheme.ansi[7] or noctalia_scheme.foreground,
		workspace_name = noctalia_scheme.ansi[2] or noctalia_scheme.foreground,
	})
	or {
		active = "#31748f",
		inactive = "#656182",
		muted = "#656182",
		workspace_label = "#ebbcba",
		workspace_name = "#eb6f92",
	}

-- Status rendering helpers
local function compact_title(title)
	local value = (title or ""):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
	if value == "" then
		return "shell"
	end

	if wezterm.column_width(value) > 14 then
		return wezterm.truncate_right(value, 13) .. "…"
	end

	return value
end

local function basename(path)
	if not path or path == "" then
		return nil
	end

	return string.gsub(path, "(.*[/\\])(.*)", "%2")
end

local function tab_label(item)
	local pane = item.tab:active_pane()

	local pane_title = pane and pane:get_title() or nil
	if pane_title and pane_title ~= "" and pane_title ~= "wezterm" then
		return compact_title(pane_title)
	end

	local process_name = pane and basename(pane:get_foreground_process_name()) or nil
	if process_name and process_name ~= "" then
		return compact_title(process_name)
	end

	return compact_title(item.tab:get_title())
end

local function tab_plain_text(window)
	local parts = {}
	for _, item in ipairs(window:mux_window():tabs_with_info()) do
		local title = tab_label(item)
		local marker = item.is_active and "●" or "○"
		table.insert(parts, string.format("%d %s %s", item.index + 1, title, marker))
	end
	return table.concat(parts, "  ")
end

local function render_tab_cells(window)
	local cells = {}
	local items = window:mux_window():tabs_with_info()

	for index, item in ipairs(items) do
		local title = tab_label(item)
		local marker = item.is_active and "●" or "○"
		local fg = item.is_active and ui.active or ui.inactive

		table.insert(cells, { Foreground = { Color = fg } })
		if item.is_active then
			table.insert(cells, { Attribute = { Intensity = "Bold" } })
		else
			table.insert(cells, { Attribute = { Intensity = "Normal" } })
		end
		table.insert(cells, { Text = string.format("%d %s %s", item.index + 1, title, marker) })

		if index < #items then
			table.insert(cells, { Foreground = { Color = ui.muted } })
			table.insert(cells, { Attribute = { Intensity = "Normal" } })
			table.insert(cells, { Text = "  " })
		end
	end

	return cells
end

if ENABLE_CUSTOM_STATUS then
	wezterm.on("update-status", function(window, _pane)
		local workspace = window:active_workspace()

		local right_cells = {
			{ Text = string.rep(" ", STATUS_PADDING) },
			{ Foreground = { Color = ui.workspace_label } },
			{ Text = "󰰡 " },
			{ Foreground = { Color = ui.workspace_name } },
			{ Attribute = { Intensity = "Bold" } },
			{ Text = workspace },
			{ Text = string.rep(" ", STATUS_PADDING) },
		}

		local left_cells = {
			{ Text = string.rep(" ", STATUS_PADDING) },
		}
		for _, cell in ipairs(render_tab_cells(window)) do
			table.insert(left_cells, cell)
		end

		window:set_left_status(wezterm.format(left_cells))
		window:set_right_status(wezterm.format(right_cells))
	end)
end

-- Workspace helpers
local function workspace_names()
	local names = mux.get_workspace_names()
	table.sort(names)
	return names
end

local function workspace_has_windows(name)
	for _, mux_window in ipairs(mux.all_windows()) do
		if mux_window:get_workspace() == name then
			return true
		end
	end

	return false
end

local function ensure_workspace(name)
	if workspace_has_windows(name) then
		return
	end

	mux.spawn_window({
		workspace = name,
	})
end

local function delete_workspace_choices()
	local current = mux.get_active_workspace()
	local choices = {}

	for _, name in ipairs(workspace_names()) do
		local label = name
		if name == current then
			label = name .. "  (current)"
		end

		table.insert(choices, {
			id = name,
			label = label,
		})
	end

	return choices
end

local function pick_destination(current, target)
	if current ~= target then
		return current
	end

	for _, name in ipairs(workspace_names()) do
		if name ~= target then
			return name
		end
	end

	return nil
end

local function close_workspace(target)
	for _, mux_window in ipairs(mux.all_windows()) do
		if mux_window:get_workspace() == target then
			local gui_window = mux_window:gui_window()
			if gui_window then
				while true do
					local tabs = mux_window:tabs()
					if #tabs == 0 then
						break
					end

					local tab = tabs[1]
					tab:activate()
					gui_window:perform_action(act.CloseCurrentTab({ confirm = false }), tab:active_pane())
				end
			end
		end
	end
end

-- Key helpers
local function resize_binding(key, direction)
	return {
		key = key,
		mods = "LEADER|SHIFT",
		action = act.Multiple({
			act.AdjustPaneSize({ direction, RESIZE_STEP }),
			act.ActivateKeyTable({
				name = "resize_pane",
				one_shot = false,
				timeout_milliseconds = RESIZE_TIMEOUT,
				replace_current = true,
				until_unknown = true,
			}),
		}),
	}
end

-- Main keymap
config.keys = {
	{ key = "q", mods = "LEADER", action = act.SendKey({ key = "q", mods = "CTRL" }) },
	{ key = "r", mods = "LEADER", action = act.ReloadConfiguration },
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = act.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = act.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = act.ActivateTab(-1) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	resize_binding("H", "Left"),
	resize_binding("J", "Down"),
	resize_binding("K", "Up"),
	resize_binding("L", "Right"),
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "_", mods = "LEADER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "%", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = '"', mods = "LEADER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "w", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "<", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = ">", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },
	{ key = "o", mods = "LEADER", action = act.PaneSelect },
	{ key = "f", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
	{
		key = "S",
		mods = "LEADER|SHIFT",
		action = act.PromptInputLine({
			description = "Enter name for new workspace",
			action = wezterm.action_callback(function(window, pane, line)
				if line and line ~= "" then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
	{
		key = "d",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			window:perform_action(
				act.InputSelector({
					title = "Delete workspace",
					fuzzy = true,
					choices = delete_workspace_choices(),
					action = wezterm.action_callback(function(inner_window, inner_pane, id, _label)
						if not id then
							return
						end

						local names = workspace_names()
						if #names <= 1 then
							inner_window:toast_notification("wezterm", "Cannot delete the last workspace", nil, 3000)
							return
						end

						local current = inner_window:active_workspace()
						local destination = pick_destination(current, id)
						if not destination then
							inner_window:toast_notification(
								"wezterm",
								"Could not determine a fallback workspace",
								nil,
								3000
							)
							return
						end

						ensure_workspace(destination)
						mux.set_active_workspace(id)
						close_workspace(id)
						mux.set_active_workspace(destination)

						inner_window:toast_notification("wezterm", "Deleted workspace: " .. id, nil, 3000)
					end),
				}),
				pane
			)
		end),
	},
	{ key = "P", mods = "LEADER|SHIFT", action = act.ActivateCommandPalette },
}

-- Modal tables
config.key_tables = {
	resize_pane = {
		{ key = "H", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", RESIZE_STEP }) },
		{ key = "J", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", RESIZE_STEP }) },
		{ key = "K", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", RESIZE_STEP }) },
		{ key = "L", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", RESIZE_STEP }) },
		{ key = "Escape", action = act.PopKeyTable },
		{ key = "q", action = act.PopKeyTable },
	},
	copy_mode = {
		{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
		{ key = "Escape", mods = "NONE", action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
		{ key = "Space", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
		{ key = "/", mods = "NONE", action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
		{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
		{ key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
		{ key = "F", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
		{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
		{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
		{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
		{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
		{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		{ key = "T", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
		{ key = "T", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
		{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
		{ key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
		{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
		{ key = "c", mods = "CTRL", action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
		{ key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
		{ key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
		{ key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
		{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
		{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
		{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
		{ key = "g", mods = "CTRL", action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
		{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
		{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
		{ key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
		{ key = "q", mods = "NONE", action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
		{ key = "t", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
		{ key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
		{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
		{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{
			key = "y",
			mods = "NONE",
			action = act.Multiple({
				{ CopyTo = "ClipboardAndPrimarySelection" },
				{ Multiple = { "ScrollToBottom", { CopyMode = "Close" } } },
			}),
		},
		{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
		{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
		{ key = "End", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
		{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
		{ key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
		{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
	},
}

return config
