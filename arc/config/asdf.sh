#!/bin/bash

# Install asdf
yay -Sy asdf-vm
cat << EOF >> ~/.zshrc

# Asdf
source /opt/asdf-vm/asdf.sh
EOF

# # Install ruby

# ## List ruby related plugins
# asdf plugin list all | grep ruby

# ## Install ruby
# asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

# ## List all ruby versions
# asdf list all ruby

# ## Install latest ruby version
# asdf install ruby latest
# adsf global ruby latest

# # Install gems

# ## Install bundler
# echo "gem: --no-document" > ~/.gemrc
# gem search '^bundler$' --all
# gem install bundler latest

# ## Install rails
# gem search '^rails$' --all
# gem install rails -v latest

# ## Install node (with npm)
# asdf plugin list all | grep node
# asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# asdf install nodejs latest
# asdf global nodejs latest

# ## Install yarn
# asdf plugin list all | grep yarn
# asdf plugin add yarn https://github.com/twuni/asdf-yarn.git
# asdf install yarn 1.22.19
# asdf global yarn 1.22.19