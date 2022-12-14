local cmd = vim.cmd

cmd([[cnoremap <expr> / wildmenumode() ? "\<C-Y>" : "/"]])
cmd([[cnoremap <expr> * getcmdline() =~ '.*\*\*$' ? '/*' : '*']])
cmd([[cnoreabbr <expr> %% fnameescape(expand('%:p'))]])

-- avoids loading packer at runtime.
cmd("silent! command PackerCompile lua require 'plugins.init' require('packer').compile()")
cmd("silent! command PackerInstall lua require 'plugins.init' require('packer').install()")
cmd("silent! command PackerStatus lua require 'plugins.init' require('packer').status()")
cmd("silent! command PackerSync lua require 'plugins.init' require('packer').sync()")
cmd("silent! command PackerUpdate lua require 'plugins.init' require('packer').update()")
-- packer compile on plugins.lua change.
cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

-- no numbers or relative numbers on term windows.
cmd([[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]])
-- turn off paste mode when leaving insert.
cmd([[autocmd InsertLeave * set nopaste]])
-- set spelling for git commits, org and markdown files.
cmd([[augroup SetSpelling autocmd! autocmd FileType gitcommit,markdown,org setlocal spell spelllang=en_us]])
-- open a file where where you left
cmd([[au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
-- turn off paste mode when leaving insert.
cmd([[autocmd InsertLeave * set nopaste]])
-- file specific tabbing.
cmd([[autocmd FileType python,lua,java setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])
-- set file type to terminals
cmd([[ au TermOpen term://* setfiletype terminal ]])
-- initiates new java class with file name when opening a new file
cmd([[ au BufNewFile *.java exe "normal opublic class " . expand('%:t:r') "\n{\n\n}"]])
