local status, catp = pcall(require, "catppuccin")
if not status then
  print("catppuccin colorscheme not found!")
  return
end
local status, icons = pcall(require, "nvim-web-devicons")
if not status then
  print("nvim-web-devicons not installed")
  return
end

-- palette colors
local c = require("catppuccin.palettes").get_palette "macchiato"

-- custom colors
local BG = "#17191c"
local ALMOST_BG = "#1c1e20"
local WHITE = "#9da2af"
local GRAY = "#80838f"
local FADED_GRAY = "#33373a"
local STRONG_FADED_GRAY = "#2a2d30"

catp.setup({
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
    palette = {
      oldWhite = WHITE,      -- white text
      fujiWhite = WHITE,     -- white text
      fujiGray = FADED_GRAY, -- comments
      sumiInk3 = BG,         -- bg
    },
  },
  overrides = function(colors)
    local overrides = {
      --general
      Visual = { bg = ALMOST_BG },
      ModeMsg = { fg = c.Lavender },

      -- bufferline
      BufferLineFill = { bg = BG },
      BufferLineBackground = { bg = BG, fg = BG }, -- unactive tabs to faded gray
      BufferLineSeparator = { fg = BG },
      BufferLineModified = { fg = BG },
      BufferlineBufferSelected = { fg = GRAY }, -- active tabs to gray
      BufferlineBufferVisible = { fg = GRAY },  -- active tabs to gray
      BufferLineIndicatorVisible = { fg = BG },

      -- indentline
      IndentBlanklineChar = { fg = ALMOST_BG },

      -- GitSigns
      GitSignsAdd = { fg = c.Lavender },
      GitSignsAddNr = { fg = c.Lavender },
      GitSignsAddLn = { fg = c.Lavender },
      GitSignsChange = { fg = c.Lavender },
      GitSignsChangeNr = { fg = c.Lavender },
      GitSignsChangeLn = { fg = c.Lavender },
      GitSignsCurrentLineBlame = { fg = FADED_GRAY },

      -- NvimTree
      NvimTreeGitDirty = { fg = c.Lavender },
      NvimTreeGitStaged = { fg = c.Lavender },
      NvimTreeGitMerge = { fg = c.Lavender },
      NvimTreeGitRenamed = { fg = c.Lavender },
      NvimTreeGitNew = { fg = c.Lavender },
      NvimTreeGitDeleted = { fg = c.Lavender },
      NvimTreeFolderName = { fg = WHITE },
      NvimTreeOpenedFolderName = { fg = WHITE },
      NvimTreeEmptyFolderName = { fg = WHITE },
      NvimTreeRootFolder = { fg = GRAY },
      NvimTreeSpecialFile = { fg = WHITE, bold = true },
      NvimTreeNormalFloat = { bg = BG },
      NvimTreeCursorLine = { bg = ALMOST_BG },
      NvimTreeIndentMarker = { fg = STRONG_FADED_GRAY },
      NvimTreeImageFile = { fg = WHITE },
      NvimTreeFolderIcon = { fg = GRAY },
      NvimTreeFolderIconOpen = { fg = GRAY },
      NvimTreeFolderSymlink = { fg = GRAY },
      NvimTreeDefault = { fg = GRAY },
      NvimTreeSymlink = { fg = GRAY },
      NvimTreeBookmark = { fg = GRAY },
    }

    -- change color of icons
    local new_icons = {}
    for key, icon in pairs(icons.get_icons()) do
      icon.color = GRAY
      new_icons[key] = icon
      overrides["BufferLineDevIcon" .. icon.name] = { bg = BG, fg = FADED_GRAY }         -- unactive tabs to faded gray
      overrides["BufferLineDevIcon" .. icon.name .. "Selected"] = { bg = BG, fg = GRAY } -- active tabs to gray
    end
    icons.set_icon(new_icons)

    return overrides
  end,
})
vim.opt.termguicolors = true
require("bufferline").setup {}
-- setup must be called before loading
vim.cmd("colorscheme catppuccin")
