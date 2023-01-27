return {
	-- Lsp related
	{
		"williamboman/mason.nvim",
		config = true,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"jayp0521/mason-null-ls.nvim",
			"jayp0521/mason-nvim-dap.nvim",
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
		end,
	},

	-- UI & Colors, icons
	{
		"catppuccin/nvim",
		event = "VimEnter",
		name = "catppuccin",
		config = function()
			require("plugins.configs.colorscheme")
		end,
	},

	{
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.configs.icons")
		end,
	}, -- NOTE: requires nerd font

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "catppuccin/nvim", "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugins.configs.lualine")
		end,
	},

	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		branch = "main",
		config = function()
			require("plugins.configs.lspsaga")
		end,
		dependencies = { "nvim-lspconfig" },
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("plugins.configs.others").blankline()
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("plugins.configs.others").colorizer()
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufWinEnter",
		config = function()
			require("plugins.configs.treesitter")
		end,
		dependencies = {},
	},

	-- Completion engine & Snippets
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("plugins.configs.cmp")
		end,

		dependencies = {
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"bydlw98/cmp-env",
			"dcampos/cmp-emmet-vim",
			"andersevenrud/cmp-tmux",
			"jcha0713/cmp-tw2css",
			"kdheepak/cmp-latex-symbols",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
	},

	{
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.configs.autopairs")
		end,
	},

	-- File navigation & fuzzy finder
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = "kyazdani42/nvim-web-devicons",
		cmd = "NvimTreeToggle",
		config = function()
			require("plugins.configs.nvimtree")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "nvim-telescope/telescope-ghq.nvim" },
		},
		config = function()
			require("plugins.configs.telescope")
		end,
	},

	-- Debugging
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("plugins.configs.dap")
		end,
		dependencies = { "mfussenegger/nvim-dap-python", "theHamsta/nvim-dap-virtual-text" },
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("plugins.configs.dapui")
		end,
	},

	-- Testing
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
			"haydenmeade/neotest-jest",
		},
		config = function()
			require("plugins.configs.neotest")
		end,
	},
	-- Formatting
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = "nvim-lspconfig",
		config = function()
			require("plugins.configs.null_ls")
		end,
	},

	-- Git related
	-- TODO: Remove redundant plugins/unused.
	{ "dinhhuy258/git.nvim" },
	-- use({ "tpope/vim-rhubarb" })
	-- use({ "tpope/vim-fugitive" })
	{
		"lewis6991/gitsigns.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("plugins.configs.gitsigns")
		end,
	},
	{
		"ldelossa/gh.nvim",
		dependencies = { { "ldelossa/litee.nvim" } },
		config = function()
			require("plugins.configs.gh")
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = true,
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		keys = { { "<leader>gd", "DiffviewOpen", desc = "DiffView" } },
	},
	-- Essentials
	{ "mbbill/undotree" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.configs.comment")
		end,
	},
	{ "andymass/vim-matchup", event = "CursorMoved" },

	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter",
		branch = "main",
		config = true,
	},

	-- Integrations and misc
	{
		"iamcco/markdown-preview.nvim",
		cmd = "MarkdownPreview",
		ft = "markdown",
		build = [[sh -c 'cd app && yarn install']],
	},
	{
		"mattn/emmet-vim",
		ft = { "markdown", "javascript", "html", "css", "reactjavascript" },
		config = function()
			vim.g.user_emmet_mode = "a"
			vim.g.user_emmet_leader_key = ","
		end,
	},

	{
		"danymat/neogen",
		config = function()
			require("plugins.configs.neogen")
		end,
		dependencies = "nvim-treesitter/nvim-treesitter",
		version = "*",
	},

	{
		"aserowy/tmux.nvim",
		config = function()
			require("plugins.configs.tmux")
		end,
	},
	{
		"andweeb/presence.nvim",
		event = "BufRead",
		config = function()
			require("plugins.configs.others").presence()
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("plugins.configs.terminal")
		end,
	},

	{ "dstein64/vim-startuptime", cmd = "StartupTime" },

	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
	},

	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.configs.alpha")
		end,
	},
}
