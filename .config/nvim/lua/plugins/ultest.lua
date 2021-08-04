vim.g.ultest_use_pty = 1
vim.g['test#python#pytest#options'] = "--color=yes"
vim.g['test#javascript#jest.options'] = "--color=always"

vim.api.nvim_command [[augroup UltestRunner au! au BufWritePost * UltestNearest augroup END]]
