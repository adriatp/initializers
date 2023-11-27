#!/bin/bash

# Redirect fails and display error msg 
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# Install yay
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
sudo sed -i '/^#\[multilib\]$/s/^#//' /etc/pacman.conf
sudo sed -i '/^\[multilib\]$/{n;s/^#//}' /etc/pacman.conf
yay -Syu
rm -rf ~/yay