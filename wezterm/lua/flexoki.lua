-- Copyright (c) 2024 Flexoki for WezTerm
-- Based on Flexoki by Steph Ango (https://stephango.com/flexoki)
-- license: MIT

local light = {}

local light_palette = {
  black   = '#100F0F',
  base950 = '#1C1B1A',
  base900 = '#282726',
  base850 = '#343331',
  base800 = '#403E3C',
  base700 = '#575653',
  base600 = '#6F6E69',
  base500 = '#878580',
  base300 = '#B7B5AC',
  base200 = '#CECDC3',
  base150 = '#DAD8CE',
  base100 = '#E6E4D9',
  base50  = '#F2F0E5',
  paper   = '#FFFCF0',

  red     = '#AF3029',
  orange  = '#BC5215',
  yellow  = '#AD8301',
  green   = '#66800B',
  cyan    = '#24837B',
  blue    = '#205EA6',
  purple  = '#5E409D',
  magenta = '#A02F6F',

  -- Light (400) variants for brights
  red2     = '#D14D41',
  orange2  = '#DA702C',
  yellow2  = '#D0A215',
  green2   = '#879A39',
  cyan2    = '#3AA99F',
  blue2    = '#4385BE',
  purple2  = '#8B7EC8',
  magenta2 = '#CE5D97',
}

local light_active_tab = {
  bg_color = light_palette.base50,
  fg_color = light_palette.base500,
}

local light_inactive_tab = {
  bg_color = light_palette.paper,
  fg_color = light_palette.base500,
}

function light.colors()
  return {
    foreground = light_palette.black,
    background = light_palette.paper,

    cursor_bg = light_palette.black,
    cursor_border = light_palette.black,
    cursor_fg = light_palette.paper,

    selection_fg = light_palette.black,
    selection_bg = light_palette.base200,

    compose_cursor = light_palette.yellow,
    split = light_palette.base300,

    ansi = {
      light_palette.black,    -- Black
      light_palette.red,      -- Red
      light_palette.green,    -- Green
      light_palette.yellow,   -- Yellow
      light_palette.blue,     -- Blue
      light_palette.magenta,  -- Magenta
      light_palette.cyan,     -- Cyan
      light_palette.base600,  -- White (readable on light bg)
    },

    brights = {
      light_palette.base500,  -- Bright Black (visible comments)
      light_palette.red2,     -- Bright Red
      light_palette.green2,   -- Bright Green
      light_palette.yellow2,  -- Bright Yellow
      light_palette.blue2,    -- Bright Blue
      light_palette.magenta2, -- Bright Magenta
      light_palette.cyan2,    -- Bright Cyan
      light_palette.black,    -- Bright White (full contrast)
    },

    indexed = {
      [16] = light_palette.orange,
      [17] = light_palette.purple,
    },

    tab_bar = {
      background = light_palette.paper,
      active_tab = light_active_tab,
      inactive_tab = light_inactive_tab,
      inactive_tab_hover = light_active_tab,
      new_tab = light_inactive_tab,
      new_tab_hover = light_active_tab,
      inactive_tab_edge = light_palette.base100, -- (Fancy tab bar only)
    },
  }
end

function light.window_frame() -- (Fancy tab bar only)
  return {
    active_titlebar_bg = light_palette.paper,
    inactive_titlebar_bg = light_palette.paper,
  }
end

local dark = {}

local dark_palette = {
  black   = '#100F0F',
  base950 = '#1C1B1A',
  base900 = '#282726',
  base850 = '#343331',
  base800 = '#403E3C',
  base700 = '#575653',
  base600 = '#6F6E69',
  base500 = '#878580',
  base400 = '#9F9D96',
  base300 = '#B7B5AC',
  base200 = '#CECDC3',
  base150 = '#DAD8CE',
  base100 = '#E6E4D9',
  base50  = '#F2F0E5',
  paper   = '#FFFCF0',

  red     = '#AF3029',
  orange  = '#BC5215',
  yellow  = '#AD8301',
  green   = '#66800B',
  cyan    = '#24837B',
  blue    = '#205EA6',
  purple  = '#5E409D',
  magenta = '#A02F6F',

  -- Light (400) variants for dark-theme foreground
  red2     = '#D14D41',
  orange2  = '#DA702C',
  yellow2  = '#D0A215',
  green2   = '#879A39',
  cyan2    = '#3AA99F',
  blue2    = '#4385BE',
  purple2  = '#8B7EC8',
  magenta2 = '#CE5D97',
}

local dark_active_tab = {
  bg_color = dark_palette.base850,
  fg_color = dark_palette.base300,
}

local dark_inactive_tab = {
  bg_color = dark_palette.black,
  fg_color = dark_palette.base600,
}

function dark.colors()
  return {
    foreground = dark_palette.base200,
    background = dark_palette.black,

    cursor_bg = dark_palette.base200,
    cursor_border = dark_palette.base200,
    cursor_fg = dark_palette.black,

    selection_fg = dark_palette.base200,
    selection_bg = dark_palette.base800,

    compose_cursor = dark_palette.yellow2,
    split = dark_palette.base700,

    ansi = {
      dark_palette.base850,   -- Black
      dark_palette.red2,      -- Red
      dark_palette.green2,    -- Green
      dark_palette.yellow2,   -- Yellow
      dark_palette.blue2,     -- Blue
      dark_palette.magenta2,  -- Magenta
      dark_palette.cyan2,     -- Cyan
      dark_palette.base300,   -- White
    },

    brights = {
      dark_palette.base600,   -- Bright Black (comments)
      '#E8705F',              -- Bright Red (red-300)
      '#A0AF54',              -- Bright Green (green-300)
      '#DFB431',              -- Bright Yellow (yellow-300)
      '#66A0C8',              -- Bright Blue (blue-300)
      '#E47DA8',              -- Bright Magenta (magenta-300)
      '#5ABDAC',              -- Bright Cyan (cyan-300)
      dark_palette.paper,     -- Bright White
    },

    indexed = {
      [16] = dark_palette.orange2,
      [17] = dark_palette.purple2,
    },

    tab_bar = {
      background = dark_palette.black,
      active_tab = dark_active_tab,
      inactive_tab = dark_inactive_tab,
      inactive_tab_hover = dark_active_tab,
      new_tab = dark_inactive_tab,
      new_tab_hover = dark_active_tab,
      inactive_tab_edge = dark_palette.base800, -- (Fancy tab bar only)
    },
  }
end

function dark.window_frame() -- (Fancy tab bar only)
  return {
    active_titlebar_bg = dark_palette.black,
    inactive_titlebar_bg = dark_palette.black,
  }
end

return {
  light = light,
  dark = dark,
}