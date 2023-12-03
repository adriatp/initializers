#!/bin/bash
mkdir -p ~/.local/share/fonts
cp fonts/* ~/.local/share/fonts/
for font_zip in ~/.local/share/fonts/*.zip; do
  dir_name=$(basename "$font_zip" .zip)
  unzip "$font_zip" -d "$dir_name"
  rm "$font_zip"
done
fc-cache -f -v