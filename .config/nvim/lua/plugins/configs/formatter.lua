local present, formatter = pcall(require, "formatter")
if not present then
  return
end

formatter.setup(
  {
    logging = false,
    filetype = {
      python = {
        function()
          return {
            exe = "black",
            args = {"--fast", vim.api.nvim_buf_get_name(0)},
            stdin = false
          }
        end
      },
      c = {
        function()
          return {
            exe = "clang-format",
            args = {'--assume-filename=', vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), '--style="{BasedOnStyle: llvm, IndentWidth: 4}"'},
            stdin = true
          }
        end
      },
      lua = {
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 4, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)
