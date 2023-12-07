#!/bin/bash

sudo pacman -Sy kitty --noconfirm
mkdir -p /home/${USER}/.config/kitty/
cp dotfiles/.config/kitty/* /home/${USER}/.config/kitty/
