
# SSH Hardening Documentation

## Overview
This document describes the SSH hardening steps applied to the Linux Administration Lab server.  
The goal of this configuration is to improve system security by reducing the attack surface and enforcing secure authentication methods.

---

## Steps Performed

### 1. Created a Backup
Before making any changes, a backup of the default SSH configuration was created:
```
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
```

### 2. Disabled Root Login
Modified the SSH configuration to prevent remote logins as the root user:
```
PermitRootLogin no
```
#### Rationale:
The root account has full privileges. Disabling remote root login ensures attackers cannot target it directly. Administrators can log in as a normal user and escalate privileges via sudo when necessary.

### 3. Disabled Password Authentication
Configured SSH to only accept key-based authentication:
```
PasswordAuthentication no
```
#### Rationale:
Disabling password-based logins prevents brute-force attacks. Only users with a valid SSH key can access the server.

### 4. Disabled Empty and Challenge-Response Passwords
```
PermitEmptyPasswords no
ChallengeResponseAuthentication no
```
#### Rationale:
Prevents accounts without passwords or outdated authentication mechanisms from being used.

### 5. Enabled Public Key Authentication
```
PubkeyAuthentication yes
```
#### Rationale:
Allows secure, encrypted key-based login, which is both safer and faster than passwords.

### 6. Limited Allowed SSH Users
```
AllowUsers ebenezer
```
#### Rationale:
Restricts SSH access to only specific users, reducing potential attack targets.

### 7. Restarted the SSH Service
Applied all configuration changes:
```
sudo systemctl restart ssh
```
### Verification
After changes were applied, key-based SSH login was tested:
```
ssh ebenezer@<server-ip>
```
Result: Successful key-based login without password prompt.

### Diff File
Configuration differences between the original and hardened configuration were saved for reference:
```
sudo diff -u /etc/ssh/sshd_config.bak /etc/ssh/sshd_config > hardening/sshd_config.diff
```
### Security Outcome
Root login disabled
Password logins disabled
SSH access restricted to key-authenticated users
Reduced risk of brute-force or credential-based attacks

### Notes
No private keys were uploaded or stored in version control.
All changes can be reverted using the backup file:
```
sudo cp /etc/ssh/sshd_config.backup /etc/ssh/sshd_config
sudo systemctl restart ssh
```
