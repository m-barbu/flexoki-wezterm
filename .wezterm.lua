-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

-- Spawn a nu shell in login mode
config.default_prog = { 'nu', '-l' }
-- config.default_prog = { 'C:\\WINDOWS\\system32\\wsl.exe', '-d', 'NixOS', '--cd', '~' }

local rose_pine_theme = require('lua/rose-pine').dawn
local flexoki_theme = require('lua/flexoki').light
-- local rose_pine_theme = flexoki_theme
config.colors = rose_pine_theme.colors()
config.window_frame = rose_pine_theme.window_frame()

-- Set fonts and size
-- Bigger font
config.font = wezterm.font('FiraCode Nerd Font')
config.font_size = 13.0
config.freetype_load_target = "Light"

-- Show tab bar for multiple tabs
config.hide_tab_bar_if_only_one_tab = true

reading_theme = "Flexoki Light"
no_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
default_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}

-- Enable the scrollbar.
config.enable_scroll_bar = true
config.window_padding = default_padding

helix_was_last = false
scrollbar_was_enabled = true

-- wezterm.on('user-var-changed', function(window, pane, name, value)
--   wezterm.log_info(string.format("var \"%s\" \"%s\"", tostring(name), tostring(value)))
-- end)

-- Disable scrollbar in alt screen aplications 
wezterm.on("update-status", function(window, pane)
  local helix_mode = false
  local change_scrollbar = false
  local back_to_base = false

  if pane:is_alt_screen_active() then
    change_scrollbar = scrollbar_was_enabled

    -- local proc = pane:get_foreground_process_name() or ""
    -- local is_ssh = proc:find("ssh") ~= nil
    --                or proc:find("wsl") ~= nil

    -- Worse is better
    local title = pane:get_title() or ""
    local is_helix = title:find("hx:") ~= nil
                      or title:find("GitHub Copilot") ~= nil
                  -- or title:lower():find("helix") ~= nil

    if is_helix then
      if not helix_was_last then
        helix_mode = true
      end
    else
      if helix_was_last then
        back_to_base = true
      end
    end

    helix_was_last = is_helix
  else
    change_scrollbar = not scrollbar_was_enabled
    back_to_base = helix_was_last
    helix_was_last = false
  end

  if change_scrollbar or helix_mode or back_to_base then
    local overrides = window:get_config_overrides() or {}

    if change_scrollbar then
      overrides.enable_scroll_bar = not scrollbar_was_enabled
      scrollbar_was_enabled = not scrollbar_was_enabled
    end

    if helix_mode then
      -- overrides.colors = {
      --   foreground = "#100F0F",
      --   background = "#FFFCF0",

      --   cursor_bg = "#100F0F",
      --   cursor_border = "#100F0F",
      --   cursor_fg = "#FFFCF0",

      --   selection_fg = "#100F0F",
      --   selection_bg = "#CECDC3",

      --   compose_cursor = "#AD8301",
      --   split = "#B7B5AC",

      --   ansi = {
      --     "#100F0F", -- Black
      --     "#AF3029", -- Red
      --     "#66800B", -- Green
      --     "#AD8301", -- Yellow
      --     "#205EA6", -- Blue
      --     "#A02F6F", -- Magenta
      --     "#24837B", -- Cyan
      --     "#6F6E69", -- White (base-600, readable on light bg)
      --   },

      --   brights = {
      --     "#878580", -- Bright Black (base-500, visible comments)
      --     "#D14D41", -- Bright Red
      --     "#879A39", -- Bright Green
      --     "#D0A215", -- Bright Yellow
      --     "#4385BE", -- Bright Blue
      --     "#CE5D97", -- Bright Magenta
      --     "#3AA99F", -- Bright Cyan
      --     "#100F0F", -- Bright White (full contrast)
      --   },

      --   indexed = {
      --     [16] = "#BC5215", -- orange-600
      --     [17] = "#AF3029", -- red-600
      --   },

      --   tab_bar = {
      --     background = "#F2F0E5",
      --     inactive_tab_edge = "#E6E4D9",

      --     active_tab = {
      --       bg_color = "#FFFCF0",
      --       fg_color = "#100F0F",
      --       intensity = "Bold",
      --     },

      --     inactive_tab = {
      --       bg_color = "#E6E4D9",
      --       fg_color = "#6F6E69",
      --     },

      --     inactive_tab_hover = {
      --       bg_color = "#CECDC3",
      --       fg_color = "#100F0F",
      --       italic = true,
      --     },

      --     new_tab = {
      --       bg_color = "#F2F0E5",
      --       fg_color = "#878580",
      --     },

      --     new_tab_hover = {
      --       bg_color = "#CECDC3",
      --       fg_color = "#100F0F",
      --       italic = true,
      --     },
      --   },
      -- }

      -- overrides.colors.background = '#FFFCF0'
      -- overrides.colors.tab_bar.active_tab = {
      --   fg_color = '#878580',
      --   bg_color = '#F2F0E5',
      -- }
      -- overrides.colors.tab_bar.inactive_tab_hover = overrides.colors.tab_bar.active_tab
      -- overrides.colors.tab_bar.new_tab_hover = overrides.colors.tab_bar.active_tab

      -- overrides.colors.tab_bar.inactive_tab = {
      --   fg_color = '#878580',
      --   bg_color = '#FFFCF0',
      -- }
      -- overrides.window_frame = {
      --   active_titlebar_bg = '#FFFCF0',
      --   inactive_titlebar_bg = '#FFFCF0',
      -- }
      -- overrides.colors.tab_bar.new_tab = overrides.colors.tab_bar.inactive_tab
      overrides.colors = flexoki_theme.colors()
      overrides.window_frame = flexoki_theme.window_frame()
    end

    if back_to_base then
      overrides.colors = rose_pine_theme.colors()
      overrides.window_frame = rose_pine_theme.window_frame()
    end

    window:set_config_overrides(overrides)
  end
end)

-- Change the assignment for toggling full screen mode
config.keys = {
  {
    key = 'F11',
    mods = '',
    action = wezterm.action.ToggleFullScreen,
  },
}

config.keys = {
  {
    key = 'Enter',
    mods = 'SHIFT',
    action = wezterm.action.SendString('\x1b[13;2u'),
  },
}

-- Rarely useful
-- config.mouse_bindings = {
--   {
--     event = { Drag = { streak = 1, button = 'Left' } },
--     mods = 'CTRL',
--     action = wezterm.action.StartWindowDrag,
--   }
-- }

config.audible_bell = 'Disabled'

-- and finally, return the configuration to wezterm
return config
