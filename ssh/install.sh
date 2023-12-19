#!/bin/bash

# Read port
echo "> Port: "
read port

# Write port on sshd_config and avoid passwords
echo "Port $port" | sudo tee -a /etc/ssh/sshd_config > /dev/null
echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config > /dev/null

# Copy authorized_keys
mkdir -p ~/.ssh
curl -o ~/.ssh/authorized_keys https://raw.githubusercontent.com/adriatp/initializers/main/ssh/authorized_keys

# Restart sshd
sudo systemctl restart sshd