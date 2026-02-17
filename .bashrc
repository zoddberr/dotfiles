#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# everyone likes colors!
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color'

# nnn stuff
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_PLUG='v:preview-tui;f:fzopen'
export NNN_OPENER='/home/zod/.config/nnn/plugins/nuke'

alias n='nnn -c'

# general aliases
alias sdn='sudo poweroff'
