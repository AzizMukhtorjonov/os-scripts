#!/bin/bash

# Check inputs
if [ -z "$USER_NAME" ] || [ -z "$GROUP_NAMES" ]; then
    echo "Usage: USER_NAME=<username> GROUP_NAMES=<group1,group2,group3> $0"
    exit 1
fi

# Split group names into array
IFS=',' read -r -a GROUP_ARRAY <<< "$GROUP_NAMES"

# Add user to groups
for GROUP_NAME in "${GROUP_ARRAY[@]}"; do
    if grep -q "$GROUP_NAME" /etc/group; then
        sudo usermod -aG $GROUP_NAME $USER_NAME
    else
        echo "Group $GROUP_NAME doesn't exist."
    fi
done
