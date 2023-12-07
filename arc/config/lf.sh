#!/bin/bash

sudo pacman -Sy lf --noconfirm
mkdir -p /home/${USER}/.config/lf/
cp dotfiles/.config/lf/* /home/${USER}/.config/lf/