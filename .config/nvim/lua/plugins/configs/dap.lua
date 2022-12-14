local present, dap = pcall(require, 'dap')
if not present then
    return
end

vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStop', {text='🟢', texthl='', linehl='', numhl=''})
