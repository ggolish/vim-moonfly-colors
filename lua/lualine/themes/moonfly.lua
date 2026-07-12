-- moonfly color scheme for lualine
--
-- URL:      github.com/bluz71/vim-moonfly-colors
-- License:  MIT (https://opensource.org/licenses/MIT)

local palette = require("moonfly").palette

local colors = {
  -- StatusLine background colors.
  color_bg1 = palette.grey18,
  color_bg2 = palette.grey7,

  -- Mode colors.
  color1 = palette.blue,
  color2 = palette.emerald,
  color3 = palette.purple,
  color4 = palette.yellow,
  color5 = palette.crimson,

  -- Mode text color.
  color6 = palette.grey11,

  -- StatusLineNC foreground.
  color7 = palette.grey62,

  -- Text colors.
  color8 = palette.white,
  color9 = palette.grey70,
}

local function contrast_fg(bg_hex)
  if not bg_hex or type(bg_hex) ~= "string" or #bg_hex < 7 then
    return palette.grey11
  end
  local r = tonumber(bg_hex:sub(2, 3), 16) or 0
  local g = tonumber(bg_hex:sub(4, 5), 16) or 0
  local b = tonumber(bg_hex:sub(6, 7), 16) or 0
  local luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255
  if luminance < 0.45 then
    return palette.white
  else
    return palette.grey11
  end
end

return {
  normal = {
    a = { bg = colors.color1, fg = contrast_fg(colors.color1) },
    b = { bg = colors.color_bg1, fg = colors.color1 },
    c = { bg = colors.color_bg2, fg = colors.color9 },
  },
  insert = {
    a = { bg = colors.color2, fg = contrast_fg(colors.color2) },
    b = { bg = colors.color_bg1, fg = colors.color2 },
  },
  visual = {
    a = { bg = colors.color3, fg = contrast_fg(colors.color3) },
    b = { bg = colors.color_bg1, fg = colors.color3 },
  },
  command = {
    a = { bg = colors.color4, fg = contrast_fg(colors.color4) },
    b = { bg = colors.color_bg1, fg = colors.color4 },
  },
  replace = {
    a = { bg = colors.color5, fg = contrast_fg(colors.color5) },
    b = { bg = colors.color_bg1, fg = colors.color5 },
  },
  terminal = {
    a = { bg = colors.color2, fg = contrast_fg(colors.color2) },
    b = { bg = colors.color_bg1, fg = colors.color2 },
  },
  inactive = {
    a = { bg = colors.color_bg1, fg = colors.color7 },
    b = { bg = colors.color_bg1, fg = colors.color7 },
    c = { bg = colors.color_bg2, fg = colors.color7 },
  },
}
