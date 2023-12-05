#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Starship
eval "$(starship init bash)"

# Lsd
alias l='lsd -lha'
alias lt='lsd --tree'

# Bat
alias c=bat

# Asdf
source /opt/asdf-vm/asdf.sh
