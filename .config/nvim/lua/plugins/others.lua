local M = {}

M.colorizer = function()
    local present, colorizer = pcall(require, "colorizer")
    if present then
        colorizer.setup()
        vim.cmd("ColorizerReloadAllBuffers")
    end
end

M.lspkind = function()
    local present, lspkind = pcall(require, "lspkind")
    if present then
        lspkind.init()
    end
end


M.lspsignature = function()
    local present, lspsignature = pcall(require, "lsp_signature")
    if present then
        lspsignature.setup()
    end
end


return M
