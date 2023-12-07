#!/bin/bash

# Install openssh
sudo pacman -S openssh --noconfirm

# Generate key
mkdir -p ~/.ssh
ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519
