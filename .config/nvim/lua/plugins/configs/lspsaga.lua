local keymap = vim.keymap.set
local status, saga = pcall(require, "lspsaga")
if not status then
    return
end

saga.setup({
    ui = {
        -- currently only round theme
        theme = "round",
        -- this option only work in neovim 0.9
        title = true,
        -- border type can be single,double,rounded,solid,shadow.
        border = "solid",
        winblend = 0,
        expand = "",
        collapse = "",
        preview = " ",
        code_action = "💡",
        diagnostic = "🐞",
        incoming = " ",
        outgoing = " ",
        colors = {
            --float window normal background color
            normal_bg = "#1d1536",
            --title background color
            title_bg = "#afd700",
            red = "#e95678",
            magenta = "#b33076",
            orange = "#FF8700",
            yellow = "#f7bb3b",
            green = "#afd700",
            cyan = "#36d0e0",
            blue = "#61afef",
            purple = "#CBA6F7",
            white = "#d1d4cf",
            black = "#1c1c19",
        },
    },
    -- ui = {
    -- 	colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
    -- 	kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    -- },
    lightbulb = {
        cache_code_action = false,
        virtual_text = false,
        sign = true,
    },
    code_action = {
        keys = {
            quit = "<ESC>",
            exec = "<CR>",
        },
    },
    symbol_in_winbar = {
        enable = false,
    },
})

local opts = { silent = true }

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gh", "<Cmd>Lspsaga lsp_finder<CR>", opts)

-- Code action
keymap("v", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", opts)
keymap("n", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", opts)

keymap("n", "rn", "<Cmd>Lspsaga rename<CR>", opts)

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "gj", "<Cmd>Lspsaga peek_definition<CR>", opts)

-- Show line diagnostics
keymap("n", "<leader>d", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)

-- Show cursor diagnostics
keymap("n", "<leader>cd", "<Cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

-- Diagnostic jump can use `<c-o>` to jump back
keymap("n", "[]", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "][", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)

-- Only jump to error
keymap("n", "[e", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)
keymap("n", "]e", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)

-- Outline
keymap("n", "<leader>o", "<Cmd>Lspsaga outline<CR>", opts)

-- Hover Doc
keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
