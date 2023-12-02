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

#   Get infomation from user
##  Hostname
read -p "hostname: " hostname
: ${hostname:?"hostname cannot be empty"}
##  User
read -p "user: " user
: ${user:?"user cannot be empty"}
##  Password
read -sp "password: " password
echo ""
: ${password:?"password cannot be empty"}
read -sp "password: " password2
echo ""
[[ "$password" == "$password2" ]] || ( echo "passwords did not match"; exit 1; )
##  Device
read -p "device: " device
: ${device:?"device cannot be empty"}

# Set up logging
exec 1> >(tee "stdout.log")
exec 2> >(tee "stderr.log")

# Set up partitions
parted --script "${device}" -- mklabel gpt \
  mkpart ESP fat32 1MiB 513MiB \
  set 1 boot on \
  mkpart primary ext4 513MiB 100%

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

# Install linux and useful packages
pacstrap /mnt base linux linux-firmware nano man-db which sudo wget unzip sudo pacman pipewire pipewire-{alsa,jack,pulse} gst-plugin-pipewire libpulse wireplumber amd-ucode networkmanager base-devel linux-headers git --needed

# Generate partition desciption file
genfstab -U /mnt > /mnt/etc/fstab

# Create user and add in sudoers file
arch-chroot /mnt useradd -m "$user"
arch-chroot /mnt usermod -aG wheel "$user"
echo "$user:$password" | chpasswd --root /mnt
sed -i '/^# %wheel ALL=(ALL:ALL) ALL$/s/^# //' /mnt/etc/sudoers

# Update localtime and keyboard 
ln -sf /mnt/usr/share/zoneinfo/Europe/Andorra /mnt/etc/localtime
arch-chroot /mnt hwclock --systohc
sed -i '/^#ca_ES\.UTF-8 UTF-8/s/^#//' /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo "LANG='ca_ES.UTF-8'" > /mnt/etc/locale.conf
echo "KEYMAP=es" > /mnt/etc/vconsole.conf

# Set hostname
echo "$hostname" > /mnt/etc/hostname
cat << EOF >> /mnt/etc/hosts
127.0.0.1 localhost
::1       localhost
127.0.1.1 $hostname.localdomain $hostname
EOF

# Startup with net and audio
arch-chroot /mnt systemctl enable NetworkManager
su - $user -c systemctl enable --user pipewire-pulse.service

# Update fstab with secured mask
umount /mnt/boot
mount -o uid=0,gid=0,fmask=0077,dmask=0077 /dev/sda1 /mnt/boot
genfstab -U /mnt > /mnt/etc/fstab
arch-chroot /mnt bootctl --path=/boot install --no-variables

# Update systemd-boot configuration
cat << EOF > /mnt/boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options root=/dev/sda2 rw
EOF
echo "default arch-*" > /mnt/boot/loader/loader.conf

# Umount disks and reboot
umount -a || true
reboot