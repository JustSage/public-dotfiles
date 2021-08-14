vim.g.mapleader = ' '                                                                   -- leader key keybinding map
local function map(mode, lhs, rhs, opts)                                                -- keybinding convention
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

map("n", "<Up>", "<Nop>", opt)
map("n", "<Down>", "<Nop>", opt)
map("n", "<Left>", "<Nop>", opt)
map("n", "<Right>", "<Nop>", opt)

map("v", "<Up>", "<Nop>", opt)
map("v", "<Down>", "<Nop>", opt)
map("v", "<Left>", "<Nop>", opt)
map("v", "<Right>", "<Nop>", opt)

map("i", "<Up>", "<Nop>", opt)
map("i", "<Down>", "<Nop>", opt)
map("i", "<Left>", "<Nop>", opt)
map("i", "<Right>", "<Nop>", opt)

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
vim.cmd("silent! command PackerCompile lua require 'pluglist' require('packer').compile()")
vim.cmd("silent! command PackerInstall lua require 'pluglist' require('packer').install()")
vim.cmd("silent! command PackerStatus lua require 'pluglist' require('packer').status()")
vim.cmd("silent! command PackerSync lua require 'pluglist' require('packer').sync()")
vim.cmd("silent! command PackerUpdate lua require 'pluglist' require('packer').update()")

map("n", "<Leader>fm", [[<Cmd> Neoformat<CR>]], opt)        -- formatting
map("n", "<Leader>n", [[<Cmd> NvimTreeToggle<CR>]], opt)    -- tree view

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
map("n", "<Leader>th", ":Telescope theme_switcher<CR>", opt)
map('n', '<Leader>rc', "<Cmd>lua require('plugins.telescope').search_dotfiles()<CR>",  opt)
map("n", "<Leader>ps", "<Cmd>lua require('plugins.telescope').grep_string_prompt()<CR>", opt)
map("n", "<C-g><C-g>", ":Telescope git_files <CR>", opt)

map("n", "<C-h>", [[<Cmd>lua require("tmux").move_left()<CR>]], opt)
map("n", "<C-j>", [[<Cmd>lua require("tmux").move_bottom()<CR>]], opt)
map("n", "<C-k>", [[<Cmd>lua require("tmux").move_top()<CR>]], opt)
map("n", "<C-l>", [[<Cmd>lua require("tmux").move_right()<CR>]], opt)

map("n", "M-h", [[<Cmd>lua require("tmux").resize_left()<CR>]], opt)
map("n", "M-j", [[<Cmd>lua require("tmux").resize_bottom()<CR>]], opt)
map("n", "M-k", [[<Cmd>lua require("tmux").resize_top()<CR>]], opt)
map("n", "M-l", [[<Cmd>lua require("tmux").resize_right()<CR>]], opt)

map("n", "]t", "<Plug>(ultest-next-fail)", opt)
map("n", "[t", "<Plug>(ultest-prev-fail)", opt)
