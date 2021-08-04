local status, lualine = pcall(require, "lualine")
if (not status) then
    return
end

local global_theme = "themes/" .. vim.g.theme
local colors = require(global_theme)

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

lualine.setup {
  options = {
    icons_enabled = true,
    theme = vim.g.theme,
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
        {'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}},
        {lsp_status , color = {fg = colors.white}}
    },
    lualine_y = {'filetype'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
   lualine_z = {}
  },
  tabline = {},
    extensions = {'fugitive'}
}
