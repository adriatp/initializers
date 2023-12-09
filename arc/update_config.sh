#!/bin/bash

# Copy files
cp -f /home/$USER/.zshrc arc/config/dotfiles/.zshrc
cp -f /home/$USER/.bashrc arc/config/dotfiles/.bashrc
cp -f /home/$USER/.config/starship.toml arc/config/dotfiles/starship.toml

# Copy dirs
cp -rf /home/$USER/.config/hypr arc/config/dotfiles/.config/hypr
cp -rf /home/$USER/.config/kitty arc/config/dotfiles/.config/kitty
cp -rf /home/$USER/.config/lf arc/config/dotfiles/.config/lf
cp -rf /home/$USER/.config/neofetch arc/config/dotfiles/.config/neofetch
cp -rf /home/$USER/.config/waybar arc/config/dotfiles/.config/waybar
cp -rf /home/$USER/.config/wofi arc/config/dotfiles/.config/wofi
