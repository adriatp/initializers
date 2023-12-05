#!/bin/bash

# Redirect fails and display error msg 
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# Update pacman
sudo pacman -Syu

# Install missing firmware from pacman
sudo pacman -Sy linux-firmware-qlogic

# Install yay
current_dir=$PWD
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
sudo sed -i '/^#\[multilib\]$/s/^#//' /etc/pacman.conf
sudo sed -i '/^\[multilib\]$/{n;s/^#//}' /etc/pacman.conf
cd $current_dir
rm -rf ~/yay

# Update yay
yay -Syu

# Install missing firmware from yay
yay -Sy ast-firmware upd72020x-fw aic94xx-firware wd719x-firmware

# Reload initial ramdisk environment
sudo mkinitcpio -P

# Install nvidia drivers
chmod 744 arc/drivers/nvidia.sh
./arc/drivers/nvidia.sh