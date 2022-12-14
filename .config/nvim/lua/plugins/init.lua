local present, _ = pcall(require, "plugins.packerinit")
local packer

if present then
    packer = require "packer"
else
    return false
end
local use = packer.use

return packer.startup(
    function()
        -- Plugin manager
        use {
            "wbthomason/packer.nvim",
            event = "VimEnter"
        }


        -- UI & Colors, icons
        use { "catppuccin/nvim", as = "catppuccin" }

        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("plugins.configs.others").colorizer()
            end
        }

        use {
            "kyazdani42/nvim-web-devicons",
            -- after = "base46",
            config = function()
                require "plugins.configs.icons"
            end
            -- NOTE: requires nerd font
        }

        -- terminal
        use {
            "akinsho/toggleterm.nvim",
            event = "BufRead",
            config = function()
                require "plugins.configs.terminal"
            end
        }

        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = function()
                require "plugins.configs.treesitter"
            end
        }

        -- Flask syntax highlight
        use {"lepture/vim-jinja"}

        -- Rest api
        use {
            "NTBBloodbath/rest.nvim",
            config = function()
                require "plugins.configs.rest"
            end
        }

        -- Lsp related
        use {
            "williamboman/nvim-lsp-installer",
            cmd = "do User LspAttachBuffers",
            event = "BufEnter"
        }

        use {
            "neovim/nvim-lspconfig",
            after = "nvim-lsp-installer",
            config = function()
                require "plugins.configs.lspconfig"
            end
        }

        use { "mfussenegger/nvim-jdtls" }


        use {
            "ray-x/lsp_signature.nvim",
            after = "nvim-lspconfig",
            config = function()
                require "plugins.configs.signature"
            end
        }

        -- Completion enginer & Snippets
        use {
            "rafamadriz/friendly-snippets",
            event = "InsertEnter"
        }

        use {
            "hrsh7th/nvim-cmp",
            after = "friendly-snippets",
            config = function()
                require "plugins.configs.cmp"
            end
        }

        use {
            "L3MON4D3/LuaSnip",
            wants = "friendly-snippets",
            after = "nvim-cmp",
            config = function()
                require "plugins.configs.luasnip"
            end
        }

        use {
            "saadparwaiz1/cmp_luasnip",
            after = "LuaSnip"
        }

        use {
            "hrsh7th/cmp-nvim-lua",
            after = "cmp_luasnip"
        }

        use {
            "hrsh7th/cmp-nvim-lsp",
            after = "cmp-nvim-lua"
        }

        use {
            "hrsh7th/cmp-buffer",
            after = "cmp-nvim-lsp"
        }

        use {
            "hrsh7th/cmp-path",
            after = "cmp-buffer"
        }

        -- File navigation & fuzzy finder

        use {
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            cmd = "NvimTreeToggle",
            config = function()
                require "plugins.configs.nvimtree"
            end
        }


        use { "nvim-lua/plenary.nvim" } -- dependency for telescope & gitsigns

        use {
            "nvim-telescope/telescope.nvim",
            -- cmd = "Telescope", slowing down startup
            requires = {
                {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
                {"nvim-telescope/telescope-ghq.nvim"}
            },
            config = function()
                require "plugins.configs.telescope"
            end
        }

        -- Git related
        -- use {
        --     "lewis6991/gitsigns.nvim",
        --     after = "plenary.nvim",
        --     config = function()
        --         require "plugins.configs.gitsigns"
        --     end
        --
        -- }

        use {"tpope/vim-fugitive"}
        use {"tpope/vim-rhubarb"}

        -- Testing
        use {
            "rcarriga/vim-ultest",
            requires = "vim-test/vim-test",
            run = ":UpdateRemotePlugins",
            config = function()
                require "plugins.configs.ultest"
            end
        }

        -- Debugging
        use "Pocco81/DAPInstall.nvim"
        use {
            "mfussenegger/nvim-dap",
            config = function()
                require "plugins.configs.dap"
            end
        }



        -- Miscellaneous

        use {
            "numToStr/Comment.nvim",
            config = function()
                require "plugins.configs.comment"
            end
        }

        use {
            "windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = function()
                require "plugins.configs.autopairs"
            end
        }

        use {
            "andymass/vim-matchup",
            event = "CursorMoved"
        }

        use {"tpope/vim-surround"}
        use {"tpope/vim-repeat"}


        use {
            "iamcco/markdown-preview.nvim",
            run = [[sh -c 'cd app && yarn install']]
        }

        use {
            "mattn/emmet-vim",
            config = function()
                vim.g.user_emmet_mode='n'
                vim.g.user_emmet_leader_key=','
            end
        }

        use {
            "dstein64/vim-startuptime",
            cmd = {
                "StartupTime"
            }
        }

        -- Integrations
        use {
            "andweeb/presence.nvim",
            event = "BufRead",
            config = function()
                require("plugins.configs.others").presence()
            end
        }

        use {
            "aserowy/tmux.nvim",
            config = function()
                require "plugins.configs.tmux"
            end
        }

        -- Org mode
        -- use {
        --     'kristijanhusak/orgmode.nvim',
        --     after = 'nvim-treesitter',
        --     config = function()
        --         require('orgmode').setup{}
        --     end
        -- }

        -- Personal modded extensions
        use { "JustSage/extensions" }
    end
)
