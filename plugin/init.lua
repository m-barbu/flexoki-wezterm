-- Flexoki for WezTerm
--
-- Copyright (c) 2026 Matei Barbu
-- Palette from Flexoki by Steph Ango (https://stephango.com/flexoki),
-- Copyright (c) Steph Ango, MIT licensed.
--
-- repository: https://github.com/mateibarbu19/flexoki-wezterm-theme
-- license: MIT

-- The full Flexoki scale, shared by both variants. Accent steps follow the
-- upstream guidance.
local palette = {
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

  red_300     = '#E8705F',
  orange_300  = '#EC8B49',
  yellow_300  = '#DFB431',
  green_300   = '#A0AF54',
  cyan_300    = '#5ABDAC',
  blue_300    = '#66A0C8',
  purple_300  = '#A699D0',
  magenta_300 = '#E47DA8',

  red_400     = '#D14D41',
  orange_400  = '#DA702C',
  yellow_400  = '#D0A215',
  green_400   = '#879A39',
  cyan_400    = '#3AA99F',
  blue_400    = '#4385BE',
  purple_400  = '#8B7EC8',
  magenta_400 = '#CE5D97',

  red_600     = '#AF3029',
  orange_600  = '#BC5215',
  yellow_600  = '#AD8301',
  green_600   = '#66800B',
  cyan_600    = '#24837B',
  blue_600    = '#205EA6',
  purple_600  = '#5E409D',
  magenta_600 = '#A02F6F',
}

local light = {}

local light_active_tab = {
  bg_color = palette.base100,
  fg_color = palette.black,
}

local light_inactive_tab = {
  bg_color = palette.paper,
  fg_color = palette.base500,
}

function light.colors()
  return {
    foreground = palette.black,
    background = palette.paper,

    -- Softer than the black body text so the cursor reads as a marker rather
    -- than the heaviest thing on screen. Matches the upstream Flexoki preset.
    cursor_bg = palette.base600,
    cursor_border = palette.base600,
    cursor_fg = palette.paper,

    selection_fg = palette.black,
    selection_bg = palette.base200,

    compose_cursor = palette.yellow_600,
    split = palette.base300,
    scrollbar_thumb = palette.base300,
    visual_bell = palette.base150,

    ansi = {
      palette.black,        -- Black
      palette.red_600,      -- Red
      palette.green_600,    -- Green
      palette.yellow_600,   -- Yellow
      palette.blue_600,     -- Blue
      palette.magenta_600,  -- Magenta
      palette.cyan_600,     -- Cyan
      palette.base150,      -- White
    },

    brights = {
      -- Bright black is the comment color. Upstream Flexoki uses base300 here,
      -- which sits near 1.9:1 against paper; base500 keeps comments legible
      -- while still reading as de-emphasized.
      palette.base500,      -- Bright Black
      palette.red_400,      -- Bright Red
      palette.green_400,    -- Bright Green
      palette.yellow_400,   -- Bright Yellow
      palette.blue_400,     -- Bright Blue
      palette.magenta_400,  -- Bright Magenta
      palette.cyan_400,     -- Bright Cyan
      palette.base100,      -- Bright White
    },

    -- base16 convention: orange and purple have no ANSI slot, so they live at
    -- 16 and 17. This overwrites two cells of the 256-color cube (normally
    -- #000000 and #00005f); programs that compute cube indices arithmetically
    -- will render those two cells off-palette.
    indexed = {
      [16] = palette.orange_600,
      [17] = palette.purple_600,
    },

    copy_mode_active_highlight_bg = { Color = palette.yellow_600 },
    copy_mode_active_highlight_fg = { Color = palette.paper },
    copy_mode_inactive_highlight_bg = { Color = palette.base150 },
    copy_mode_inactive_highlight_fg = { Color = palette.black },

    quick_select_label_bg = { Color = palette.magenta_600 },
    quick_select_label_fg = { Color = palette.paper },
    quick_select_match_bg = { Color = palette.base150 },
    quick_select_match_fg = { Color = palette.black },

    tab_bar = {
      background = palette.paper,
      active_tab = light_active_tab,
      inactive_tab = light_inactive_tab,
      inactive_tab_hover = light_active_tab,
      new_tab = light_inactive_tab,
      new_tab_hover = light_active_tab,
      inactive_tab_edge = palette.base100, -- (Fancy tab bar only)
    },
  }
end

function light.window_frame() -- (Fancy tab bar only)
  return {
    active_titlebar_bg = palette.paper,
    inactive_titlebar_bg = palette.base50,
  }
end

-- Non-color config this variant wants. Merge into your config table; see the
-- readme. Kept separate from colors() because these are top-level config keys,
-- not entries in the color palette.
function light.recommended_config()
  return {
    -- Bold must not promote ANSI 0-7 into the bright row here: the brights are
    -- the Flexoki 400 series, which is *lighter* than the 600 series used for
    -- the normal colors, so bold text would wash out against paper. Bold still
    -- renders as a heavier font weight.
    bold_brightens_ansi_colors = 'No',
  }
end

local dark = {}

local dark_active_tab = {
  bg_color = palette.base850,
  fg_color = palette.base300,
}

local dark_inactive_tab = {
  bg_color = palette.black,
  fg_color = palette.base600,
}

function dark.colors()
  return {
    foreground = palette.base200,
    background = palette.black,

    -- Two steps below the base200 foreground, for the same reason as the light
    -- variant's cursor.
    cursor_bg = palette.base400,
    cursor_border = palette.base400,
    cursor_fg = palette.black,

    selection_fg = palette.base200,
    selection_bg = palette.base800,

    compose_cursor = palette.yellow_400,
    split = palette.base700,
    scrollbar_thumb = palette.base700,
    visual_bell = palette.base850,

    ansi = {
      -- Upstream puts #100F0F here, which is the background color and so is
      -- invisible. base850 keeps slot 0 distinguishable from the background.
      palette.base850,      -- Black
      palette.red_400,      -- Red
      palette.green_400,    -- Green
      palette.yellow_400,   -- Yellow
      palette.blue_400,     -- Blue
      palette.magenta_400,  -- Magenta
      palette.cyan_400,     -- Cyan
      palette.base300,      -- White
    },

    brights = {
      palette.base600,      -- Bright Black
      palette.red_300,      -- Bright Red
      palette.green_300,    -- Bright Green
      palette.yellow_300,   -- Bright Yellow
      palette.blue_300,     -- Bright Blue
      palette.magenta_300,  -- Bright Magenta
      palette.cyan_300,     -- Bright Cyan
      palette.paper,        -- Bright White
    },

    -- See the note on the light variant's indexed table.
    indexed = {
      [16] = palette.orange_400,
      [17] = palette.purple_400,
    },

    copy_mode_active_highlight_bg = { Color = palette.yellow_400 },
    copy_mode_active_highlight_fg = { Color = palette.black },
    copy_mode_inactive_highlight_bg = { Color = palette.base800 },
    copy_mode_inactive_highlight_fg = { Color = palette.base200 },

    quick_select_label_bg = { Color = palette.magenta_400 },
    quick_select_label_fg = { Color = palette.black },
    quick_select_match_bg = { Color = palette.base800 },
    quick_select_match_fg = { Color = palette.base200 },

    tab_bar = {
      background = palette.black,
      active_tab = dark_active_tab,
      inactive_tab = dark_inactive_tab,
      inactive_tab_hover = dark_active_tab,
      new_tab = dark_inactive_tab,
      new_tab_hover = dark_active_tab,
      inactive_tab_edge = palette.base800, -- (Fancy tab bar only)
    },
  }
end

function dark.window_frame() -- (Fancy tab bar only)
  return {
    active_titlebar_bg = palette.black,
    inactive_titlebar_bg = palette.base950,
  }
end

-- See the note on light.recommended_config().
function dark.recommended_config()
  return {
    -- The opposite of the light variant: here the brights are the 300 series,
    -- which sits above the 400 series used for the normal colors, so promoting
    -- bold text genuinely brightens it. This is WezTerm's default, stated
    -- explicitly so that switching variants at runtime resets the value rather
    -- than inheriting 'No' from the light variant.
    bold_brightens_ansi_colors = 'BrightAndBold',
  }
end

-- Opt-in hack: swap what the blue and cyan slots render as.
--
-- Nushell paints command names with the cyan slot (shape_internalcall for
-- builtins, shape_external for everything else), so swapping renders commands
-- blue without touching any shell config. Nothing distinguishes those tokens
-- once they reach the terminal -- they are the same SGR code as everything
-- else asking for cyan -- so this necessarily recolors those too, notably
-- starship's directory module and filepath arguments.
--
-- It also means a program that asks for cyan gets blue, which is a lie the
-- rest of the theme does not tell. Hence opt-in rather than baked into
-- colors():
--
--   config.colors = flexoki.swap_blue_cyan(theme.colors())
local function swap_blue_cyan(colors)
  -- WezTerm's ansi/brights arrays are 1-indexed in palette order:
  -- 1 black, 2 red, 3 green, 4 yellow, 5 blue, 6 magenta, 7 cyan, 8 white.
  colors.ansi[5], colors.ansi[7] = colors.ansi[7], colors.ansi[5]
  colors.brights[5], colors.brights[7] = colors.brights[7], colors.brights[5]
  return colors
end

return {
  light = light,
  dark = dark,
  swap_blue_cyan = swap_blue_cyan,
}
