local _packer, packer = pcall(require, "plugins.bootstrap")
if not _packer then
    return false
end

return packer.startup(function(use)
    -- Faster startup speeds
    use({ "lewis6991/impatient.nvim" })

    -- Plugin manager
    use({ "wbthomason/packer.nvim", opt = true })

    -- UI & Colors, icons
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            require("plugins.configs.colorscheme")
        end,
    })

    use({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.icons")
        end,
    }) -- NOTE: requires nerd font }

    use({
        "nvim-lualine/lualine.nvim",
        after = "catppuccin",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.lualine")
        end,
    })

    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("plugins.configs.others").blankline()
        end,
    })

    use({
        "norcalli/nvim-colorizer.lua",
        buftype = { "css", "javascript", "reactjavascript", "markdown", "json" },
        event = "BufRead",
        config = function()
            require("plugins.configs.others").colorizer()
        end,
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("plugins.configs.treesitter")
        end,
    })

    use({
        "glepnir/lspsaga.nvim",
        event = "BufRead",
        after = "nvim-lspconfig",
        buftype = { "python", "lua", "javascript", "css", "reactjavascript", "json", "c", "cpp" },
        config = function()
            require("plugins.configs.lspsaga")
        end,
        requires = { {
            "nvim-tree/nvim-web-devicons"
        } }
    })

    use({
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.configs.gitsigns")
        end,
    })

    -- Lsp related
    use({ "folke/neodev.nvim" })

    use({
        "williamboman/mason.nvim",
        requires = {
            "williamboman/mason-lspconfig.nvim",
            "jayp0521/mason-null-ls.nvim",
            "jayp0521/mason-nvim-dap.nvim",
        },
        event = "CursorMoved",
    })

    use({
        "neovim/nvim-lspconfig",
        after = "mason.nvim",
        config = function()
            require("plugins.configs.lspconfig")
        end,
    })

    -- Completion engine & Snippets
    use({
        "hrsh7th/nvim-cmp",
        after = "friendly-snippets",
        config = function()
            require("plugins.configs.cmp")
        end,
    })
    use({
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        after = "nvim-cmp",
    })


    use({
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        config = function()
            require("plugins.configs.autopairs")
        end,
    })
    use({ "rafamadriz/friendly-snippets", event = "InsertEnter" })
    use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
    use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" })
    use({ "bydlw98/cmp-env", after = "nvim-cmp" })
    use({ "dcampos/cmp-emmet-vim", after = "cmp-nvim-lsp" })
    use({ "andersevenrud/cmp-tmux", after = "nvim-cmp" })
    use({ "jcha0713/cmp-tw2css", after = "cmp-nvim-lsp" })
    use({ "kdheepak/cmp-latex-symbols", after = "cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "cmp-nvim-lsp" })

    -- File navigation & fuzzy finder
    use({
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        cmd = "NvimTreeToggle",
        config = function()
            require("plugins.configs.nvimtree")
        end,
    })

    use({
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        requires = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
            { "nvim-telescope/telescope-ghq.nvim" },
        },
        config = function()
            require("plugins.configs.telescope")
        end,
    })

    -- Debugging
    use({
        "mfussenegger/nvim-dap",
        keys = { "n", "<leader>b" },
        config = function()
            require("plugins.configs.dap")
        end,
        requires = { "mfussenegger/nvim-dap-python", "theHamsta/nvim-dap-virtual-text" },
    })

    use({
        "rcarriga/nvim-dap-ui",
        keys = { "n", "<leader>du" },
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("plugins.configs.dapui")
        end,
    })

    -- Testing
    use({
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
            "haydenmeade/neotest-jest",
        },
        config = function()
            require("plugins.configs.neotest")
        end,
    })

    -- Formatting and linting
    use({
        "jose-elias-alvarez/null-ls.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("plugins.configs.null_ls")
        end,
    })

    -- Git related
    use({ "tpope/vim-fugitive" })
    use({
        "sindrets/diffview.nvim",
        config = function()
            require("diffview").setup()
        end,
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    })

    -- Essentials
    use({
        "mbbill/undotree",
        keys = { "n", "<leader>u" },
    })
    use({ "tpope/vim-surround" })
    use({ "tpope/vim-repeat" })
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("plugins.configs.comment")
        end,
    })
    use({ "andymass/vim-matchup", event = "CursorMoved" })

    use({
        "windwp/nvim-ts-autotag",
        after = "nvim-treesitter",
        branch = "main",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    })

    use({
        "danymat/neogen",
        config = function()
            require("plugins.configs.neogen")
        end,
        requires = "nvim-treesitter/nvim-treesitter",
        tag = "*",
    })

    -- Integrations and misc
    use({
        "iamcco/markdown-preview.nvim",
        cmd = "MarkdownPreview",
        ft = "markdown",
        run = [[sh -c 'cd app && yarn install']],
    })

    use({
        "mattn/emmet-vim",
        ft = { "markdown", "javascript", "html", "css", "reactjavascript" },
        config = function()
            vim.g.user_emmet_mode = "a"
            vim.g.user_emmet_leader_key = ","
        end,
    })


    use({
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup()
        end,
    })

    use({
        "andweeb/presence.nvim",
        config = function()
            require("plugins.configs.others").presence()
        end,
    })

    use({
        "akinsho/toggleterm.nvim",
        keys = { { "n", "<C-t>" }, { "n", "<leader>gt" } },
        config = function()
            require("plugins.configs.terminal")
        end,
        tag = "*",
    })

    use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({})
        end,
    })

    use({
        "goolord/alpha-nvim",
        requires = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.configs.alpha")
        end,
    })

end)
