### PATHS ###
export TERM='xterm-256color'
export EDITOR='nvim'
export BROWSER='firefox'
### HISTORY MANAGEMENT ###
export KEYTIMEOUT=5

HISTTIMEFORMAT="%Y-%m-%d %T "
# HISTTIMEFORMAT="[%F %T] "
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS

# startup actions
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t dev || tmux new -c $WORKSPACE -s dev
    tmux new -c $XDG_CONFIG_HOME -d -s dotfiles
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

source $ZDOTDIR/functions.zsh
source $ZDOTDIR/plugins.zsh
source $ZDOTDIR/alias.zsh
source $NVM_DIR/script.zsh
source $HOME/.zshenv
