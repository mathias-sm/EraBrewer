-- color-span.lua
-- Highlights any #RRGGBB inside inline code,
-- even if followed by punctuation

local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return {
    r = tonumber(hex:sub(1,2), 16),
    g = tonumber(hex:sub(3,4), 16),
    b = tonumber(hex:sub(5,6), 16)
  }
end

local function luminance(rgb)
  local function channel(c)
    c = c / 255
    if c <= 0.03928 then
      return c / 12.92
    else
      return ((c + 0.055) / 1.055) ^ 2.4
    end
  end
  return 0.2126 * channel(rgb.r)
       + 0.7152 * channel(rgb.g)
       + 0.0722 * channel(rgb.b)
end

local function best_text_color(bg_hex)
  local rgb = hex_to_rgb(bg_hex)
  local lum = luminance(rgb)

  local contrast_black = (lum + 0.05) / 0.05
  local contrast_white = 1.05 / (lum + 0.05)

  if contrast_white > contrast_black then
    return "white"
  else
    return "black"
  end
end

function Code(el)
  local text = el.text
  local changed = false

  local result = text:gsub("#%x%x%x%x%x%x", function(hex)
    changed = true
    local text_color = best_text_color(hex)

    return string.format(
      '<span style="background-color:%s; color:%s; padding:0.2em 0.4em; border-radius:0.2em; font-family:monospace;">%s</span>',
      hex,
      text_color,
      hex
    )
  end)

  if changed then
    return pandoc.RawInline("html", result)
  end
end
