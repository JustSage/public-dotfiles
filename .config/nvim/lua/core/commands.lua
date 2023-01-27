local cmd = vim.cmd

cmd([[cnoremap <expr> / wildmenumode() ? "\<C-Y>" : "/"]])
cmd([[cnoremap <expr> * getcmdline() =~ '.*\*\*$' ? '/*' : '*']])
cmd([[cnoreabbr <expr> %% fnameescape(expand('%:p'))]])

-- neotest commands
cmd([[
command! NeotestSummary lua require("neotest").summary.toggle()
command! NeotestFile lua require("neotest").run.run(vim.fn.expand("%"))
command! Neotest lua require("neotest").run.run(vim.fn.getcwd())
command! NeotestNearest lua require("neotest").run.run()
command! NeotestDebug lua require("neotest").run.run({ strategy = "dap" })
command! NeotestAttach lua require("neotest").run.attach()
]])
-- avoids loading packer at runtime.
cmd("silent! command PackerCompile lua require 'plugins.init' require('packer').compile()")
cmd("silent! command PackerInstall lua require 'plugins.init' require('packer').install()")
cmd("silent! command PackerStatus lua require 'plugins.init' require('packer').status()")
cmd("silent! command PackerSync lua require 'plugins.init' require('packer').sync()")
cmd("silent! command PackerUpdate lua require 'plugins.init' require('packer').update()")
-- packer compile on plugins.lua change.
cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])
-- highlight on yank
cmd([[ au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=true, timeout=150} ]])
-- no numbers or relative numbers on term windows.
cmd([[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]])
-- turn off paste mode when leaving insert.
cmd([[autocmd InsertLeave * set nopaste]])
-- set spelling for git commits, org and markdown files.
cmd([[augroup SetSpelling autocmd! autocmd FileType gitcommit,markdown,org setlocal spell spelllang=en_us]])
-- open a file where where you left
cmd(
	[[au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
)
-- turn off paste mode when leaving insert.
cmd([[autocmd InsertLeave * set nopaste]])
-- file specific tabbing.
cmd([[autocmd FileType python,lua,java setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])
-- set file type to terminals
cmd([[ au TermOpen term://* setfiletype terminal ]])
-- initiates new java class with file name when opening a new file
cmd([[ au BufNewFile *.java exe "normal opublic class " . expand('%:t:r') "\n{\n\n}"]])

-- local current_buffer = vim.api.nvim_get_current_buf()
--
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--     callback = function()
--         vim.diagnostic.enable(current_buffer)
--         vim.g.diagnostic_state = true
--     end
-- })

-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
--     callback = function()
--         vim.diagnostic.disable(current_buffer)
--         vim.g.diagnostic_state = false
--     end
-- })
