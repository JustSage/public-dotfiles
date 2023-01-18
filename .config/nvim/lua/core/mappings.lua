vim.g.mapleader = " " -- leader key keybinding map
local function map(mode, lhs, rhs, opts) -- keybinding convention
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- local opt = {}

-- Disable command history list on q:
map("n", "q:", "<nop>")
map("n", "Q", "<nop>")

map("x", "<leader>p", '"_dP')
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')
map("v", "<leader>d", '"_d')
map("n", "<leader>d", '"_d')

-- map("n", "<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>")

map("n", "<C-q>", ":lua require'core.functions'.toggle_quickfix()<CR>")
map("n", "<C-n>", ":cnext<CR>zz")
map("n", "<C-p>", ":cprev<CR>zz")
map("n", "<C-f>", ":lnext<CR>zz")
map("n", "<C-b>", ":lprev<CR>zz")

-- Cursor standstill
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- Moving lines faster with J & K
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<leader>j", ":m .+1<CR>==")
map("n", "<leader>k", ":m .-2<CR>==")

map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
map("n", "<leader>x", ":!chmod +x %<CR>", { silent = true })

-- Better undo - undos to punctuation
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")

-- Use ESC to turn off search highlighting
map("n", "<Esc>", ":noh<CR>")

-- Fugitive
map("n", "<leader>gs", ":Git<CR>")
map("n", "<leader>gf", ":diffget //2<CR>")
map("n", "<leader>gj", ":diffget //3<CR>")
map("n", "<leader>gb", ":Git blame<CR>")

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fs", function()
	builtin.grep_string({ search = vim.fn.input("Grep >") })
end)
vim.keymap.set("n", "<leader>rc", function()
	builtin.find_files({ cwd = "~/.config/", prompt_title = "< Dotfiles >", hidden = true })
end)
-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})
vim.keymap.set("n", "<C-g><C-g>", builtin.git_files, {})

-- Nvim Tree
map("n", "<leader>n", ":NvimTreeToggle<CR>")

-- Tmux integration
map("n", "<C-Up>", ":lua require('tmux').move_top()<CR>")
map("n", "<C-Down>", ":lua require('tmux').move_bottom()<CR>")
map("n", "<C-Left>", ":lua require('tmux').move_left()<CR>")
map("n", "<C-Right>", ":lua require('tmux').move_right()<CR>")

map("n", "M-h", ":lua require('tmux').resize_left()<CR>")
map("n", "M-j", ":lua require('tmux').resize_bottom()<CR>")
map("n", "M-k", ":lua require('tmux').resize_top()<CR>")
map("n", "M-l", ":lua require('tmux').resize_right()<CR>")
