
# The following lines were added by compinstall
zstyle :compinstall filename '/home/atp/.zshrc'

# LF
fpath=(/home/atp/.config/lf/ $fpath)
LFCD="/home/atp/.config/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# End of lines configured by zsh-newuser-install

# ZSH plugins
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Starship
eval "$(starship init zsh)"

# Bat
alias c=cat
alias cat=bat

# Lsd
alias l=ls
alias ls='lsd -lha'
alias lt='lsd --tree'

# Asdf
source /opt/asdf-vm/asdf.sh
