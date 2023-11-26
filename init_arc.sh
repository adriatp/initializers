#!/bin/bash
# How to run: curl -sL <link raw github> | bash 
# Inspired by: https://disconnected.systems/blog/archlinux-installer/#setting-variables-and-collecting-user-input

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

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

devicelist=$(lsblk -dplnx size -o name,model,size | grep -Ev "boot|rpmb|loop" | awk -F '\t' '{ $2=gensub(/ /, "_", "g", $2); print $1 " " $2 "(" $3 ")"}' | tac)
device=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 1
clear