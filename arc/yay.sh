#!/bin/bash
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
sudo sed -i '/^#\[multilib\]$/s/^#//' /etc/pacman.conf
sudo sed -i '/^\[multilib\]$/{n;s/^#//}' /etc/pacman.conf
yay -Syu
rm -rf ~/yay