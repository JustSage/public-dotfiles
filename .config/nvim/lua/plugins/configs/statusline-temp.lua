local present, feline = pcall(require, "feline")
if not present then
   return
end

local default = {
   -- colors = require("colors").get(),
   lsp = require "feline.providers.lsp",
   lsp_severity = vim.diagnostic.severity,
}

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'MAC' then
        icon = '  '
    elseif os == 'UNIX' then
        icon = '  '
    else
        icon = '  '
    end
    return icon
end

default.icon_styles = {
   default = {
      left = "",
      right = " ",
      main_icon = file_osinfo(),
      vi_mode_icon = " ",
      position_icon = " ",
   },
   arrow = {
      left = "",
      right = "",
      main_icon = file_osinfo(),
      vi_mode_icon = " ",
      position_icon = " ",
   },

   block = {
      left = " ",
      right = " ",
      main_icon = file_osinfo(),
      vi_mode_icon = "  ",
      position_icon = "  ",
   },

   round = {
      left = "",
      right = "",
      main_icon = file_osinfo(),
      vi_mode_icon = " ",
      position_icon = " ",
   },

   slant = {
      left = " ",
      right = " ",
      main_icon = file_osinfo(),
      vi_mode_icon = "",
      position_icon = " ",
   },
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 30 then
        return true
    end
    return false
end

default.shortline = checkwidth() == false and true

-- statusline style
default.statusline_style = default.icon_styles["round"]

-- Initialize the components table
default.components = {
   active = {},
}

default.main_icon = {
   provider = default.statusline_style.main_icon,

   hl = {
      fg = default.colors.statusline_bg,
      bg = default.colors.nord_blue,
   },

   right_sep = {
      str = default.statusline_style.right,
      hl = {
         fg = default.colors.nord_blue,
         bg = default.colors.lightbg,
      },
   },
}

default.file_name = {
   provider = function()
      local filename = vim.fn.expand "%:t"
      local extension = vim.fn.expand "%:e"
      local icon = require("nvim-web-devicons").get_icon(filename, extension)
      if icon == nil then
         icon = " "
         return icon
      end
      return " " .. icon .. " " .. filename .. " "
   end,
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
   end,
   hl = {
      fg = default.colors.white,
      bg = default.colors.lightbg,
   },

   right_sep = {
      str = default.statusline_style.right,
      hl = { fg = default.colors.lightbg, bg = default.colors.lightbg2 },
   },
}

default.dir_name = {
   provider = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      return "  " .. dir_name .. " "
   end,

   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 80
   end,

   hl = {
      fg = default.colors.grey_fg2,
      bg = default.colors.lightbg2,
   },
   right_sep = {
      str = default.statusline_style.right,
      hi = {
         fg = default.colors.lightbg2,
         bg = default.colors.statusline_bg,
      },
   },
}

default.diff = {
   add = {
      provider = "git_diff_added",
      hl = {
         fg = default.colors.grey_fg2,
         bg = default.colors.statusline_bg,
      },
      icon = " ",
   },

   change = {
      provider = "git_diff_changed",
      hl = {
         fg = default.colors.grey_fg2,
         bg = default.colors.statusline_bg,
      },
      icon = "  ",
   },

   remove = {
      provider = "git_diff_removed",
      hl = {
         fg = default.colors.grey_fg2,
         bg = default.colors.statusline_bg,
      },
      icon = "  ",
   },
}

default.git_branch = {
   provider = "git_branch",
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
   end,
   hl = {
      fg = default.colors.grey_fg2,
      bg = default.colors.statusline_bg,
   },
   icon = "  ",
}

default.diagnostic = {
   error = {
      provider = "diagnostic_errors",
      enabled = function()
         return default.lsp.diagnostics_exist(default.lsp_severity.ERROR)
      end,

      hl = { fg = default.colors.red },
      icon = "  ",
   },

   warning = {
      provider = "diagnostic_warnings",
      enabled = function()
         return default.lsp.diagnostics_exist(default.lsp_severity.WARN)
      end,
      hl = { fg = default.colors.yellow },
      icon = "  ",
   },

   hint = {
      provider = "diagnostic_hints",
      enabled = function()
         return default.lsp.diagnostics_exist(default.lsp_severity.HINT)
      end,
      hl = { fg = default.colors.grey_fg2 },
      icon = "  ",
   },

   info = {
      provider = "diagnostic_info",
      enabled = function()
         return default.lsp.diagnostics_exist(default.lsp_severity.INFO)
      end,
      hl = { fg = default.colors.green },
      icon = "  ",
   },
}

default.lsp_progress = {
   provider = function()
      local Lsp = vim.lsp.util.get_progress_messages()[1]

      if Lsp then
         local msg = Lsp.message or ""
         local percentage = Lsp.percentage or 0
         local title = Lsp.title or ""
         local spinners = {
            "",
            "",
            "",
         }

         local success_icon = {
            "",
            "",
            "",
         }

         local ms = vim.loop.hrtime() / 1000000
         local frame = math.floor(ms / 120) % #spinners

         if percentage >= 70 then
            return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
         end

         return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
      end

      return ""
   end,
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 80
   end,
   hl = { fg = default.colors.green },
}

default.lsp_icon = {
   provider = function()
      if next(vim.lsp.buf_get_clients()) ~= nil then
         return "  LSP"
      else
         return ""
      end
   end,
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
   end,
   hl = { fg = default.colors.grey_fg2, bg = default.colors.statusline_bg },
}

default.mode_colors = {
    [110] = {"NORMAL", default.colors.red},
    [105] = {"INSERT", default.colors.dark_purple},
    [99] = {"COMMAND", default.colors.pink},
    [116] = {"TERMINAL", default.colors.green},
    [118] = {"VISUAL", default.colors.cyan},
    [22] = {"V-BLOCK", default.colors.cyan},
    [86] = {"V-LINE", default.colors.cyan},
    [82] = {"REPLACE", default.colors.orange},
    [115] = {"SELECT", default.colors.nord_blue},
    [83] = {"S-LINE", default.colors.nord_blue}
}

default.mode_hl = function()
   return {
      fg = default.mode_colors[vim.fn.mode():byte()][2],
      bg = default.colors.one_bg,
   }
end

default.empty_space = {
   provider = " " .. default.statusline_style.left,
   hl = {
      fg = default.colors.one_bg2,
      bg = default.colors.statusline_bg,
   },
}

-- this matches the vi mode color
default.empty_spaceColored = {
   provider = default.statusline_style.left,
   hl = function()
      return {
         fg = default.mode_colors[vim.fn.mode():byte()][2],
         bg = default.colors.one_bg2,
      }
   end,
}

default.mode_icon = {
   provider = default.statusline_style.vi_mode_icon,
   hl = function()
      return {
         fg = default.colors.statusline_bg,
         bg = default.mode_colors[vim.fn.mode():byte()][2],
      }
   end,
}

default.empty_space2 = {
   provider = function()
      return " " .. default.mode_colors[vim.fn.mode():byte()][1] .. " "
   end,
   hl = default.mode_hl,
}

default.separator_right = {
   provider = default.statusline_style.left,
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
   end,
   hl = {
      fg = default.colors.grey,
      bg = default.colors.one_bg,
   },
}

default.separator_right2 = {
   provider = default.statusline_style.left,
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
   end,
   hl = {
      fg = default.colors.green,
      bg = default.colors.grey,
   },
}

default.position_icon = {
   provider = default.statusline_style.position_icon,
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
   end,
   hl = {
      fg = default.colors.black,
      bg = default.colors.green,
   },
}

default.current_line = {
   provider = function()
      local current_line = vim.fn.line "."
      local total_line = vim.fn.line "$"

      if current_line == 1 then
         return " Top "
      elseif current_line == vim.fn.line "$" then
         return " Bot "
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return " " .. result .. "%% "
   end,

   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
   end,

   hl = {
      fg = default.colors.green,
      bg = default.colors.one_bg,
   },
}

local function add_table(a, b)
   table.insert(a, b)
end

local M = {}
M.setup = function()
   -- components are divided in 3 sections
   default.left = {}
   default.middle = {}
   default.right = {}

   -- left
   add_table(default.left, default.main_icon)
   add_table(default.left, default.file_name)
   add_table(default.left, default.dir_name)
   add_table(default.left, default.diff.add)
   add_table(default.left, default.diff.change)
   add_table(default.left, default.diff.remove)
   add_table(default.left, default.diagnostic.error)
   add_table(default.left, default.diagnostic.warning)
   add_table(default.left, default.diagnostic.hint)
   add_table(default.left, default.diagnostic.info)

   add_table(default.middle, default.lsp_progress)

   -- right
   add_table(default.right, default.lsp_icon)
   add_table(default.right, default.git_branch)
   add_table(default.right, default.empty_space)
   add_table(default.right, default.empty_spaceColored)
   add_table(default.right, default.mode_icon)
   add_table(default.right, default.empty_space2)
   add_table(default.right, default.separator_right)
   add_table(default.right, default.separator_right2)
   add_table(default.right, default.position_icon)
   add_table(default.right, default.current_line)

   default.components.active[1] = default.left
   default.components.active[2] = default.middle
   default.components.active[3] = default.right

   feline.setup {
      theme = {
         bg = default.colors.statusline_bg,
         fg = default.colors.fg,
      },
      -- components = require('catppuccin.core.integrations.feline'),
      components = default.components,
   }
end

return M
