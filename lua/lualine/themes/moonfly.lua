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

return {
  normal = {
    a = { bg = colors.color1, fg = colors.color6 },
    b = { bg = colors.color_bg1, fg = colors.color1 },
    c = { bg = colors.color_bg2, fg = colors.color9 },
  },
  insert = {
    a = { bg = colors.color2, fg = colors.color6 },
    b = { bg = colors.color_bg1, fg = colors.color2 },
  },
  visual = {
    a = { bg = colors.color3, fg = colors.color6 },
    b = { bg = colors.color_bg1, fg = colors.color3 },
  },
  command = {
    a = { bg = colors.color4, fg = colors.color6 },
    b = { bg = colors.color_bg1, fg = colors.color4 },
  },
  replace = {
    a = { bg = colors.color5, fg = colors.color6 },
    b = { bg = colors.color_bg1, fg = colors.color5 },
  },
  terminal = {
    a = { bg = colors.color2, fg = colors.color6 },
    b = { bg = colors.color_bg1, fg = colors.color2 },
  },
  inactive = {
    a = { bg = colors.color_bg1, fg = colors.color7 },
    b = { bg = colors.color_bg1, fg = colors.color7 },
    c = { bg = colors.color_bg2, fg = colors.color7 },
  },
}
