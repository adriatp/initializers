#!/bin/bash

## Copy all .zip in fonts dir to /home/${USER}/.local/share/fonts
mkdir -p /home/${USER}/.local/share/fonts
cp fonts/* /home/${USER}/.local/share/fonts/

## Decompress .zip in /home/${USER}/.local/share/fonts and delete it
for font_zip in ~/.local/share/fonts/*.zip; do
  dir_name=$(basename "$font_zip" .zip)
  mkdir -p "/home/${USER}/.local/share/fonts/${dir_name}"
  unzip "${font_zip}" -d "/home/${USER}/.local/share/fonts/${dir_name}"
  rm "$font_zip"
done

## Install a font to deal with emojis in terminal
sudo pacman -S noto-fonts-emoji

## Update font cache
fc-cache -f -v