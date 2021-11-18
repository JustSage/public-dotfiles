local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
    return
end

ts_config.setup {
  highlight = {
      enable = true,
      use_languagetree = true
  },
  ensure_installed = {
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
    "toml",
    "json",
    "c"
    },
  rainbow = {
      enable = true
  }
}

