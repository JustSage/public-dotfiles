local present, luasnip = pcall(require, "luasnip")
if not present then
    return
end

luasnip.config.set_config(
    {
        history = true,
        updateevents = "TextChanged,TextChangedI"
        -- updateevents = "InsertLeave"
    }
)
require("luasnip/loaders/from_vscode").load()
