#!/bin/bash

if [ -d "$HOME/.cfg" ]; then
	var MY_CWD = "$(pwd)"
	cd "$HOME/.cfg" || return
	git pull
	cd "$MY_CWD" || return
else
	git clone --bare https://github.com/JustSage/public-dotfiles.git "$HOME/.cfg"
fi

function config {
	/usr/bin/git --git-dir="$HOME/.cfg/" --work-tree="$HOME" "$@"
}

echo "Checking out config files..."
config checkout

if mycmd; then
	echo "Checked out config."
else
	echo "Backing up pre-existing dot files."
	FILES=$(config checkout 2>&1 | grep -E "\s+\." | awk "{'print $1'}")
	for file in $FILES; do
		echo "Backing up $file"
		mkdir -p ".config-backup/$(dirname "$file")"
		mv "$file" ".config-backup/$file"
	done
	echo "Finished Backup"
fi

echo "Verifying checkout..."
config checkout

config config status.showUntrackedFiles no

echo "Homebrew..."
brew --version || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Zsh Shell..."
zsh --version || brew install zsh

echo "Installing Dependencies..."
brew install --cask \
	1password \
	aircall \
	alfred \
	bartender \
	basictex \
	betterdiscord-installer \
	cheatsheet \
	drawio \
	endurance \
	fantastical \
	figma \
	font-fira-code \
	font-hack-nerd-font \
	font-jetbrains-mono-nerd-font \
	font-source-code-pro \
	google-chrome \
	hazel \
	intellij-idea \
	iterm2 \
	numi \
	parallels \
	slack \
	spotify \
	vlc \
	whatsapp \
	zoom

brew install \
	ack \
	apr \
	apr-util \
	autoconf \
	brotli \
	c-ares \
	ca-certificates \
	cairo \
	ccls \
	clang-format \
	cowsay \
	curl \
	direnv \
	emscripten \
	exa \
	fd \
	fontconfig \
	fortune \
	freetype \
	fzf \
	gdb \
	gdbm \
	gettext \
	gh \
	ghq \
	giflib \
	git \
	glib \
	gmp \
	gradle \
	graphite2 \
	harfbuzz \
	htop \
	hub \
	icu4c \
	ipython \
	jemalloc \
	jpeg-turbo \
	jq \
	krb5 \
	lazygit \
	libev \
	libevent \
	libidn2 \
	libnghttp2 \
	libpng \
	libpthread-stubs \
	libsodium \
	libssh2 \
	libtermkey \
	libtiff \
	libunistring \
	libuv \
	libvterm \
	libx11 \
	libxau \
	libxcb \
	libxdmcp \
	libxext \
	libxrender \
	libyaml \
	little-cms2 \
	llvm \
	lolcat \
	lua-language-server \
	luajit \
	luv \
	lz4 \
	lzo \
	m4 \
	maven \
	mermaid-cli \
	mongocli \
	mpdecimal \
	msgpack \
	ncurses \
	neofetch \
	neovim \
	nghttp2 \
	node \
	oniguruma \
	openjdk \
	openjdk@17 \
	openldap \
	openssl@1.1 \
	openssl@3 \
	pandoc \
	pcre \
	pcre2 \
	peco \
	pixman \
	pkg-config \
	postgresql \
	postgresql@14 \
	pyenv \
	python@3.10 \
	python@3.11 \
	python@3.9 \
	readline \
	ripgrep \
	rtmpdump \
	ruby \
	rust \
	screenfetch \
	screenresolution \
	six \
	sqlite \
	subversion \
	switchaudio-osx \
	tealdeer \
	the_silver_searcher \
	tig \
	tmux \
	tmuxinator \
	tree-sitter \
	unibilium \
	utf8proc \
	wget \
	xorgproto \
	xz \
	yarn \
	yuicompressor \
	z \
	zeromq \
	zlib \
	zsh-autosuggestions \
	zsh-syntax-highlighting \
	zstd

echo "Installing Starship..."
brew install starship

echo "Install nvim Packer..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "Installing Vim Plugins..."
rm -r ~/.config/nvim/plugin/packer_compiled.lua
nvim -u ~/.config/nvim/lua/plugins/init.lua --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "Done!"
