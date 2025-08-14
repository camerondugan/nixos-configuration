local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Basics
config.enable_wayland = false -- Fixes copy/paste for me
config.front_end = "WebGpu"

-- Visuals
config.font_size = 14.0
config.font = wezterm.font 'JetBrains Mono'
config.hide_tab_bar_if_only_one_tab = true

-- Bell
config.audible_bell = "Disabled"
-- config.colors = {
--   visual_bell = '#f38ba8',
-- }
-- config.colors = {
--   tab_bar = {
--     inactive_tab_edge = '#1e1e2e',
--     active_tab = {
--       fg_color = '#cdd6f4',
--       bg_color = '#11111b',
--     },
--     inactive_tab = {
--       fg_color = '#cdd6f4',
--       bg_color = '#181825',
--     },
--     inactive_tab_hover = {
--       fg_color = '#cdd6f4',
--       bg_color = '#11111b',
--     },
--     new_tab = {
--       fg_color = '#cdd6f4',
--       bg_color = '#181825',
--     },
--     new_tab_hover = {
--       fg_color = '#cdd6f4',
--       bg_color = '#11111b',
--     },
--   },
-- }
-- config.window_frame = {
--   active_titlebar_bg = '#181825',
--   inactive_titlebar_bg = '#181825',
-- }
config.window_padding = {
  left = '0',
  right = '0',
  top = '0',
  bottom = '0',
}
-- config.default_prog = { "tmux", "a" }
config.window_background_opacity = 0.8

-- Keybinds
config.keys = {
  {
    key = 'H', mods = 'CTRL',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = 'L', mods = 'CTRL',
    action = wezterm.action.ActivateTabRelative(1),
  },
  -- {
  --   key = 'V', mods = 'CTRL',
  --   action = wezterm.action.PasteFrom('Clipboard')
  -- },
  -- {
  --   key = 'v', mods = 'CTRL',
  --   action = wezterm.action.PasteFrom('PrimarySelection')
  -- },
  {
    key = 'N', mods = 'CTRL',
    action = wezterm.action.SpawnTab('CurrentPaneDomain')
  },
  {
    key = 'D', mods = 'CTRL',
    action = wezterm.action.CloseCurrentTab({confirm=false}),
  },
  {
    key = 'w', mods = 'CTRL',
    action = wezterm.action.CloseCurrentTab({confirm=true}),
  },
}
-- config.enable_kitty_keyboard = true;

config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = 'https://www.github.com/$1/$3',
})

return config
