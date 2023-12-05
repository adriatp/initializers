#!/bin/bash

# Starship
curl -sS https://starship.rs/install.sh | sh
cat << EOF >> ~/.bashrc

# Starship
eval "$(starship init bash)"
EOF
mkdir -p /home/${USER}/.config
cp dotfiles/.config/starship.toml /home/${USER}/.config/starship.toml
source ~/.bashrc

# Install neofetch, bat and lsd
sudo pacman -S neofetch bat lsd --noconfirm

## Neofetch
mkdir -p /home/${USER}/.config/neofetch
cp dotfiles/.config/neofetch/* /home/${USER}/.config/neofetch/

# Bat
cat << EOF >> ~/.bashrc

# Bat
alias c=bat
EOF
source ~/.bashrc

# Lsd
cat << EOF >> ~/.bashrc

# Lsd
alias l='lsd -lha'
alias lt='lsd --tree'
EOF
source ~/.bashrc
