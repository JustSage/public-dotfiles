local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
    return
end

ts_config.setup({
    ensure_installed = {
        "markdown",
        "vim",
        "help",
        "bash",
        "regex",
        "python",
        "java",
        "lua",
        "cpp",
        "css",
        "scss",
        "html",
        "javascript",
        "tsx",
        "typescript",
        "toml",
        "json",
        "c",
    },
    highlight = {
        enable = true,
        use_languagetree = true,
    },
    rainbow = {
        enable = true,
    },
    matchup = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
})
