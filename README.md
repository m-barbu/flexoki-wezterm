# Flexoki for WezTerm

An inky color scheme for prose and code, with tab bar colors.

Based on [Flexoki](https://stephango.com/flexoki) by Steph Ango.

_Disclaimer_: I have made this repo with Claude Opus 5. The end result looks
good to me.

## Usage

To install the theme using the built-in WezTerm plugin support, add these lines
to your `wezterm.lua` (available variants are `light` and `dark`):

```lua
local wezterm = require('wezterm')
local theme = wezterm.plugin.require('https://github.com/mateibarbu19/flexoki-wezterm-theme').dark
```

If you prefer to install the theme manually, copy `plugin/init.lua` to
`~/.config/wezterm/lua/` (Linux, macOS, and FreeBSD) or the directory containing
`wezterm.exe` (Windows), and rename it to `flexoki.lua`. Load the module and
variant you want to use:

```lua
local theme = require('lua/flexoki').dark
```

Then, specify the color definitions in your configuration to style the terminal
and tab bar:

```lua
return {
    colors = theme.colors(),
    window_frame = theme.window_frame(), -- needed only if using fancy tab bar
}
```

Make sure `color_scheme` is not specified, because the color scheme overrides
all custom colors defined in the lua configuration.

## Recommended settings

Some WezTerm settings are not colors but still change how a palette reads. Each
variant exposes the ones it wants through `recommended_config()`, which returns
a table of top-level config keys to merge in:

```lua
local config = wezterm.config_builder()

config.colors = theme.colors()
config.window_frame = theme.window_frame()

for key, value in pairs(theme.recommended_config()) do
    config[key] = value
end
```

If you switch between themes, guard the call, since not every theme exposes it:

```lua
if theme.recommended_config then
    for key, value in pairs(theme.recommended_config()) do
        config[key] = value
    end
end
```

Currently the only recommendation is `bold_brightens_ansi_colors`:

| variant | value             | why                                                                                                                                                                                                                                                             |
| ------- | ----------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `light` | `"No"`            | Brights are the 400 series, which is _lighter_ than the 600 series used for normal colors. WezTerm's default promotes bold ANSI 0-7 into that row, so bold text washes out against paper. Bold still renders as a heavier font weight.                          |
| `dark`  | `"BrightAndBold"` | Brights are the 300 series, which sits above the 400 series used for normal colors, so promoting bold text genuinely brightens it. This is WezTerm's default, stated explicitly so switching variants at runtime resets the value instead of inheriting `"No"`. |

This matters most with prompts that style text bold by default. Starship's
default preset marks nearly every module bold, which on the light variant put
the directory at 2.78:1 and the clock at 2.31:1 against the background; with
`"No"` they land at 4.43:1 and 3.39:1.

## Switching on the system appearance

```lua
local wezterm = require('wezterm')
local flexoki = wezterm.plugin.require('https://github.com/mateibarbu19/flexoki-wezterm')

local function theme_for_appearance()
    local appearance = wezterm.gui and wezterm.gui.get_appearance() or 'Dark'
    return appearance:find('Dark') and flexoki.dark or flexoki.light
end

local theme = theme_for_appearance()

local config = wezterm.config_builder()
config.colors = theme.colors()
config.window_frame = theme.window_frame()

for key, value in pairs(theme.recommended_config()) do
    config[key] = value
end

return config
```

## Why not the built-in schemes?

WezTerm ships built-in `flexoki-light` and `flexoki-dark` color schemes imported
from the upstream Flexoki repository. This plugin differs in two ways:

- It includes **tab bar and window frame colors**, which the built-in schemes do
  not define at all.
- It uses **different accent steps in the dark variant** (see below).

## Swapping blue and cyan

`swap_blue_cyan()` exchanges what the blue and cyan slots render as. It is
opt-in, because unlike everything else here it makes the palette lie: a program
that asks for cyan gets blue.

```lua
config.colors = flexoki.swap_blue_cyan(theme.colors())
```

The reason for such a swap was that I found the syntax highlighting for nushell
with starship commands was too green.

## Deviations from the upstream presets

Upstream reference
[here](https://github.com/kepano/flexoki/tree/8d723bac4a9ac46adfdf99d42155286977aac72a/wezterm).

These are deliberate, and each one is commented in `plugin/init.lua`:

- **Dark variant uses the 400 series for normal colors and 300 for brights.**
  The upstream WezTerm preset uses the 600 series for normal colors, which sits
  at roughly 2.8:1 against the `#100F0F` background for green. The 400 series
  follows Flexoki's own stated guidance ("for dark themes use 400") and keeps
  every accent at 4.4:1 or better.
- **Slot 5 is magenta in both variants.** The upstream dark preset puts purple
  there. Slot 5 is canonically magenta, so orange and purple go to indexed 16
  and 17 instead, following the base16 convention.
- **Dark slot 0 is `base850`, not `#100F0F`.** Upstream uses the background
  color itself, which renders ANSI black invisible.
- **Light bright black is `base500`, not `base300`.** `base300` sits near 1.9:1
  against paper, which is too faint for comments.

Note that indexed colors 16 and 17 overwrite two cells of the 256-color cube
(normally `#000000` and `#00005f`). Programs that compute cube indices
arithmetically will render those two cells off-palette. This is the standard
base16 tradeoff.

## Credits

- [Flexoki](https://stephango.com/flexoki) by
  [Steph Ango](https://stephango.com)
- Plugin layout follows [neapsix/wezterm](https://github.com/neapsix/wezterm)
