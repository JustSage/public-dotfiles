--TODO: remodel to nvim-tree.lua
local g = vim.g
local tree_cb = require("nvim-tree.config").nvim_tree_callback

vim.o.termguicolors = true

g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_tab_open = 0
g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_gitignore = 1
g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
g.nvim_tree_update_cwd = 1
g.nvim_tree_ignore = { "__pycache__", ".git", "node_modules", ".cache" }
g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

g.nvim_tree_show_icons = {
    folders = 1,
    files = 1,
    git = 1
}

g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "",
        staged = "",
        unmerged = "",
        renamed = "➜",
        deleted = "",
        untracked = "﯏",
        ignored = "◌"
    },
    folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = ""
    }
}

g.nvim_tree_bindings = {
    { key = { "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb("edit") },
    { key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb("cd") },
    { key = "<C-v>", cb = tree_cb("vsplit") },
    { key = "<C-x>", cb = tree_cb("split") },
    { key = "<C-t>", cb = tree_cb("tabnew") },
    { key = "<", cb = tree_cb("prev_sibling") },
    { key = ">", cb = tree_cb("next_sibling") },
    { key = "P", cb = tree_cb("parent_node") },
    { key = "<BS>", cb = tree_cb("close_node") },
    { key = "<S-CR>", cb = tree_cb("close_node") },
    { key = "<Tab>", cb = tree_cb("preview") },
    { key = "K", cb = tree_cb("first_sibling") },
    { key = "J", cb = tree_cb("last_sibling") },
    { key = "I", cb = tree_cb("toggle_ignored") },
    { key = "H", cb = tree_cb("toggle_dotfiles") },
    { key = "R", cb = tree_cb("refresh") },
    { key = "a", cb = tree_cb("create") },
    { key = "d", cb = tree_cb("remove") },
    { key = "r", cb = tree_cb("rename") },
    { key = "<C->", cb = tree_cb("full_rename") },
    { key = "x", cb = tree_cb("cut") },
    { key = "c", cb = tree_cb("copy") },
    { key = "p", cb = tree_cb("paste") },
    { key = "y", cb = tree_cb("copy_name") },
    { key = "Y", cb = tree_cb("copy_path") },
    { key = "gy", cb = tree_cb("copy_absolute_path") },
    { key = "[c", cb = tree_cb("prev_git_item") },
    { key = "}c", cb = tree_cb("next_git_item") },
    { key = "-", cb = tree_cb("dir_up") },
    { key = "q", cb = tree_cb("close") },
    { key = "g?", cb = tree_cb("toggle_help") }
}

local present, nvimtree = pcall(require, "nvim-tree")
if not present then
    return
end

nvimtree.setup {
    diagnostics = {
        enable = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = ""
        }
    },
    filters = {
        dotfiles = false
    },
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = false
    },
    view = {
        -- allow_resize = true,
        side = "left",
        width = 25
    }
}
