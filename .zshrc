# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# env vars
export EDITOR="nvim"
export TERMINAL="st"
export READER="zathura"
export BROWSER="firefox"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.share"

# colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color'

# nnn stuff
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_PLUG='v:preview-tui;f:fzopen'
export NNN_OPENER='/home/zod/.config/nnn/plugins/nuke'
alias nnn='nnn -c'

# general aliases
alias sdn='sudo poweroff'

alias e='$EDITOR'
alias v='$EDITOR'

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
