#!/bin/bash

repo_dir="arc/config/dotfiles/"
os_dir="/home/${USER}/"
find "$repo_dir" -type f | while read -r file; do
  relative_path="${file#$repo_dir/}"
  os_path="${os_dir}${relative_path}"
  repo_path="${repo_dir}${relative_path}"
  if [ -e "$os_path"]; then
    cp $os_path $repo_path
  fi
done