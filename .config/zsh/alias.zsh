### ALIASES ###
alias g='git'
alias v='vim'

alias l='exa -F --oneline --icons'                                                        # short list
alias ls='exa -lF --no-time --no-user --no-filesize --icons --git'
alias ll='exa -laF --no-time --no-user --no-filesize --icons --git --group-directories-first'
alias la='exa -laF --no-time --no-user --no-filesize --icons --git'
alias lm='exa -lhamF --time-style=long-iso --no-user --no-filesize --icons --git'
alias lt='exa --tree --level=2 --icons'                                         # tree view

alias ide="$HOME/dev/scripts/ide.sh"
alias sc="source $ZDOTDIR/.zshrc"
alias es="vim $ZDOTDIR/.zshrc"
alias mux="tmuxinator"
alias fig='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'

