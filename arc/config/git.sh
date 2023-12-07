#!/bin/bash

## Redirect fails and display error msg 
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

## Set git configuration
git_username="adriatp"
read -p "Git email: " git_email
: ${git_email:?"Email cannot be empty"}

## Set user config for git
git config --global user.email $git_email
git config --global user.name $git_username

## Set ssh remote url
git remote set-url origin git@github.com:adriatp/initializers.git

## Maybe install gh (Github client) to upload ssh key to github

## Maybe clone all repositories from github