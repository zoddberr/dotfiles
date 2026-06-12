# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=50000
HISTFILESIZE=100000

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

alias ls='ls --color=auto'
