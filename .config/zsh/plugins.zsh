# syntax highlighting and autosuggestions
source /usr/local/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# vi mode
source $ZDOTDIR/vi-mode.zsh

# activating z
. /usr/local/etc/profile.d/z.sh

# fzf loader
[ -f $XDG_CONFIG_HOME/zsh/.fzf.zsh ] && source $XDG_CONFIG_HOME/zsh/.fzf.zsh 

# direnv for env variables on root
eval "$(direnv hook zsh)"

# prompt
eval "$(starship init zsh)"


