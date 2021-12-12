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
        use {
            "NvChad/nvim-base16.lua",
            after = "packer.nvim",
            config = function()
                require("colors").init()
            end
        }

        use {
            "glepnir/galaxyline.nvim",
            after = "nvim-base16.lua",
            config = function()
                require "configs.statusline"
            end
        }

        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("configs.others").colorizer()
            end
        }

        use {
            "kyazdani42/nvim-web-devicons",
            after = "nvim-base16.lua",
            config = function()
                require "configs.icons"
            end
            -- NOTE: requires nerd font
        }

        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = function()
                require "configs.treesitter"
            end
        }

        use {"lepture/vim-jinja"}

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
                require "configs.lspconfig"
            end
        }

        use {
            "ray-x/lsp_signature.nvim",
            after = "nvim-lspconfig",
            config = function()
                require "configs.signature"
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
                require "configs.cmp"
            end
        }

        use {
            "L3MON4D3/LuaSnip",
            wants = "friendly-snippets",
            after = "nvim-cmp",
            config = function()
                require "configs.luasnip"
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
                require "configs.nvimtree"
            end
        }


        use { "nvim-lua/plenary.nvim" } -- dependency for telescope & gitsigns

        use {
            "nvim-telescope/telescope.nvim",
            cmd = "Telescope",
            requires = {
                {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
                {"nvim-telescope/telescope-ghq.nvim"}
            },
            config = function()
                require "configs.telescope"
            end
        }

        -- Git related
        use {
            "lewis6991/gitsigns.nvim",
            after = "plenary.nvim",
            config = function()
                require "configs.gitsigns"
            end
        }

        use {"tpope/vim-fugitive"}
        use {"tpope/vim-rhubarb"}

        -- Testing
        use {
            "rcarriga/vim-ultest",
            requires = "vim-test/vim-test",
            run = ":UpdateRemotePlugins",
            config = function()
                require "configs.ultest"
            end
        }

        -- Miscellaneous

        use {
            "numToStr/Comment.nvim",
            config = function()
                require "configs.comment"
            end
        }

        use {
            "windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = function()
                require "configs.autopairs"
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
                require("configs.others").presence()
            end
        }

        use {
            "aserowy/tmux.nvim",
            config = function()
                require "configs.tmux"
            end
        }

        -- Org mode
        use {
            'kristijanhusak/orgmode.nvim',
            after = 'nvim-treesitter',
            config = function()
                require('orgmode').setup{}
            end
        }

        -- Personal modded extensions
        use { "JustSage/extensions" }
    end
)
