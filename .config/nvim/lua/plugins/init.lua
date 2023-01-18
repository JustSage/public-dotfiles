local present, _ = pcall(require, "plugins.packerinit")
local packer

if present then
	packer = require("packer")
else
	return false
end

local use = packer.use

return packer.startup(function()
	-- Plugin manager
	use({ "wbthomason/packer.nvim", event = "VimEnter" })

	-- UI & Colors, icons
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("plugins.configs.colorscheme")
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
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.configs.icons")
		end,
	}) -- NOTE: requires nerd font }
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
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
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("plugins.configs.treesitter")
		end,
	})

	-- Lsp related
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})
	use({ "williamboman/mason-lspconfig.nvim", after = "mason.nvim" })
	use({
		"neovim/nvim-lspconfig",
		after = "mason.nvim",
		config = function()
			require("plugins.configs.lspconfig")
		end,
	})
	use({ "jayp0521/mason-null-ls.nvim", after = "mason.nvim" })
	use({
		"jayp0521/mason-nvim-dap.nvim",
		after = "mason.nvim",
		config = function()
			require("mason-nvim-dap").setup()
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
		config = function()
			require("plugins.configs.luasnip")
		end,
	})
	use({ "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" })
	use({ "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" })
	use({ "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-path", after = "cmp-buffer" })
	use({ "hrsh7th/cmp-cmdline", after = "cmp-buffer" })
	use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "cmp-nvim-lsp" })
	use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" })
	use({ "kdheepak/cmp-latex-symbols", after = "nvim-cmp" })
	use({ "jcha0713/cmp-tw2css", after = "nvim-cmp" })
	use({ "andersevenrud/cmp-tmux", after = "nvim-cmp" })
	-- use({ "dcampos/cmp-emmet-vim" })

	use({
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		after = "nvim-lspconfig",
		branch = "main",
		config = function()
			require("plugins.configs.lspsaga")
		end,
	})
	-- File navigation & fuzzy finder
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		cmd = "NvimTreeToggle",
		config = function()
			require("plugins.configs.nvimtree")
		end,
	})
	use({ "nvim-lua/plenary.nvim" }) -- dependency for telescope & gitsigns
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
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
	use({ "tpope/vim-fugitive" })
	use({ "tpope/vim-rhubarb" })
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.configs.gitsigns")
		end,
	})
	use({ "dinhhuy258/git.nvim" })

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
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = function()
			require("plugins.configs.autopairs")
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		after = "nvim-treesitter",
		branch = "main",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})

	-- Integrations and misc
	use({ "iamcco/markdown-preview.nvim", run = [[sh -c 'cd app && yarn install']] })
	use({
		"mattn/emmet-vim",
		config = function()
			vim.g.user_emmet_mode = "a"
			vim.g.user_emmet_leader_key = ","
		end,
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
		event = "BufRead",
		config = function()
			require("plugins.configs.terminal")
		end,
	})
	use({ "dstein64/vim-startuptime", cmd = { "StartupTime" } })

	use({
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({})
		end,
		requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	})
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	})
end)
