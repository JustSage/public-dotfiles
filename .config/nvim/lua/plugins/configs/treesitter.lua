local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
    return
end

ts_config.setup {
    highlight = {
        enable = true,
        use_languagetree = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
    },
    ensure_installed = {
        "org",
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
    rainbow = {
        enable = true
    }
}
