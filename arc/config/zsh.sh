#!/bin/bash

# Install zsh
sudo pacman -Sy zsh --noconfirm

## Install zsh plugins
yay -Sy zsh-syntax-highlighting zsh-autosuggestions zsh-sudo-git
# cat << EOF >> ~/.zshrc

# # ZSH plugins
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
# source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
# EOF

# Install locate
sudo pacman -S locate --noconfirm
sudo updatedb

# Starship
curl -sS https://starship.rs/install.sh | sh
# cat << EOF >> ~/.zshrc

# # Starship
# eval "\$(starship init zsh)"
# EOF

mkdir -p /home/${USER}/.config
cp dotfiles/.config/starship.toml /home/${USER}/.config/starship.toml

# Install neofetch, bat and lsd
sudo pacman -S neofetch bat lsd --noconfirm

## Neofetch
mkdir -p /home/${USER}/.config/neofetch
cp dotfiles/.config/neofetch/* /home/${USER}/.config/neofetch/

## Bat
# cat << EOF >> ~/.zshrc

# # Bat
# alias c=bat
# EOF

## Lsd
# cat << EOF >> ~/.zshrc

# # Lsd
# alias l='lsd -lha'
# alias lt='lsd --tree'
# EOF

cp arc/config/dotfiles/.zshrc ~/.zshrc
cp arc/config/dotfiles/.bashrc ~/.bashrc