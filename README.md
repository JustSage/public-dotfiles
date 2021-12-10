## Sage's public-dotfiles

These are my configurations & tools I run daily on MacOS.

##### <u>Homebrew</u>
  Homebrew is the go-to package manager on MacOS. It makes downloading, installing, and version managing of small cli programs & enterprise applications a breeze.
  Highly recommend it to any MacOS user.
  
  - Install it on your machine:

    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
  - Install packages with `brew install <package-name>`.
  - Install applications with `brew --cask install <application-name>`.
  - Use `brew --help` for more useful commands and info.

---
##### <u>Alfred</u>
  Spotlight on acid. If there's one tool that keeps me in apple's ecosystem, it's Alfred.

  [Alfred app](https://www.alfredapp.com/) - visit their website and try out the free version!
  Alfred offers multiple features such as: 
  - Search & Browse (literally anything, anywhere).
  - Intellisense-like suggestions for search.
  - Automate tasks.
  - Workflows.
  - Snippets.
  - Cliboard history.
  - 1Password integration.
  - System Commands.

  This is an essential productivity tool I have to install right away.


---
##### <u>Git</u>
 Version control for all purposes. Typed notes, software and configurations are all managed via git.
  - Install via `brew install git`
  - [commitizen/cz-cli](https://github.com/commitizen/cz-cli) - commit parser.

---
##### <u>Nvim</u>
  My personal favorite development tool. It's complex yet extensible, featuring exactly what I want from a software environment.
  
  I've been using Vim/Neovim for quite a while and this repo contains my maintained configurations.<br>
  - Install via `brew install nvim` to install the latest stable version.
  - Check out [neovim](https://github.com/neovim/neovim) for updates!
  * [x] All plugins listed below do not require nighly version (development verion):
    - [Packer](https://github.com/wbthomason/packer.nvim) - package manager, has lazyloading functionalities. 

        Unix, Linux installation for packer (essential for all plugins mentioned bellow)

        ```bash
        git clone --depth 1 https://github.com/wbthomason/packer.nvim\
         ~/.local/share/nvim/site/pack/packer/start/packer.nvim
        ```
    * [autopairs](https://github.com/windwp/nvim-autopairs) - pair brackets automatically.<br>
    * [matchup](https://github.com/andymass/vim-matchup) - easy traversal between opening/closing tags of any kind with %.<br>
    * [cmp.nvim](https://github.com/hrsh7th/nvim-cmp) - completion engine of choice.<br>
    * [gitsigns](https://github.com/lewis6991/gitsigns.nvim) - shows git changes in gutter.<br>
    * [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - for language server protocols.<br>
    * [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer) - installing & managing lsp directories.<br>
    * [lspkind](https://github.com/onsails/lspkind-nvim) - provides icons/naming to different kinds of lsp completion sources.<br>
    * [lsp-signature](https://github.com/ray-x/lsp_signature.nvim) - provides signature (function/method) help via lsp.<br>
    * [Luasnip](https://github.com/L3MON4D3/LuaSnip) - snippet engine.<br>
    * [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua) - file explorer in tree view.<br>
    * [org.nvim](https://github.com/nvim-orgmode/orgmode) - orgmode support in neovim.<br>
    * [presence.nvim](https://github.com/andweeb/presence.nvim) - discord neovim presence plugin (cause all should when I'm programming... right?).<br>
    * [nvim-colorizer](https://github.com/norcalli/nvim-colorizer.lua) - provides color highlighting for hex/rgb in text.<br>
    * [galaxyline.nvim](https://github.com/glepnir/galaxyline.nvim) - status line of choice. <u>*no longer maintained*</u>.<br>
    * [telescope.nvim](https://github.com/nvim-telescope) - fuzzy finder over lists. super useful, similar to fzf but far more extensible.<br>
    * [tmux.nvim](https://github.com/aserowy/tmux.nvim) - tmux integration with neovim.<br>
    * [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - provides better syntax highlighting, folding etc.<br>
    * [ultest](https://github.com/rcarriga/vim-ultest) - interactive testing plugin.<br>
    * [base16](https://github.com/NvChad/nvim-base16.lua) - provides highlighting for the colorscheme.<br>
    * [devicons](https://github.com/kyazdani42/nvim-web-devicons) - provides icons to statusline, nvimtree etc. <u>**requires nerd-font**</u>.<br>
    * [comment.nvim](https://github.com/numToStr/Comment.nvim) - commenter of choice. filetype sensitive, can work with multisyntax files (vue/jsx etc).<br>
    * [fugitive](https://github.com/tpope/vim-fugitive) - git integration with vim.
    * [rhubarb](https://github.com/tpope/vim-rhubarb) - github integration with vim.
    * [surround](https://github.com/tpope/vim-surround) - manipulating opening/closing brackets/parens etc.
    * [repeat](https://github.com/tpope/vim-repeat) - repeating `.` motion.
    * [markdown-preview](https://github.com/iamcco/markdown-preview.nvim) - markdown live-server.<br>


  **NOTICE:**<br>
  Check out the provided links before mindlessly using the configurations for further information and any dependencies it may require.
  
  If you are a beginner to Vim I strongly recommend using the built in tutor to get familiar with vim concepts.<br>
  When in nvim use `:tutor`.

  If you wish to understand the configurations or better, modify/extend them, learning basic `lua` is necessary.
  There are many guides out there, but this covers most of what you need: [nvim-lua-guide](https://github.com/nanotee/nvim-lua-guide)

  **Currently looking into nvim-dap for debugging purposes**

---
##### <u>Tmux</u>
  Terminal multiplexer, session manager, a tool any  terminal user needs. Using multiple split panes, windows and sessions in a safe environment (supports session reload).

  Install via `brew install tmux`.<br>
  [Guide for tmux beginners](https://pragmaticpineapple.com/gentle-guide-to-get-started-with-tmux/), while there are plenty of guides out there this seems to be beginner friendly.

  - Tmuxinator
   Co-pilot of tmux, instantiates predefined sessions with splits/panes/windows and more...
   Install via `brew install tmuxinator`.<br>

---
##### <u>Zsh</u>
  My shell of choice, superior to bash due to it's ease of use and extensiblility (IMO).

  **NOTICE:**<br>
  Don't be tempted to install `oh-my-zsh (z shell)`/`oh-my-fish(fish shell)`/`oh-my-posh(power shell)`.<br>
  It is extremely bloated and will most likely hinder your experience.<br>

  Instead you browse their [repository](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins) and scrape for specific plugins that are relevant to your workflow.<br>
  You can copy the `.zsh` files and source them in your `.zshrc` the shell run-command file.
