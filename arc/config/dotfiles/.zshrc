
# The following lines were added by compinstall
zstyle :compinstall filename '/home/atp/.zshrc'

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
alias cat=bat --color always

# Lsd
alias l='lsd -lha'
alias lt='lsd --tree'

# Asdf
source /opt/asdf-vm/asdf.sh

# Path
export PATH="/home/atp/.config/lf:$PATH"
