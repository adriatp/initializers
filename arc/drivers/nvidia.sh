#!/bin/bash
# How to run: curl -sL <link raw github> | bash 
# Inspired by: https://github.com/korvahannu/arch-nvidia-drivers-installation-guide/tree/main

# Redirect fails and display error msg 
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# Install driver packages
yay -Sy nvidia nvidia-utils lib32-nvidia nvidia-settings

# Enable DRM kernel mode setting
sudo sed -i '/options/ s/$/ nvidia-drm.modeset=1/' /boot/loader/entries/arch.conf

# Add Early Loading of NVIDIA Modules
sudo sed -i '/MODULES=()/c\MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)' /etc/mkinitcpio.conf

# Turn on Kernel Mode Setting for Nvidia driver
echo "options nvidia-drm modeset=1" > nvidia.conf
sudo mv nvidia.conf /etc/modprobe.d/
sudo chown root:root /etc/modprobe.d/nvidia.conf

# Regenerate initramfs environment
sudo mkinitcpio -P

# Adding the Pacman Hook
sudo mkdir -p /etc/pacman.d/hooks/
sudo cp arc/drivers/hooks/nvidia.hook /etc/pacman.d/hooks/nvidia.hook