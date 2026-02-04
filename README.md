# SSH Password Enabler

Simple script to enable SSH password authentication on DigitalOcean Ubuntu Droplets.

## Problem

DigitalOcean Droplets created with SSH keys only allow public key authentication by default. This script enables password-based SSH authentication.

## What it does

1. Sets root password
2. Modifies `/etc/ssh/sshd_config.d/50-cloud-init.conf` to enable password authentication
3. Restarts SSH service

## Installation

Run this command on your Ubuntu Droplet:

```bash
bash <(curl -Ls https://raw.githubusercontent.com/ali934h/ssh-password-enabler/main/install.sh)
```

Or with sudo:

```bash
sudo bash <(curl -Ls https://raw.githubusercontent.com/ali934h/ssh-password-enabler/main/install.sh)
```

## Usage

1. SSH into your Droplet using your existing SSH key
2. Run the installation command above
3. Enter your desired root password when prompted
4. Wait for the script to complete
5. Test SSH connection with password from another terminal

## Security Note

⚠️ Enabling password authentication reduces server security as it makes your server vulnerable to brute-force attacks. Consider:

- Using strong passwords
- Installing fail2ban
- Keeping SSH key authentication enabled alongside password auth
- Using firewall rules to restrict SSH access

## Requirements

- Ubuntu on DigitalOcean Droplet
- Root or sudo access
- Existing SSH key access to run the script

## License

MIT