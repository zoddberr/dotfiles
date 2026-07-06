# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

#export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
#export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export HISTFILE="${XDG_STATE_HOME}"/bash/history

shopt -s histappend

HISTCONTROL=ignoreboth
HISTSIZE=50000
HISTFILESIZE=100000

alias ls='ls --color=auto'
