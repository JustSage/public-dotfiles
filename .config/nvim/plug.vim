if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'tpope/vim-fugitive'                                       
Plug 'tpope/vim-rhubarb'                                          
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'cohama/lexima.vim'                                          
Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope'
Plug 'liuchengxu/vim-which-key'
if has("nvim")
  Plug 'neovim/nvim-lspconfig'                                    
  Plug 'glepnir/lspsaga.nvim'                                    
  Plug 'nvim-treesitter/nvim-treesitter', {'do':':TSUpdate'}    
  Plug 'hrsh7th/nvim-compe'
  Plug 'nvim-telescope/telescope.nvim'                         
  Plug 'hoob3rt/lualine.nvim'                                    
  Plug 'folke/lsp-colors.nvim'                                
  Plug 'kyazdani42/nvim-web-devicons'                            
  Plug 'nvim-lua/popup.nvim'                                     
  Plug 'nvim-lua/plenary.nvim'                                   
  Plug 'hrsh7th/vim-vsnip'
  Plug 'kristijanhusak/vim-dadbod-completion'
  Plug 'sbdchd/neoformat'
endif

Plug 'tpope/vim-dadbod'

" navigating tmux
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'

" extras
Plug 'mattn/emmet-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'kristijanhusak/orgmode.nvim'

call plug#end()
" Plug 'nvim-lua/completion-nvim'                                

