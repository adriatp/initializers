#!/bin/bash

current_dir=$PWD
cd arc/config
chmod +x *.sh
./fonts.sh
./kitty.sh
./asdf.sh
./shell_utils.sh
./hyprland.sh
cd $current_dir