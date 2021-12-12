local cmd = vim.cmd

cmd([[cnoremap <expr> / wildmenumode() ? "\<C-Y>" : "/"]])
cmd([[cnoremap <expr> * getcmdline() =~ '.*\*\*$' ? '/*' : '*']])
cmd([[cnoreabbr <expr> %% fnameescape(expand('%:p'))]])

-- avoids loading packer at runtime.
vim.cmd("silent! command PackerCompile lua require 'plugins.init' require('packer').compile()")
vim.cmd("silent! command PackerInstall lua require 'plugins.init' require('packer').install()")
vim.cmd("silent! command PackerStatus lua require 'plugins.init' require('packer').status()")
vim.cmd("silent! command PackerSync lua require 'plugins.init' require('packer').sync()")
vim.cmd("silent! command PackerUpdate lua require 'plugins.init' require('packer').update()")
