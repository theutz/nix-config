local wezterm = require("wezterm")

-- Setup config builder
local c = {}
if wezterm.config_builder then
  c = wezterm.config_builder()
end
c:set_strict_mode(true)

c.macos_window_background_blur = 50
c.window_background_opacity = 1.0
c.font = wezterm.font("0xProto Nerd Font Propo", { weight = 400 })
c.font_size = 14
c.line_height = 1.2
c.bold_brightens_ansi_colors = "BrightAndBold"
c.window_close_confirmation = "NeverPrompt"
c.quit_when_all_windows_are_closed = true
c.window_decorations = "RESIZE"
c.adjust_window_size_when_changing_font_size = false
c.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"

c.window_padding = {
  top = "16px",
  bottom = "4px",
  left = "12px",
  right = "12px",
}

c.hide_tab_bar_if_only_one_tab = true
c.tab_bar_at_bottom = true
c.use_fancy_tab_bar = false
c.tab_max_width = 80
c.show_tab_index_in_tab_bar = true
c.command_palette_font_size = 18

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Tokyo Night Moon"
  else
    return "Tokyo Night Day"
  end
end

c.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

wezterm.on("window-config-reloaded", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  overrides.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
  window:set_config_overrides(overrides)
end)

c.keys = {
  {
    key = "Escape",
    mods = "NONE",
    action = wezterm.action({ SendString = "\x1b" }),
  },
}

return c
