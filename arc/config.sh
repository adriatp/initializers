#!/bin/bash

current_dir=$PWD
cd arc/config
chmod +x *.sh
./fonts.sh
./zsh.sh
./kitty.sh
./asdf.sh
./hyprland.sh
cd $current_dir