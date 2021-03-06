local cmd = vim.cmd

local colors = require("colors").get()

local white = colors.white
local darker_black = colors.darker_black
local black = colors.black
local black2 = colors.black2
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local one_bg3 = colors.one_bg3
local light_grey = colors.light_grey
local grey = colors.grey
local grey_fg = colors.grey_fg
local grey_fg2 = colors.grey_fg2
local red = colors.red
local line = colors.line
local green = colors.green
local nord_blue = colors.nord_blue
local blue = colors.blue
local yellow = colors.yellow
local purple = colors.purple

-- for guifg , bg

local function fg(group, color)
    cmd("hi " .. group .. " guifg=" .. color)
end

local function bg(group, color)
    cmd("hi " .. group .. " guibg=" .. color)
end

local function fg_bg(group, fgcol, bgcol)
    cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end


-- misc --
fg("LineNr", grey)
fg("Comment", grey_fg)
fg("NvimInternalError", red)
fg("VertSplit", line)
fg("EndOfBuffer", black)

-- Pmenu
bg("Pmenu", one_bg)
bg("PmenuSbar", one_bg2)
bg("PmenuSel", green)
bg("PmenuThumb", nord_blue)

-- inactive statuslines as thin splitlines
cmd("hi! StatusLineNC gui=underline guifg=" .. line)

-- cmd "hi clear CursorLine"
cmd "hi clear SignColumn"
fg("cursorlinenr", white)

-- git signs ---
fg_bg("DiffAdd", green, "none")
fg_bg("DiffChange", nord_blue, "none")
fg_bg("DiffModified", black2, "none")
fg_bg("DiffDelete", red, "none")

-- NvimTree
fg("NvimTreeFolderIcon", blue)
fg("NvimTreeFolderName", blue)
fg("NvimTreeOpenedFolderName", blue)
fg("NvimTreeEmptyFolderName", blue)
fg("NvimTreeIndentMarker", one_bg2)
fg("NvimTreeVertSplit", darker_black)
bg("NvimTreeVertSplit", darker_black)
fg("NvimTreeEndOfBuffer", darker_black)
bg("NvimTreeNormal", darker_black)
fg("NvimTreeRootFolder", red)
fg_bg("NvimTreeStatuslineNc", darker_black, darker_black)
fg_bg("NvimTreeWindowPicker", red, black2)

-- telescope
fg("TelescopeBorder", grey)
fg("TelescopePromptBorder", green)
fg("TelescopeResultsBorder", grey)
fg("TelescopePreviewBorder", grey)
fg("TelescopePreviewTitle", green)
fg("TelescopePromptTitle", green)
fg("TelescopeResultsTitle", green)
bg("TelescopeSelection", black2)

-- LspDiagnostics ---
fg("DiagnosticHint", purple)
fg("DiagnosticError", red)
fg("DiagnosticWarn", yellow)
fg("DiagnosticInformation", green)

-- packer's floating window

bg("NormalFloat", "NONE")
bg("FloatBorder", "NONE")
fg("FloatBorder", blue)

-- set bg color for nvim
bg("Normal", black)
