local M = {}

M.colorizer = function()
    local present, colorizer = pcall(require, "colorizer")
    if present then
        colorizer.setup()
        vim.cmd("ColorizerReloadAllBuffers")
    end
end

M.presence = function()
    local present, presence = pcall(require, "presence")
    if present then
        presence:setup(
            {
                enable_line_number = true,
                main_image = "file",
                neovim_image_text = "Don't memorize what you can search for - Albert Einstein"
            }
        )
    end
end

return M
