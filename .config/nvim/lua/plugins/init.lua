local _packer, packer = pcall(require, "plugins.bootstrap")
if not _packer then
	return false
end

return packer.startup(function(use)
	-- Plugin manager
	use({ "wbthomason/packer.nvim", event = "VimEnter" })

	-- Lsp related
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})

	use({
		"williamboman/mason-lspconfig.nvim",
		"jayp0521/mason-null-ls.nvim",
		"jayp0521/mason-nvim-dap.nvim",
		after = "mason.nvim",
	})

	use({
		"neovim/nvim-lspconfig",
		after = "mason.nvim",
		config = function()
			require("plugins.configs.lspconfig")
		end,
	})

	-- UI & Colors, icons
	use({
		"catppuccin/nvim",
		event = "VimEnter",
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
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		after = "nvim-lspconfig",
		branch = "main",
		config = function()
			require("plugins.configs.lspsaga")
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("plugins.configs.others").blankline()
		end,
	})

	use({
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("plugins.configs.others").colorizer()
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		event = "BufWinEnter",
		config = function()
			require("plugins.configs.treesitter")
		end,
	})

	-- Completion engine & Snippets
	use({ "rafamadriz/friendly-snippets", event = "InsertEnter" })
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
	use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
	use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" })
	-- use({ "lukas-reineke/cmp-rg", after = "nvim-cmp" })
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
		config = function()
			require("plugins.configs.dap")
		end,
		requires = { "mfussenegger/nvim-dap-python", "theHamsta/nvim-dap-virtual-text" },
	})

	use({
		"rcarriga/nvim-dap-ui",
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
	-- Formatting
	use({
		"jose-elias-alvarez/null-ls.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("plugins.configs.null_ls")
		end,
	})

	-- Git related
	-- TODO: Remove redundant plugins/unused.
	use({ "dinhhuy258/git.nvim" })
	-- use({ "tpope/vim-rhubarb" })
	-- use({ "tpope/vim-fugitive" })
	use({
		"lewis6991/gitsigns.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("plugins.configs.gitsigns")
		end,
	})
	use({
		"ldelossa/gh.nvim",
		requires = { { "ldelossa/litee.nvim" } },
		config = function()
			require("plugins.configs.gh")
		end,
	})
	use({
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup()
		end,
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		-- keys = { "<leader>gd", "DiffviewOpen", desc = "DiffView" },
	})
	-- Essentials
	use({ "mbbill/undotree" })
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
		"danymat/neogen",
		config = function()
			require("plugins.configs.neogen")
		end,
		requires = "nvim-treesitter/nvim-treesitter",
		tag = "*",
	})

	use({
		"aserowy/tmux.nvim",
		config = function()
			require("plugins.configs.tmux")
		end,
	})
	use({
		"andweeb/presence.nvim",
		event = "BufRead",
		config = function()
			require("plugins.configs.others").presence()
		end,
	})

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("plugins.configs.terminal")
		end,
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
