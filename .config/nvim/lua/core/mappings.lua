vim.g.mapleader = " " -- leader key keybinding map
local function map(mode, lhs, rhs, opts) -- keybinding convention
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- local opt = {}


-- Disable command history list on q:
map("n", "q:", "<nop>")
map("n", "Q", "<nop>")

-- Add argument to namespace
map("n", "<leader>a", ":argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<c-d>")

map("n", "<C-q>", ":lua require'core.functions'.toggle_quickfix()<CR>")
map("n", "<C-.>", ":cnext<CR>zz")
map("n", "<C-,>", ":cprev<CR>zz")
map("n", "<C-;>", ":lnext<CR>zz")
map("n", "<C-/>", ":lprev<CR>zz")

-- Better yank line
-- map("n", "Y", "y$") -- nvim >= 0.6 built in

-- Cursor standstill
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- Moving lines faster with J & K
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<leader>j", ":m .+1<CR>==")
map("n", "<leader>k", ":m .-2<CR>==")

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

-- Telescope
map("n", "<leader>fg", ":Telescope live_grep<CR>")
map("n", "<leader>gc", ":Telescope git_commits <CR>")
map("n", "<leader>ff", ":Telescope find_files <CR>")
map("n", "<leader>fb", ":Telescope buffers<CR>")
map("n", "<leader>fh", ":Telescope help_tags<CR>")
map("n", "<leader>fw", ":Telescope grep_string<CR>")
map("n", "<leader>th", ":Telescope themes<CR>")
map("n", "<C-g><C-g>", ":Telescope git_files <CR>")

map("n", "<leader>gq", ":Telescope ghq list<CR>")
map("n", "<leader>rc", ":lua require('plugins.configs.telescope').search_dotfiles()<CR>")

-- Nvim Tree
map("n", "<leader>n", ":NvimTreeToggle<CR>")

-- Tmux integration
map("n", "<C-h>", ":lua require('tmux').move_left()<CR>")
map("n", "<C-j>", ":lua require('tmux').move_bottom()<CR>")
map("n", "<C-k>", ":lua require('tmux').move_top()<CR>")
map("n", "<C-l>", ":lua require('tmux').move_right()<CR>")

map("n", "M-h", ":lua require('tmux').resize_left()<CR>")
map("n", "M-j", ":lua require('tmux').resize_bottom()<CR>")
map("n", "M-k", ":lua require('tmux').resize_top()<CR>")
map("n", "M-l", ":lua require('tmux').resize_right()<CR>")

-- Ultest
map("n", "<leader>tn", "<Plug>(ultest-next-fail)")
map("n", "<leader>tp", "<Plug>(ultest-prev-fail)")

-- Nvim dap
map("n", "<leader>dh", ":lua require'dap'.toggle_breakpoint()<CR>")
map("n", "<leader>dhh", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")

map("n", "<leader>dn", ":lua require'dap'.run_to_cursor()<CR>")
map("n", "<leader>dk", ":lua require'dap'.up()<CR>")
map("n", "<leader>dj", ":lua require'dap'.down()<CR>")
map("n", "<leader>dt", ":lua require'dap'.terminate()<CR>")
map("n", "<leader>dr", ":lua require'dap'.repl.toggle({}, 'vsplit')<CR><C-w>l")
map("n", "<leader>de", ":lua require'dap'.set_exception_breakpoints({'all'})<CR>")
map("n", "<leader>di", ":lua require'dap.ui.widgets'.hover()<CR>")
map("n", "<leader>d?", ":lua require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")

map("n", "<leader>ds", ":lua require'dap'.step_out()<CR>")
map("n", "<leader>dss", ":lua require'dap'.step_into()<CR>")
map("n", "<leader>dg", ":lua require'dap'.step_over()<CR>")
map("n", "<leader>dc", ":lua require'dap'.continue()<CR>")
