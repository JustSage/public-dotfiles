local present, _ = pcall(require, "packerinit")
local packer

if present then
    packer = require "packer"
else
    return false
end

local use = packer.use

return packer.startup(
    function()
        use {
            "wbthomason/packer.nvim",
            event = "VimEnter"
        }

        -- UI and Color
        use {
            "siduck76/nvim-base16.lua",
            after = "packer.nvim",
            config = function()
                require "theme"
            end
        }

        -- file managing , picker etc
        use {
            "kyazdani42/nvim-tree.lua",
            cmd = "NvimTreeToggle",
            config = function()
                require "plugins.nvimtree"
            end
        }

        use {
            "glepnir/galaxyline.nvim",
            -- 'shadmansaleh/lualine.nvim', -- active fork
            -- 'hoob3rt/lualine.nvim', -- main fork
            after = "nvim-base16.lua",
            config = function()
              require "plugins/statusline"
            end
        }

        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("plugins.others").colorizer()
            end
        }

        use {
            "kyazdani42/nvim-web-devicons",
            after = "nvim-base16.lua",
            config = function()
                require "plugins.icons"
            end
        }

        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = function()
                require "plugins.treesitter"
            end
        }

        use {
            "andweeb/presence.nvim",
            event = "BufRead",
            config = function()
              require("presence"):setup({
                enable_line_number = true,
                main_image = "file",
                neovim_image_text = "The gods editor",
            })
            end
        }


        -- Lsp and Completions
        use {
            "kabouzeid/nvim-lspinstall",
            event = "BufEnter"
        }

        use {
            "neovim/nvim-lspconfig",
            after = "nvim-lspinstall",
            config = function()
                require "plugins.lspconfig"
            end
        }

        use {
            "onsails/lspkind-nvim",
            event = "BufRead",
            config = function()
                require("plugins.others").lspkind()
            end
        }

        -- load compe in insert mode only
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require "plugins/compe"
            end,
            wants = "LuaSnip",
            requires = {
                {
                    "L3MON4D3/LuaSnip",
                    wants = "friendly-snippets",
                    event = "InsertCharPre",
                    config = function()
                        require "plugins.luasnip"
                    end
                },
                {
                    "rafamadriz/friendly-snippets",
                    event = "InsertCharPre"
                }
            }
        }

        use {
            "ray-x/lsp_signature.nvim",
            after = "nvim-lspconfig",
            config = function()
                require "plugins.signature"
            end
        }


        -- file search
        use {
            "nvim-lua/plenary.nvim",
            event = "BufRead"
        }
        use {
            "nvim-lua/popup.nvim",
            after = "plenary.nvim"
        }

        use {
            "nvim-telescope/telescope.nvim",
            cmd = "Telescope",
            requires = {
                { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            },
            config = function()
                require "plugins.telescope"
            end
        }

        -- formatter
        -- use {
        --     "sbdchd/neoformat",
        --     cmd = {
        --         "Neoformat"
        --     }
        -- }
        --
        use {
            "mhartington/formatter.nvim",
            config = function()
                require "plugins.formatter"
            end
        }


        -- git stuff
        use {
            "lewis6991/gitsigns.nvim",
            after = "plenary.nvim",
            config = function()
                require "plugins.gitsigns"
            end
        }

        -- misc plugins
        use {
            "windwp/nvim-autopairs",
            after = "nvim-compe",
            config = function()
                require "plugins.autopairs"
            end
        }

        use {
            "aserowy/tmux.nvim",
            config = function()
                require "plugins.tmux"
            end
        }

        use {
            "andymass/vim-matchup",
            event = "CursorMoved"
        }

        -- Testing
        use {
           "rcarriga/vim-ultest",
           requires = "vim-test/vim-test",
           run = ":UpdateRemotePlugins",
           config = function()
              require "plugins.ultest"
           end
        }

        use {
            'iamcco/markdown-preview.nvim',
            run = [[sh -c 'cd app && yarn install']]
        }

        use { "tpope/vim-fugitive" }
        use { "tpope/vim-rhubarb" }
        use { "tpope/vim-commentary" }
        use { "tpope/vim-surround" }

        use {
            "dstein64/vim-startuptime",
            cmd = {
                "StartupTime"
            }
        }

        end
    )
