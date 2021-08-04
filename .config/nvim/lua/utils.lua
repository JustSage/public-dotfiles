local M = {}

M.toggle_quickfix = function()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      vim.cmd('cclose')
      return
    end
  end
  vim.cmd('copen')
end
-- mapping
--

M.close_hide_win = function()
    local windows = vim.api.nvim_win_get_number('$')
    if windows > 1 then
        vim.api.nvim_win_hide(0)
    else
        vim.api.nvim_win_close(0, {force=true})
    end
end
-- mapping
-- map("n", "q", "<Cmd>lua close_hide_win()<CR>", {silent = true})

return M
