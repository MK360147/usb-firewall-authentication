#!/bin/bash

# Set your trusted SHA256 hash value here
TRUSTED_HASH="your_hashed_value"

# where the key file is located on the USB
KEY_FILE_NAME=".auth_key"

# Wait a few seconds after USB is inserted
sleep 1

# Check all mounted removable devices
for mount in $(lsblk -rpno NAME,MOUNTPOINT | grep '/media' | awk '{print $1}'); do
    mount_point=$(lsblk -rpno MOUNTPOINT "$mount")
    
    if [ -f "$mount_point/$KEY_FILE_NAME" ]; then
        read_key=$(cat "$mount_point/$KEY_FILE_NAME")
        
        if [ "$read_key" = "$TRUSTED_HASH" ]; then
            echo "USB authorized."
        else
            echo "Unauthorized USB detected. Unmounting..."
            umount "$mount_point"
        fi
    else
        echo "No auth key found. Unmounting..."
        umount "$mount_point"
    fi
done

