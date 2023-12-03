#!/bin/bash
mkdir -p ~/.local/share/fonts
cp fonts/* ~/.local/share/fonts/
for font_zip in ~/.local/share/fonts/*.zip; do
  dir_name=$(basename "$font_zip" .zip)
  mkdir -p "~/.local/share/fonts/${dir_name}"
  unzip "${font_zip}" -d "~/.local/share/fonts/${dir_name}"
  rm "~/.local/share/fonts/$font_zip"
done
fc-cache -f -v