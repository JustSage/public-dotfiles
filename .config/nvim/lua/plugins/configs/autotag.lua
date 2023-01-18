local status, autotag = pcall(require, 'nvim-ts-autotag')
if (not status) then return end

lvim.builtin.treesitter.autotag.enable = true
autotag.setup()
