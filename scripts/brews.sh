# brew is a package manager for macos. using brew i'm able to keep
# my applications up to date, install them seamlessly with alfred
# workflows or through the cli. it's a must tool for any mac user
# even normies :D!

#################################################################
#                         BREWS                                 #
#################################################################

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# better prompt for cli
brew install starship
# zsh, auto-suggestions and syntax-highlighting
brew install zsh
brew install zsh-auto-suggestions
brew install zsh-syntax-highlighting
# better ls
brew install exa
# better directory navigation
brew install z
# git integration
brew install git
# terminal multiplexer & tmux template manager
brew install tmux tmuxinator
# fuzzy search everything
brew install fzf
# git repo manager
brew install ghq
# an interactive process viewer
brew install htop
# neovim, tree-sitter and luajit (head) - my editor of choice
brew install --HEAD neovim tree-sitter luajit
# recommeneded way to install NVM - node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
brew install node # base install of node
# yarn is used for nvim plugin dependencies...
brew install yarn

#################################################################
