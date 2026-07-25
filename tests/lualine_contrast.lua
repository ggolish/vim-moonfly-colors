local moonfly = require("moonfly")

local function relative_luminance(hex)
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
  return (math.max(luminance1, luminance2) + 0.05) / (math.min(luminance1, luminance2) + 0.05)
end

local cases = {
  light = {
    black = "#e7dff5",
    white = "#334155",
    grey7 = "#ded8e8",
    grey11 = "#d5d0df",
    grey18 = "#c3c3d5",
    grey62 = "#5d687c",
    grey70 = "#515d72",
    blue = "#1b44dc",
    emerald = "#116a54",
    purple = "#9327b8",
    yellow = "#7b4c1f",
    crimson = "#b61d35",
  },
  dark = {
    black = "#080808",
    white = "#c6c6c6",
    grey7 = "#121212",
    grey11 = "#1c1c1c",
    grey18 = "#2e2e2e",
    grey62 = "#9e9e9e",
    grey70 = "#b2b2b2",
    blue = "#80a0ff",
    emerald = "#36c692",
    purple = "#ae81ff",
    yellow = "#e3c78a",
    crimson = "#ff5189",
  },
}

for case_name, colors in pairs(cases) do
  moonfly.custom_colors(colors)
  package.loaded["lualine.themes.moonfly"] = nil
  local theme = require("lualine.themes.moonfly")

  for _, mode in ipairs({ "normal", "insert", "visual", "command", "replace", "terminal" }) do
    local section = theme[mode].a
    local contrast = contrast_ratio(section.fg, section.bg)
    assert(contrast >= 4.5, string.format("%s %s mode contrast was %.2f", case_name, mode, contrast))
  end
end
