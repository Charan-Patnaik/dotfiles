local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Launch directly into your Ubuntu WSL distro
config.default_prog = { "wsl.exe", "~" }

-- =========================
-- Font (Powerlevel10k + Nerd Font)
-- =========================
config.font = wezterm.font("GoMono Nerd Font")
config.font_size = 18.0
config.line_height = 1.05

-- =========================
-- Appearance
-- =========================
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 1
config.win32_system_backdrop = "Acrylic" -- or "Acrylic"
config.color_scheme = "Catppuccin Mocha"
-- -- =========================
-- -- Rendering / Performance                                                                            
-- -- =========================
-- config.front_end = "WebGpu"
-- config.animation_fps = 60
-- config.max_fps = 60

-- =========================
-- Terminal behavior (nvim/tmux-friendly)
-- =========================
config.term = "xterm-256color"
config.audible_bell = "Disabled"
config.scrollback_lines = 10000
config.adjust_window_size_when_changing_font_size = false

-- =========================
-- Copy / Paste behavior
-- =========================
config.selection_word_boundary = " \t\n{}[]()\"'`,;:"

-- =========================
-- Leader key (nice with tmux users)
-- =========================
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- =========================
-- Keymaps
-- =========================
config.keys = {
  -- Reload config
  { key = "r", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration },

  -- Copy/Paste (Windows muscle memory)
  { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

  -- Font size
  { key = "+", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
  { key = "_", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
  { key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },

  -- Quick pane splits (optional if tmux handles panes)
  { key = "\\", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

  -- Pane movement (great before entering tmux)
  { key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },

  -- Leader-based split (tmux-like)
  { key = "|", mods = "LEADER|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

  -- Leader-based pane nav (tmux-like)
  { key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
}

return config