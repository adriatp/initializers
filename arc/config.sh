#!/bin/bash

current_dir=$PWD
cd arc/config
chmod +x *.sh
./fonts.sh
./ssh.sh
./zsh.sh
./kitty.sh
./asdf.sh
./hyprland.sh
./firefox.sh
cd $current_dir