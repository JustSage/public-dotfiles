local M = {}
vim.g.default_theme = "nord"

-- if theme given, load given theme if given
M.init = function(theme)
   -- set the global theme, used at various places like theme switcher, highlights
   local present, base16 = pcall(require, "base16")
   vim.g.theme = theme

    if not theme then
      theme = vim.g.default_theme
    end

   if present then
      -- first load the base16 theme
      base16(base16.themes(theme), true)

      -- unload to force reload
      package.loaded["colors.highlights" or false] = nil
      -- then load the highlights
      require "colors.highlights"
   else
      return false
   end
end

-- returns a table of colors for givem or current theme
M.get = function(theme)
   if not theme then
      theme = vim.g.default_theme
   end

   return require("hl_themes." .. theme)
end

return M
