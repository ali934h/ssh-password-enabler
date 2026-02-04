#!/bin/bash

# Script to enable SSH Password Authentication on DigitalOcean Ubuntu Droplet

echo "=== Starting SSH Password Authentication Setup ==="

# Check root access
if [ "$EUID" -ne 0 ]; then 
  echo "Please run this script with sudo"
  exit 1
fi

# Set root password
echo ""
echo "=== Setting root password ==="
passwd root

# Check if password was set successfully
if [ $? -ne 0 ]; then
  echo "✗ Error setting password"
  exit 1
fi

echo "✓ Root password set successfully"
echo ""

# Modify cloud-init config file
CONFIG_FILE="/etc/ssh/sshd_config.d/50-cloud-init.conf"

if [ -f "$CONFIG_FILE" ]; then
  echo "Modifying settings in $CONFIG_FILE ..."
  sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' "$CONFIG_FILE"
  echo "✓ Cloud-init settings updated"
else
  echo "⚠ File $CONFIG_FILE does not exist"
fi

# Restart SSH service
echo "Restarting SSH service ..."
systemctl restart ssh

# Check service status
if systemctl is-active --quiet ssh; then
  echo "✓ SSH service restarted successfully"
  echo ""
  echo "=== Configuration completed successfully ==="
  echo "You can now SSH with password authentication"
else
  echo "✗ Error restarting SSH service"
  systemctl status ssh
  exit 1
fi