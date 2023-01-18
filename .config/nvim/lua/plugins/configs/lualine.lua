local status, lualine = pcall(require, 'lualine')
if (not status) then return end

local custom_fname = require('lualine.components.filename'):extend()
local utils = require("lualine.utils.utils")
local highlight = require('lualine.highlight')
local default_status_colors = { saved = '#a6da95', modified = '#e78284' }

local lsp_status = function()
    local clients = vim.lsp.get_active_clients()
    local msg = " " .. "N/A"
    if next(clients) ~= nil then
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return " " .. "LSP"
            end
        end
        return msg
    else
        return msg
    end
end

local diagnostics_message = require("lualine.component"):extend()

diagnostics_message.default = {
    colors = {
        error = utils.extract_color_from_hllist(
            { "fg", "sp" },
            { "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
            "#e32636"
        ),
        warn = utils.extract_color_from_hllist(
            { "fg", "sp" },
            { "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
            "#ffa500"
        ),
        info = utils.extract_color_from_hllist(
            { "fg", "sp" },
            { "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "DiffChange" },
            "#ffffff"
        ),
        hint = utils.extract_color_from_hllist(
            { "fg", "sp" },
            { "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffAdd" },
            "#273faf"
        ),
    },
}
function diagnostics_message:init(options)
    diagnostics_message.super:init(options)
    self.options.colors = vim.tbl_extend("force", diagnostics_message.default.colors, self.options.colors or {})
    self.highlights = { error = "", warn = "", info = "", hint = "" }
    self.highlights.error = highlight.create_component_highlight_group(
        { fg = self.options.colors.error },
        "diagnostics_message_error",
        self.options
    )
    self.highlights.warn = highlight.create_component_highlight_group(
        { fg = self.options.colors.warn },
        "diagnostics_message_warn",
        self.options
    )
    self.highlights.info = highlight.create_component_highlight_group(
        { fg = self.options.colors.info },
        "diagnostics_message_info",
        self.options
    )
    self.highlights.hint = highlight.create_component_highlight_group(
        { fg = self.options.colors.hint },
        "diagnostics_message_hint",
        self.options
    )
end

function diagnostics_message:update_status(is_focused)
    local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local diagnostics = vim.diagnostic.get(0, { lnum = r - 1 })
    if #diagnostics > 0 then
        local diag = diagnostics[1]
        for _, d in ipairs(diagnostics) do
            if d.severity < diag.severity then
                diagnostics = d
            end
        end
        local icons = { " ", " ", " ", " " }
        local hl = { self.highlights.error, self.highlights.warn, self.highlights.info, self.highlights.hint }
        return highlight.component_format_highlight(hl[diag.severity]) .. icons[diag.severity] .. " " .. diag.message
    else
        return ""
    end
end

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
        }
    end
end

function custom_fname:init(options)
    custom_fname.super.init(self, options)
    self.status_colors = {
        saved = highlight.create_component_highlight_group(
            { fg = default_status_colors.saved }, 'filename_status_saved', self.options),
        modified = highlight.create_component_highlight_group(
            { fg = default_status_colors.modified }, 'filename_status_modified', self.options),
    }
    if self.options.color == nil then self.options.color = '' end
end

function custom_fname:update_status()
    local data = custom_fname.super.update_status(self)
    data = highlight.component_format_highlight(vim.bo.modified
        and self.status_colors.modified
        or self.status_colors.saved) .. data
    return data
end

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'catppuccin',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 200,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { { custom_fname }, { diagnostics_message } },
        lualine_x = { { 'diff', source = diff_source }, lsp_status,
            { 'diagnostics', sources = { "nvim_lsp" }, symbols = { error = ' ', warn = ' ', info = ' ',
                hint = ' ' } } },
        lualine_y = { 'progress' },
        lualine_z = { 'filetype' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { 'fugitive' }
}
