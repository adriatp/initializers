#!/bin/bash

yay -Syu
yay -Sy hyprland qt5-wayland qt5ct libva libva-nvidia-driver-gi waybar wofi hyprpaper
mkdir -p /home/${USER}/.config/hypr
cp dotfiles/.config/hypr/hyprland.conf /home/${USER}/.config/hypr/hyprland.conf
mkdir -p /home/${USER}/.config/waybar
cp dotfiles/.config/waybar/* /home/${USER}/.config/waybar/
mkdir -p /home/${USER}/.config/wofi
cp dotfiles/.config/wofi/* /home/${USER}/.config/wofi/