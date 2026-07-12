# Moonfly Fork: Dynamic Terminal Colors

This branch (`dynamic`) extends the **moonfly** Neovim colorscheme with dynamic terminal color loading. It queries the host terminal emulator at runtime for its actual RGB colors so that Neovim's UI matches the active terminal color theme while maintaining moonfly's styling and contrast hierarchy.

## Features Added

1. **Dynamic Terminal Color Loading via OSC Queries**:
   - Queries `OSC 10` (Foreground), `OSC 11` (Background), and `OSC 4;0..15` (ANSI Palette 0–15) using `vim.api.nvim_ui_send(...)`.
   - Listens for terminal responses via Neovim's `TermResponse` autocommand event.
   - Dynamically interpolates UI grey tones (`grey1`, `grey7`..`grey70`) between the terminal's actual background and foreground colors.
   - Blends intermediate accent colors (`cranberry`, `coral`, `cinnamon`, `orchid`, `orange`, `lavender`, `mineral`, `bay`, `slate`, `haze`) based on the terminal's palette.

2. **Configuration Option**:
   - `g:moonflyDynamicColors` (Lua: `vim.g.moonflyDynamicColors`): Controls whether dynamic terminal color loading is enabled. Defaults to `true` on this fork. Set to `false` to use standard static moonfly colors.

3. **User Command**:
   - `:MoonflySyncTerminal`: Re-queries the terminal emulator and updates all highlight groups on demand.

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
