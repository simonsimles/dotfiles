local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = "Andromeda"

config.window_background_opacity = 0.95
config.window_decorations = "RESIZE"

config.default_prog = {'pwsh'}

--config.font = wezterm.font('Cascadia Code NF', {style='Normal', weight='Regular'})
config.font = wezterm.font('RobotoMono Nerd Font', {style='Normal', weight='Regular'})
--config.font = wezterm.font('JetBrainsMono Nerd Font', {style='Normal', weight='Regular'})
config.font_size = 10.0

config.keys = {
    {key="S", mods="ALT|SHIFT", action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},
    {key="D", mods="ALT|SHIFT", action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},
}

config.use_fancy_tab_bar = true

return config
