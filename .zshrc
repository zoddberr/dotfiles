# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Gentoo-style colored man pages
#export LESS_TERMCAP_mb=$'\E[01;31m'      # Red: Begin blinking
#export LESS_TERMCAP_md=$'\E[01;32m'      # Green: Begin bold (headers)
#export LESS_TERMCAP_me=$'\E[0m'          # End mode
#export LESS_TERMCAP_se=$'\E[0m'          # End standout-mode
#export LESS_TERMCAP_so=$'\E[01;44;33m'   # Yellow on Blue: Begin standout (bottom bar)
#export LESS_TERMCAP_ue=$'\E[0m'          # End underline
#export LESS_TERMCAP_us=$'\E[01;33m'      # Yellow: Begin underline (flags/args)
#export GROFF_NO_SGR=1

export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33;44m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;1;32m'
export LESS_TERMCAP_mr=$'\e[7m'
export LESS_TERMCAP_mh=$'\e[2m'
export LESS_TERMCAP_ZN=$'\e[74m'
export LESS_TERMCAP_ZV=$'\e[75m'
export LESS_TERMCAP_ZO=$'\e[73m'
export LESS_TERMCAP_ZW=$'\e[75m'
#export MANPAGER='less'
export GROFF_NO_SGR=1

# env vars
export EDITOR="nvim"
export TERMINAL="kitty"
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
alias n='nnn -c'

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
