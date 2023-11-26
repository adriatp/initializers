#!/bin/bash
# How to run: curl -sL <link raw github> | bash 
# Inspired by: https://disconnected.systems/blog/archlinux-installer/#setting-variables-and-collecting-user-input

# Setup keyboard layout and timezone
loadkeys es
timedatectl set-timezone Europe/Andorra
timedatectl set-ntp true

# Redirect fails and display error msg 
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# Init pacman keys and download dialog
pacman-key --init
pacman -Sy dialog --noconfirm

#   Get infomation from user
##  Hostname
hostname=$(dialog --stdout --inputbox "Enter hostname" 0 0) || exit 1
clear
: ${hostname:?"hostname cannot be empty"}
##  User
user=$(dialog --stdout --inputbox "Enter admin username" 0 0) || exit 1
clear
: ${user:?"user cannot be empty"}
##  Password
password=$(dialog --stdout --passwordbox "Enter admin password" 0 0) || exit 1
clear
: ${password:?"password cannot be empty"}
password2=$(dialog --stdout --passwordbox "Enter admin password again" 0 0) || exit 1
clear
[[ "$password" == "$password2" ]] || ( echo "Passwords did not match"; exit 1; )

devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
device=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 1
clear

# Set up logging
exec 1> >(tee "stdout.log")
exec 2> >(tee "stderr.log")

# Set up partitions
parted --script "${device}" -- mklabel gpt \
  mkpart ESP fat32 1MiB 129MiB \
  set 1 boot on \
  mkpart primary ext4 129MiB 100%

# Get each partition
part_boot="$(ls ${device}* | grep -E "^${device}p?1$")"
part_root="$(ls ${device}* | grep -E "^${device}p?2$")"

# Clean firm of partitions
wipefs "${part_boot}"
wipefs "${part_root}"

# Format partitons
mkfs.fat -F32 "${part_boot}"
mkfs.ext4 "${part_root}"

# Mount partitions
mount "${part_root}" /mnt
mount --mkdir "${part_boot}" /mnt/boot

# 
pacstrap /mnt base linux linux-firmware nano man-db which sudo

# 
genfstab -U /mnt > /mnt/etc/fstab

# 
arch-chroot /mnt useradd -m atp
arch-chroot /mnt usermod -aG wheel atp
echo "$user:$password" | chpasswd --root /mnt
sed -i '/^# %wheel ALL=(ALL:ALL) ALL$/s/^# //' /mnt/etc/sudoers

# 
ln -sf /mnt/usr/share/zoneinfo/Europe/Andorra /mnt/etc/localtime
arch-chroot /mnt hwclock --systohc
sed -i '/^#ca_ES\.UTF-8 UTF-8/s/^#//' /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo "LANG='ca_ES.UTF-8'" > /mnt/etc/locale.conf
echo "KEYMAP=es" > /mnt/etc/vconsole.conf

cat << EOF >> /mnt/etc/hosts
127.0.0.1 localhost
::1       localhost
127.0.1.1 $hostname.localdomain $hostname
EOF

# 
pacstrap /mnt amd-ucode networkmanager 
arch-chroot /mnt systemctl enable NetworkManager

# 
umount /mnt/boot
mount -o uid=0,gid=0,fmask=0077,dmask=0077 /dev/sda1 /mnt/boot
genfstab -U /mnt > /mnt/etc/fstab
arch-chroot /mnt bootctl --path=/boot install --no-variables

# 
cat << EOF > /mnt/boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options root=/dev/sda2 rw
EOF
echo "default arch-*" > /boot/loader/loader.conf

# 
umount -a
reboot