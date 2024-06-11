#!/bin/bash

# Check for inputs
if [ -z "$USER_NAME" ] || [ -z "$PUBLIC_KEY" ]; then
    echo "Usage: USER_NAME=<username> PUBLIC_KEY=<public_key> $0"
    exit 1
fi

# Check for user existence. If true - exit
if id "$USER_NAME" &>/dev/null; then
    echo "User $USER_NAME already exists."
    exit 1
fi

# Create user
sudo useradd -m $USER_NAME

# Create user's directory in /home
# There is a way to change directory but it might cost you time and anxiety
sudo mkdir -p /home/$USER_NAME/.ssh

# Add user's ssh
echo $PUBLIC_KEY | sudo tee -a /home/$USER_NAME/.ssh/authorized_keys > /dev/null

# Change access to user's directory
sudo chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/.ssh
sudo chmod 700 /home/$USER_NAME/.ssh
sudo chmod 600 /home/$USER_NAME/.ssh/authorized_keys
