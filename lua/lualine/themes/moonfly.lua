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

local function relative_luminance(hex)
  if type(hex) ~= "string" or not hex:match("^#%x%x%x%x%x%x$") then
    return nil
  end

  local channels = {}
  for index = 2, 6, 2 do
    local channel = (tonumber(hex:sub(index, index + 1), 16) or 0) / 255
    channels[#channels + 1] = channel <= 0.04045 and channel / 12.92
      or ((channel + 0.055) / 1.055) ^ 2.4
  end

  return channels[1] * 0.2126 + channels[2] * 0.7152 + channels[3] * 0.0722
end

local function contrast_ratio(color1, color2)
  local luminance1 = relative_luminance(color1)
  local luminance2 = relative_luminance(color2)
  if not luminance1 or not luminance2 then
    return nil
  end
  return (math.max(luminance1, luminance2) + 0.05) / (math.min(luminance1, luminance2) + 0.05)
end

local function contrast_fg(bg_hex)
  local background_contrast = contrast_ratio(bg_hex, palette.black)
  local foreground_contrast = contrast_ratio(bg_hex, palette.white)
  if not background_contrast or not foreground_contrast then
    return palette.grey11
  end
  return background_contrast >= foreground_contrast and palette.black or palette.white
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
