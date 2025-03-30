local wezterm = require 'wezterm';
local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.audible_bell = "Disabled"
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.use_fancy_tab_bar = false
-- config.pane_focus_follows_mouse = true
-- config.show_close_tab_button_in_tabs = false -- Nightly
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
-- config.tab_bar_at_bottom = true
config.default_prog = { '/run/current-system/sw/bin/fish', '-l' }
config.colors = {
  tab_bar = {
  },
}

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
config.max_fps = 120

-- https://github.com/wez/wezterm/issues/4051#issuecomment-1822588387
config.send_composed_key_when_left_alt_is_pressed = true

local act = wezterm.action

config.keys = {
    -- This will create a new split and run your default program inside it
    {
        key = 'D',
        mods = 'CMD|SHIFT',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'd',
        mods = 'CMD',
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'w',
        mods = 'CMD',
        action = act.CloseCurrentPane { confirm = true },
    },
    {
        key = 'p',
        mods = 'CMD|SHIFT',
        action = act.ActivateCommandPalette,
    },
    { key = '+', mods = 'CMD', action = act.IncreaseFontSize },
    { key = '-', mods = 'CMD', action = act.DecreaseFontSize },
    {
        key = 'LeftArrow',
        mods = 'CMD|ALT',
        action = act.ActivateTabRelative(-1) ,
    },
    {
        key = 'RightArrow',
        mods = 'CMD|ALT',
        action = act.ActivateTabRelative(1) ,
    },
    { key = 'q', mods = 'CTRL', action = act.PaneSelect },
    {
        key = 'w',
        mods = 'CTRL',
        action = act.PaneSelect {
            mode = 'SwapWithActive',
        },
    },
}

return config
