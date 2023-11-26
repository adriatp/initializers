#!/bin/bash
# How to run: curl -sL <link raw github> | bash 
# Inspired by: https://github.com/korvahannu/arch-nvidia-drivers-installation-guide/tree/main

# Enable multilib repository
sudo sed -i '/^#\[multilib\]$/s/^#//' /etc/pacman.conf
sudo sed -i '/^\[multilib\]$/{n;s/^#//}' /etc/pacman.conf
yay -Syu

# Install driver packages
yay -S nvidia nvidia-utils lib32-nvidia
yay -S nvidia-settings

# Enable DRM kernel mode setting
sudo sed -i '/options/ s/$/ nvidia-drm.modeset=1/' /boot/loader/entries/arch.conf

# Add Early Loading of NVIDIA Modules
sudo sed -i '/MODULES=()/c\MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)' /etc/mkinitcpio.conf
sudo mkinitcpio -P

# Adding the Pacman Hook
sudo mkdir /etc/pacman.d/hooks
sudo cat << EOF > /etc/pacman.d/hooks/nvidia.hook
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux
# Adjust line(6) above to match your driver, e.g. Target=nvidia-470xx-dkms
# Change line(7) above, if you are not using the regular kernel For example, Target=linux-lts

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'
EOF

# Reboot
rm -rf ~/yay
reboot