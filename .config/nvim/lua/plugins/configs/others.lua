local M = {}

M.colorizer = function()
    local present, colorizer = pcall(require, "colorizer")
    if present then
        colorizer.setup({
            user_default_options = {
                virtualtext = "■",
            },
        })
        vim.cmd("ColorizerReloadAllBuffers")
    end
end

M.presence = function()
    local present, presence = pcall(require, "presence")
    if present then
        presence:setup({
            enable_line_number = true,
            main_image = "file",
            neovim_image_text = "Don't memorize what you can search for - Albert Einstein",
        })
    end
end

M.blankline = function()
    local present, blankline = pcall(require, "indent_blankline")
    if not present then
        return
    end
    local opts = {
        indentLine_enabled = 1,
        filetype_exclude = {
            "help",
            "terminal",
            "packer",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "mason",
            "",
        },
        buftype_exclude = { "terminal" },
        show_trailing_blankline_indent = true,
        show_first_indent_level = true,
        show_current_context = false,
        show_current_context_start = false,
        space_char_blankline = " ",
    }
    blankline.setup(opts)
end

return M
