local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local colors = require("catppuccin.palettes").get_palette "macchiato"
local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = true,
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },

  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },

  },
  cond = hide_in_width
}

local mode = {
  "mode",
  fmt = function(str)
    return "-- " .. str .. " --"
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local location = {
  "location",
  padding = 0,
}

-- cool function for progress
local progress = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local macro_recording = {
  "macro-recording",
  fmt = function()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
      return ""
    else
      return "Recording @" .. recording_register
    end
  end,
}

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    require('lualine').refresh({
      place = { "statusline" },
    })
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    local timer = vim.loop.new_timer()
    timer:start(
      50,
      0,
      vim.schedule_wrap(function()
        require('lualine').refresh({
          place = { "statusline" },
        })
      end)
    )
  end,
})
default = { fg = colors.Lavender, bg = colors.Crust }
return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = {
            a = { fg = colors.Lavender, bg = colors.Crust },
            b = { fg = colors.Lavender, bg = colors.Crust },
            c = { fg = colors.Lavender, bg = colors.Crust },
            x = { fg = colors.Lavender, bg = colors.Crust },
            y = { fg = colors.Lavender, bg = colors.Crust },
            z = { fg = colors.Lavender, bg = colors.Crust },
          },
          inactive = {
            a = { fg = colors.Lavender, bg = colors.Crust },
            b = { fg = colors.Lavender, bg = colors.Crust },
            c = { fg = colors.Lavender, bg = colors.Crust },
            x = { fg = colors.Lavender, bg = colors.Crust },
            y = { fg = colors.Lavender, bg = colors.Crust },
            z = { fg = colors.Lavender, bg = colors.Crust },
          },
        },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "dashboard", "neo-tree", "Outline" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { branch, diagnostics },
        lualine_b = { mode },
        lualine_c = { macro_recording },
        -- lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_x = { { 'filename', file_status = true, path = 1 }, diff, spaces, "encoding", filetype },
        lualine_y = { location },
        lualine_z = { progress },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {},
      theme = {

      }
    })
  end
}
