# Moonfly Fork: Dynamic Terminal Colors

This branch (`dynamic`) extends the **moonfly** Neovim colorscheme with dynamic Konsole theme loading. It reads your active Konsole colorscheme (`Apex` by default) so that Neovim's UI matches the terminal color theme while maintaining moonfly's styling and contrast hierarchy. If the Konsole colorscheme file is not present on the system, it gracefully falls back to default moonfly colors.

## Features Added

1. **Direct Konsole Colorscheme Loading (`Apex`)**:
   - Locates and parses Konsole `.colorscheme` files (`~/.local/share/konsole/Apex.colorscheme`, `/usr/share/konsole/`, etc.).
   - Dynamically maps `[Background]`, `[Foreground]`, `[Color0..7]`, and `[Color0Intense..Color7Intense]` into the moonfly palette.
   - Dynamically interpolates UI grey tones (`grey1`, `grey7`..`grey70`) between the background and foreground colors.
   - Blends intermediate accent colors (`cranberry`, `coral`, `cinnamon`, `orchid`, `orange`, `lavender`, `mineral`, `bay`, `slate`, `haze`).
   - Automatically refreshes `lualine.themes.moonfly` if loaded.
   - Falls back to default static moonfly colors if the Konsole colorscheme file is not found.

2. **Configuration Options**:
   - `g:moonflyDynamicColors` (Lua: `vim.g.moonflyDynamicColors`): Controls whether dynamic theme loading is enabled. Defaults to `true` on this fork.
   - `g:moonflyKonsoleColorscheme` (Lua: `vim.g.moonflyKonsoleColorscheme`): Specifies the Konsole colorscheme name to load. Defaults to `"Apex"`.

3. **User Command**:
   - `:MoonflySyncTerminal`: Re-loads the Konsole colorscheme and updates all highlight groups and statuslines on demand.

---

## Guide for Rebasing onto Upstream Main

All code added or modified by this fork is demarcated with comments:

- In `lua/moonfly/init.lua`: Look for `-- [FORK: dynamic terminal color loading]` markers around:
  - Helper functions (`hex_to_rgb`, `rgb_to_hex_str`, `blend_colors`, `parse_rgb_channel`, `interpolate_greys`)
  - `M.sync_terminal_colors()` function
  - Autocommand and `:MoonflySyncTerminal` command registration
  - Call to `M.sync_terminal_colors()` at the end of `M.style()`
- In `colors/moonfly.vim`: Look for `" [FORK: dynamic terminal color loading]` around the `g:moonflyDynamicColors` option definition.

When running `git rebase main`:
1. Keep upstream changes to highlight groups inside `M.style()`.
2. Ensure that our dynamic loader block at the end of `lua/moonfly/init.lua` and the helper functions remain intact.
