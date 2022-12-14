local present1, gl = pcall(require, "galaxyline")
local present2, condition = pcall(require, "galaxyline.condition")
local colors = require("colors").get()

if not (present1 or present2) then
    return
end

local gls = gl.section

gl.short_line_list = {" "}

local left_separator = " "  -- or ""," "
local right_separator = " " -- or ""," "


if vim.g.theme == "chadracula" then
    colors.grey_fg2 = colors.purple
    colors.lightbg = colors.black
end

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 30 then
        return true
    end
    return false
end

-- local function has_width_gt(cols)
--     -- Check if the windows width is greater than a given number of columns
--     return vim.fn.winwidth(0) / 2 > cols
-- end

local mode_colors = {
    [110] = {"NORMAL", colors.green},
    [105] = {"INSERT", colors.nord_blue},
    [99] = {"COMMAND", colors.pink},
    [116] = {"TERMINAL", colors.blue},
    [118] = {"VISUAL", colors.cyan},
    [22] = {"V-BLOCK", colors.cyan},
    [86] = {"V-LINE", colors.cyan},
    [82] = {"REPLACE", colors.orange},
    [115] = {"SELECT", colors.nord_blue},
    [83] = {"S-LINE", colors.nord_blue}
}

local mode = function(n)
    return mode_colors[vim.fn.mode():byte()][n]
end

gls.left[1] = {
    ViMode = {
        provider = function()
            vim.api.nvim_command("hi GalaxyViMode guibg=" .. mode(2))
            return "  " .. mode(1) .. " "
        end,
        highlight = {colors.black, "bold"},
        separator = " ",
        separator_highlight = {colors.lightbg, colors.lightbg}
    }
}

gls.left[2] = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = {colors.white, colors.lightbg}
    }
}

gls.left[4] = {
    FileName = {
        provider = function()
            local fileinfo = require("galaxyline.provider_fileinfo")
            if vim.api.nvim_buf_get_name(0):len() == 0 then
                return ""
            end
            return fileinfo.get_current_file_name("", "")
        end,
        highlight = {colors.white, colors.lightbg},
        separator = right_separator,
        separator_highlight = {colors.lightbg, colors.lightbg2}
    }
}

gls.left[5] = {
    current_dir = {
        provider = function()
            local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return "  " .. dir_name .. " "
        end,
        highlight = {colors.grey_fg2, colors.lightbg2},
        separator = right_separator,
        separator_highlight = {colors.lightbg2, colors.statusline_bg}
    }
}

gls.left[6] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "  ",
        highlight = {colors.white, colors.statusline_bg}
    }
}

gls.left[7] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = "   ",
        highlight = {colors.grey_fg2, colors.statusline_bg}
    }
}

gls.left[8] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = "  ",
        highlight = {colors.grey_fg2, colors.statusline_bg}
    }
}

gls.left[9] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.statusline_bg}
    }
}

gls.left[10] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.yellow, colors.statusline_bg}
    }
}

gls.right[1] = {
    lsp_status = {
        provider = function()
            local clients = vim.lsp.get_active_clients()
            local msg = "  " .. "N/A"
            if next(clients) ~= nil then
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return "" .. "  " .. "LSP"
                    end
                end
                return msg
            else
                return msg
            end
        end,
        highlight = {colors.white, colors.statusline_bg},
        separator = left_separator,
        separator_highlight = {colors.statusline_bg, colors.statusline_bg}
    }
}

gls.right[2] = {
    GitIcon = {
        provider = function()
            return "  "
        end,
        condition = require("galaxyline.condition").check_git_workspace,
        highlight = {colors.green, colors.lightbg2},
        separator = left_separator,
        separator_highlight = {colors.lightbg2, colors.statusline_bg}
    }
}

gls.right[3] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.condition").check_git_workspace,
        highlight = {colors.green, colors.lightbg2}
    }
}

gls.right[4] = {
    line_percentage = {
        provider = function()
            local current_line = vim.fn.line(".")
            local total_line = vim.fn.line("$")

            if current_line == 1 then
                return " Top "
            elseif current_line == vim.fn.line("$") then
                return " Bot "
            end
            local result, _ = math.modf((current_line / total_line) * 100)
            return " " .. result .. "% "
        end,
        highlight = {colors.green, colors.lightbg},
        separator = left_separator,
        separator_highlight = function()
            local isgit = require("galaxyline.condition").check_git_workspace()
            if isgit then
                return {colors.lightbg, colors.lightbg2}
            else
                return {colors.lightbg, colors.statusline_bg}
            end
        end
    }
}

gls.right[5] = {
    some_RoundIcon = {
        provider = function()
            return "   "
        end,
        highlight = {colors.lightbg, colors.green}
    }
}
