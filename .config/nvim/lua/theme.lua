-- list of themes:
-- theme: "gruvchad" , "javacafe" , "onedark" , "norchad" , "tomorrow-night", "tokyonight", "mountaineer"
vim.g.theme = "norchad"

local present, base16 = pcall(require, "base16")

if present then
    base16(base16.themes[vim.g.theme], true)
    require "highlights"
    return true

else
    return false
end
