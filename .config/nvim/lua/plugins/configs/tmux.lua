-- Configuration for tmux integration
local present, tmux = pcall(require, "tmux")
if not present then
    return
end

tmux.setup({
    copy_sync = {
        enable = false,
    },
    navigation = {
        enable_default_keybindings = true,
    },
    resize = {
        enable_default_keybindings = true,
    }
})
