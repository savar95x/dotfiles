local custom_gruvbox = require('lualine.themes.gruvbox-material')

-- Function to make a section transparent
local function transparent_bg(section)
  if section then
    section.bg = '#151515' -- Forces it to use the terminal background
  end
end

-- Apply transparency to the "Middle" and "Inactive" parts
-- We keep 'a' (the mode indicator) colored so it pops
for _, mode in pairs(custom_gruvbox) do
  transparent_bg(mode.b)
  transparent_bg(mode.c)
  transparent_bg(mode.x)
  transparent_bg(mode.y)
  transparent_bg(mode.z)
end

require('lualine').setup {
  options = {
    theme = custom_gruvbox,
    section_separators = '',   -- No arrows (Industrial look)
    component_separators = '', -- Pipes (Industrial look)
    globalstatus = false,      -- Set to true if you want one bar for all splits
  },
}
