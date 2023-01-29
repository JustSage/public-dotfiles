local keymap = vim.keymap.set
local status, saga = pcall(require, "lspsaga")
if not status then
    return
end

saga.setup({
    ui = {
        -- currently only round theme
        theme = "round",
        -- border type can be single,double,rounded,solid,shadow.
        border = "rounded",
        winblend = 0,
        expand = "",
        collapse = "",
        preview = " ",
        code_action = "💡",
        diagnostic = "🐞",
        incoming = " ",
        outgoing = " ",
        colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    },
    preview = {
        lines_above = 0,
        lines_below = 0,
    },
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
keymap("n", "<leader>rn", "<cmd>Lspsaga rename ++project<CR>")

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
