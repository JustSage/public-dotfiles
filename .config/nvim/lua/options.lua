-------------------- HELPERS -------------------------------
local g = vim.g    -- a table to set global variables
local o = vim.opt  -- a table to set option variables
local bo = vim.bo  -- a table to set buffer specific option variables
local wo = vim.wo  -- a table to set window specific option variables
local cmd = vim.cmd -- vim cmd api
-----------------------------------------------------------------
o.encoding = 'utf-8'	                    -- encoding settings.
o.fileencodings = 'utf-8'	                -- encoding buffer settings.
o.completeopt='menuone,noinsert,noselect' -- complete option menu.
o.termguicolors = true                    -- use the terminal gui colors.
o.hidden = true                           -- navigate to other buffers without saving current.
o.autowrite = true                        -- write file when switching buffer.
o.autoread = true                         -- read file when switching buffer.
wo.number = true                          -- show row current line.
wo.relativenumber = true                  -- show relative numbers above/below current row.
o.cursorline = true                       -- highlights the line on cursor.
o.errorbells = false                      -- avoids screen flashes.
o.showmode = false                        -- avoids hl messages in different modes.
o.ignorecase = true                       -- the case of normal letters is ignored.
o.smartcase = true                        -- overrides ignorecase if search includes uppercase letters.
bo.swapfile = false                       -- disable swapfile generator.
o.backup = false                          -- disable backupfile generator.
o.undofile = true                         -- disable undofile generator.
o.incsearch = true                        -- incremental search.
o.inccommand = 'split'	                  -- incremental subtitution
bo.autoindent = true                      -- figures out how to indent.
bo.smartindent = true                     -- figures out when to indent.
o.splitbelow = true                       -- horizontal splits below.
o.splitright = true		                    -- veritcal splits to the right.
o.showcmd = true		                      -- shows command on the right side of the command prompt.
o.cmdheight = 1		                        -- command prompt height.
o.scrolloff = 10		                      -- keep 'n' lines visible when scrolling.
o.lazyredraw = true                       -- good performance settings.
o.diffopt = 'vertical'                    -- opens git diff in vertical split.
o.timeoutlen = 500
o.updatetime = 250                        -- update interval for gitsigns.
o.keywordprg = ':help'                    -- open help with 'K'.
o.clipboard = "unnamedplus"               --  clipboard settings for my os (darwin)
o.fillchars = {eob = " "}                 -- avoid trailing whitespace
o.formatoptions:remove{"c","r","o"}

o.path:append{'**'}                       -- file paths, searching and ignores
o.wildignore:append{"*/node_modules/*", "*.pyc", "*.DS_Store","*.jpg", "*.bmp", "*.gif", "*.png", "*.jpeg","versions/*","cache/*"}
o.suffixesadd:append{".js",".es",".jsx",".json",".css",".sass",".py",".md",".java",".c",".cpp"}

o.dictionary = '/usr/share/dict/words'
bo.tabstop = 2
bo.softtabstop = 2
bo.shiftwidth = 2
bo.expandtab = true

o.signcolumn = 'yes'
wo.wrap = false

-- providers
g.python3_host_prog = '$PYENV_ROOT/shims/python'


local disabled_built_ins = {
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
    "matchit"
}


-- packer compile on plugins.lua change.
cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])
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

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
