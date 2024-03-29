local present, cmp = pcall(require, "cmp")
if not present then
    return
end

vim.opt.completeopt = "menuone,noselect"

-- nvim-cmp setup
cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    formatting = {
        format = function(entry, vim_item)
            -- load lspkind icons
            vim_item.kind =
            string.format("%s %s", require("plugins.configs.lspkind_icons").icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                emmet_vim = "[Emmet]",
                buffer = "[BUF]",
                latex_symbols = "[Latex]",
                env = "[ENV]",
            })[entry.source.name]

            vim_item.dup = ({
                nvim_lsp = 0,
                nvim_lua = 0,
                buffer = 0,
                cmdline = 0,
                path = 0,
            })[entry.source.name] or 0
            return vim_item
        end,
    },
    mapping = {
        [","] = cmp.mapping(function(fallback)
            fallback()
        end), -- emmet support
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
                fallback()
            end
        end,
    },

    preselect = cmp.PreselectMode.None,
    sorting = {
        comparators = {
            cmp.config.compare.sort_text,
            cmp.config.compare.score,
            cmp.config.compare.order,
            cmp.config.compare.offset,
            cmp.config.compare.kind,
            cmp.config.compare.length,
            cmp.config.compare.exect
        }
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "emmet_vim" },
        { name = "latex_symbols", option = { strategy = 2 } },
        { name = "cmp-tw2css" },
        { name = "tmux" },
        {
            name = "env",
            option = {
                eval_on_confirm = false,
                show_documentation_window = true,
                item_kind = cmp.lsp.CompletionItemKind.Constructor,
            },
            group_index = 2,
        },
        { name = "path" },
        { name = "buffer" },
    },

    enabled = function()
        -- disable completion on prompt buffers
        local buftype = vim.api.nvim_buf_get_option(0, "buftype")
        if buftype == "prompt" then
            return false
        end
        -- disable completion in comments
        local context = require("cmp.config.context")
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == "c" then
            return true
        else
            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        end
    end,
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        {
            name = "cmdline",
            option = {
                ignore_cmds = { "Man", "!" },
            },
        },
    }),
})
