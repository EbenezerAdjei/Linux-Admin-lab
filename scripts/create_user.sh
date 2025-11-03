```
#!/usr/bin/env sh
# Portable user creation script for Linux systems (works with sh, bash, zsh)

# Check if running under bash for pipefail support
if [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
else
  set -eu
fi

# Check argument count
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <username> <public_key_file>"
  exit 1
fi

USER="$1"
PUBKEYFILE="$2"

# Ensure public key file exists
if [ ! -f "$PUBKEYFILE" ]; then
  echo "Error: public key file '$PUBKEYFILE' not found."
  exit 1
fi

# Create the user and home directory
if id "$USER" >/dev/null 2>&1; then
  echo "User '$USER' already exists."
else
  sudo useradd -m -s /bin/bash "$USER"
  echo "User '$USER' created."
fi

# Add user to sudo group if it exists
if getent group sudo >/dev/null; then
  sudo usermod -aG "$USER"
fi

# Configure SSH directory
sudo mkdir -p /home/"$USER"/.ssh
sudo chmod 700 /home/"$USER"/.ssh
sudo cp "$PUBKEYFILE" /home/"$USER"/.ssh/authorized_keys
sudo chown -R "$USER":"$USER" /home/"$USER"/.ssh
sudo chmod 600 /home/"$USER"/.ssh/authorized_keys

# Copy default shell config if available
if [ -f /etc/skel/.bashrc ]; then
  sudo cp /etc/skel/.bashrc /home/"$USER"/
  sudo chown "$USER":"$USER" /home/"$USER"/.bashrc
fi

echo "User '$USER' created and SSH key added successfully!"
```
