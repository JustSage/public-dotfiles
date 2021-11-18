vim.g.mapleader = " " -- leader key keybinding map
local function map(mode, lhs, rhs, opts) -- keybinding convention
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}



map("n", "<Leader>a", ":argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<c-d>", opt)
vim.cmd([[cnoremap <expr> / wildmenumode() ? "\<C-Y>" : "/"]])
vim.cmd([[cnoremap <expr> * getcmdline() =~ '.*\*\*$' ? '/*' : '*']])
vim.cmd([[cnoreabbr <expr> %% fnameescape(expand('%:p'))]])

map("n", "Q", "<Nop>", opt)

map("n", "<C-q>", "<Cmd> lua require'functions'.toggle_quickfix()<CR>", opt)
map("n", "<C-K>", "<Cmd> cnext<CR>zz", opt)
map("n", "<C-J>", "<Cmd> cprev<CR>zz", opt)
map("n", "<C-H>", "<Cmd> lnext<CR>zz", opt)
map("n", "<C-L>", "<Cmd> lprev<CR>zz", opt)

-- better yank line
map("n", "Y", "y$", opt)

-- cursor standstill
map("n", "n", "nzzzv", opt)
map("n", "N", "Nzzzv", opt)
map("n", "J", "mzJ`z", opt)

--  moving lines faster with J & K
map("v", "J", ":m '>+1<CR>gv=gv", opt)
map("v", "K", ":m '<-2<CR>gv=gv", opt)
map("n", "<Leader>j", ":m .+1<CR>==", opt)
map("n", "<Leader>k", ":m .-2<CR>==", opt)

-- better undo
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")

-- avoids loading packer at runtime.
vim.cmd("silent! command PackerCompile lua require 'plugins.init' require('packer').compile()")
vim.cmd("silent! command PackerInstall lua require 'plugins.init' require('packer').install()")
vim.cmd("silent! command PackerStatus lua require 'plugins.init' require('packer').status()")
vim.cmd("silent! command PackerSync lua require 'plugins.init' require('packer').sync()")
vim.cmd("silent! command PackerUpdate lua require 'plugins.init' require('packer').update()")

map("n", "<Leader>n", [[<Cmd> NvimTreeToggle<CR>]], opt) -- tree view

-- use ESC to turn off search highlighting
map("n", "<Esc>", ":noh<CR>", opt)

-- git bindings
map("n", "<Leader>gs", ":Git<CR>", opt)
map("n", "<Leader>gf", ":diffget //2<CR>", opt)
map("n", "<Leader>gj", ":diffget //3<CR>", opt)
map("n", "<Leader>gb", ":Git blame<CR>", opt)

-- telescope mappings
map("n", "<Leader>fw", ":Telescope live_grep<CR>", opt)
map("n", "<Leader>gc", ":Telescope git_commits <CR>", opt)
map("n", "<Leader>ff", ":Telescope find_files <CR>", opt)
map("n", "<Leader>fb", ":Telescope buffers<CR>", opt)
map("n", "<Leader>fh", ":Telescope help_tags<CR>", opt)
map("n", "<Leader>fw", ":Telescope grep_string<CR>", opt)
map("n", "<Leader>th", ":Telescope themes<CR>", opt)
map("n", "<Leader>gq", ":Telescope ghq list bin=<CR>", opt)
map("n", "<C-g><C-g>", ":Telescope git_files <CR>", opt)

map("n", "<C-h>", [[<Cmd>lua require("tmux").move_left()<CR>]], opt)
map("n", "<C-j>", [[<Cmd>lua require("tmux").move_bottom()<CR>]], opt)
map("n", "<C-k>", [[<Cmd>lua require("tmux").move_top()<CR>]], opt)
map("n", "<C-l>", [[<Cmd>lua require("tmux").move_right()<CR>]], opt)

map("n", "M-h", [[<Cmd>lua require("tmux").resize_left()<CR>]], opt)
map("n", "M-j", [[<Cmd>lua require("tmux").resize_bottom()<CR>]], opt)
map("n", "M-k", [[<Cmd>lua require("tmux").resize_top()<CR>]], opt)
map("n", "M-l", [[<Cmd>lua require("tmux").resize_right()<CR>]], opt)

map("n", "<C-t>", "<Plug>(ultest-next-fail)", opt)
map("n", "<C-T>", "<Plug>(ultest-prev-fail)", opt)
