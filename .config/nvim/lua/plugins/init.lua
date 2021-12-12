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
        use {
            "wbthomason/packer.nvim",
            event = "VimEnter"
        }

        use {
            "JustSage/extensions"
        }

        -- UI and Color
        use {
            "NvChad/nvim-base16.lua",
            after = "packer.nvim",
            config = function()
                require("colors").init()
            end
        }

        -- file managing , picker etc
        use {
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            cmd = "NvimTreeToggle",
            config = function()
                require "plugins.configs.nvimtree"
            end
        }

        use {
            "glepnir/galaxyline.nvim",
            after = "nvim-base16.lua",
            config = function()
                require "plugins.configs.statusline"
            end
        }

        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("plugins.configs.others").colorizer()
            end
        }

        use {
            "kyazdani42/nvim-web-devicons",
            after = "nvim-base16.lua",
            config = function()
                require "plugins.configs.icons"
            end
        }

        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = function()
                require "plugins.configs.treesitter"
            end
        }

        use {
            "andweeb/presence.nvim",
            event = "BufRead",
            config = function()
                require("plugins.configs.others").presence()
            end
        }

        -- Lsp and Completions
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

        use {
            "ray-x/lsp_signature.nvim",
            after = "nvim-lspconfig",
            config = function()
                require "plugins.configs.signature"
            end
        }

        -- file search
        use {
            "nvim-lua/plenary.nvim"
        }

        use {
            "nvim-telescope/telescope.nvim",
            cmd = "Telescope",
            requires = {
                {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
                {"nvim-telescope/telescope-ghq.nvim"}
            },
            config = function()
                require "plugins.configs.telescope"
            end
        }

        -- org mode
        use {
            'kristijanhusak/orgmode.nvim',
            after = 'nvim-treesitter',
            config = function()
                require('orgmode').setup{}
            end
        }

        -- git stuff
        use {
            "lewis6991/gitsigns.nvim",
            after = "plenary.nvim",
            config = function()
                require "plugins.configs.gitsigns"
            end
        }

        -- misc plugins
        use {
            "windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = function()
                require "plugins.configs.autopairs"
            end
        }

        use {
            "aserowy/tmux.nvim",
            config = function()
                require "plugins.configs.tmux"
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
                require "plugins.configs.ultest"
            end
        }

        use {
            "iamcco/markdown-preview.nvim",
            run = [[sh -c 'cd app && yarn install']]
        }

        use {"tpope/vim-fugitive"}
        use {"tpope/vim-rhubarb"}
        use {"tpope/vim-surround"} --
        use {"tpope/vim-repeat"}
        use {"lepture/vim-jinja"}  -- flask syntax hilighting
        use {"mattn/emmet-vim"}

        use {
            "numToStr/Comment.nvim",
            config = function()
                require "plugins.configs.comment"
            end
        }

        use {
            "dstein64/vim-startuptime",
            cmd = {
                "StartupTime"
            }
        }

    end
)
