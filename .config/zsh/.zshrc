### PATHS ###
export TERM='xterm-256color'
export EDITOR='nvim'
export BROWSER='firefox'
### HISTORY MANAGEMENT ###
export HISTTIMEFORMAT="[%F %T] "
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS

# startup actions
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t Dev || tmux new -s Dev
fi

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
alias fig='/usr/bin/git --git-dir=/Users/sagebaram/.cfg/ --work-tree=/Users/sagebaram'
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'

source $ZDOTDIR/plugins.zsh
source $NVM_DIR/script.zsh
source $HOME/.zshenv

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

