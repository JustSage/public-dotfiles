local M = {}

M.clear_cmdline = function()
    vim.defer_fn(
        function()
            vim.cmd("echo")
        end,
        0
    )
end

return M
