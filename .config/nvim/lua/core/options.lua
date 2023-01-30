-------------------- HELPERS -------------------------------
local g = vim.g -- a table to set global variables
local o = vim.opt -- a table to set option variables
local bo = vim.bo -- a table to set buffer specific option variables
local wo = vim.wo -- a table to set window specific option variables
local env = vim.env -- vim environment api
-----------------------------------------------------------------
o.encoding = "utf-8" -- encoding settings.
o.fileencodings = "utf-8" -- encoding buffer settings.
o.spelllang = "en_us" -- set spelling to english
o.completeopt = "menuone,noinsert,noselect" -- complete option menu.
o.termguicolors = true -- use the terminal gui colors.
o.hidden = true -- navigate to other buffers without saving current.
o.autowrite = true -- write file when switching buffer.
o.autoread = true -- read file when switching buffer.
wo.number = true -- show row current line.
wo.relativenumber = true -- show relative numbers above/below current row.
o.cursorline = true -- highlights the line on cursor.
o.errorbells = false -- avoids screen flashes.
o.showmode = false -- avoids hl messages in different modes.
o.ignorecase = true -- the case of normal letters is ignored.
o.smartcase = true -- overrides ignorecase if search includes uppercase letters.
bo.swapfile = false -- disable swapfile generator.
o.backup = false -- disable backupfile generator.
o.undofile = true -- disable undofile generator.
o.incsearch = true -- incremental search.
o.inccommand = "split" -- incremental subtitution
bo.autoindent = true -- figures out how to indent.
bo.smartindent = true -- figures out when to indent.
o.splitbelow = true -- horizontal splits below.
o.splitright = true -- veritcal splits to the right.
o.showcmd = true -- shows command on the right side of the command prompt.
o.cmdheight = 1 -- command prompt height.
o.scrolloff = 10 -- keep 'n' lines visible when scrolling.
o.lazyredraw = true -- good performance settings.
o.diffopt = "vertical" -- opens git diff in vertical split.
o.timeoutlen = 250 -- timeout before key refresh.
o.updatetime = 250 -- update interval for gitsigns.
o.keywordprg = ":help" -- open help with 'K'.
o.clipboard = "" -- clipboard settings for my os (darwin)
o.fillchars = { eob = " " } -- avoid trailing whitespace
o.mouse = "a" -- enable mouse

vim.cmd([[setlocal formatoptions-=cro]]) -- disable comment continouation in next line

o.path:append({ "**" }) -- file paths, searching and ignores
o.wildignore:append({
	"*/node_modules/*",
	"*.pyc",
	"*.DS_Store",
	"*.jpg",
	"*.bmp",
	"*.gif",
	"*.png",
	"*.jpeg",
	"versions/*",
	"cache/*",
})
o.suffixesadd:append({ ".html", ".js", ".es", ".jsx", ".json", ".css", ".sass", ".py", ".md", ".java", ".c", ".cpp" })

o.dictionary = "/usr/share/dict/words"
bo.tabstop = 2
bo.softtabstop = 2
bo.shiftwidth = 2
bo.expandtab = true

o.signcolumn = "yes"
wo.wrap = false

-- change directory upon opening buffers, windows etc.
-- g.autochdir = true

-- providers
g.python3_host_prog = "$PYENV_ROOT/shims/python"
g.python2_host_prog = "/usr/bin/python2"

env.GIT_WORK_TREE = vim.fn.expand("$HOME")
env.GIT_DIR = vim.fn.expand("$HOME/.cfg")

local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end
