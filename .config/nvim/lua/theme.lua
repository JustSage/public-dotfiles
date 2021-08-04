-- list of themes:
-- theme: "gruvbox" , "javacafe" , "onedark" , "nord" , "tomorrow-night"
vim.g.theme = "onedark"

local present, base16 = pcall(require, "base16")

if present then
    base16(base16.themes[vim.g.theme], true)
    require "highlights"
    return true

else
    return false
end
