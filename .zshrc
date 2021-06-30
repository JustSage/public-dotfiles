### PATHS ###
export PATH="/usr/local/bin/conda/bin:$PATH"
export TERM="xterm-256color"
export EDITOR='nvim'

### HISTORY MANAGEMENT ###
export HISTTIMEFORMAT="[%F %T] "
HISTSIZE=1000000000
SAVEHIST=1000000000
HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS

### ALIASES ###
alias l='exa -1 --icons'                                                        # short list
alias ls='exa -la --icons'                                                      # list with dotfiles
alias ll='exa -lbaF --git --icons'                                              # list, dotfiles, size, type, git
alias llm='exa -lbGd --git --icons --sort=modified'                             # long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --icons --color-scale'   # all list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --icons --color-scale'  # all + extended list
alias lt='exa --tree --level=2 --icons'                                         # tree view
alias ide="$HOME/dev/scripts/ide.sh"
alias sc="source $HOME/.zshrc"
alias mux="tmuxinator"
alias config='/usr/bin/git --git-dir=/Users/sagebaram/.cfg/ --work-tree=/Users/sagebaram'

source $HOME/.config/zsh/plugins.zsh
source $HOME/.conda/zsh_settings.zsh
source $HOME/.nvm/script.zsh

