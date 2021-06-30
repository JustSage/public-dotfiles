if exists('g:loaded_nvim_treesitter')
  finish
endif

lua << EOF
require 'nvim-treesitter.configs'.setup {
  highlight = {
      enable = true,
      disable = {},
      },
    indent = {
      enable = false,
      disable = {},
      },
    ensure_installed = {
      "bash",
      "regex",
      "python",
      "java",
      "cpp",
      "css",
      "scss",
      "html",
      "javscript",
      "tsx",
      "toml",
      "json"
      "c",
      }
    rainbow = {
      enable = true
      }
    }
EOF
