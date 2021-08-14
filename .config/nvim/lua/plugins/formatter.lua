local present, formatter = pcall(require, "formatter")
if not present then
    return
end

formatter.setup({
    logging = false,
    filetype = {
        python = {
            function()
                return {
                    exe = "black",
                    args = {"--fast", vim.api.nvim_buf_get_name(0)},
                    stdin = true
                }
            end
        },
        cpp = {
            function()
                return {
                    exe = "clang-format",
                    args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
                    stdin = true,
                    cwd = vim.fn.expand('%p:h') -- Run clangd in cwd.
                }
            end
        },
        lua = {
            function()
                return {
                    exe = "luafmt",
                    args = {"--indent-count", 2, "--stdin"},
                    stdin = true
                }
            end
        },
    }
})


