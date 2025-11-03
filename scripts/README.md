
# Users & Onboarding Automation

## Overview
This script automates the process of onboarding new users on a Linux system.  
It handles user creation, SSH key configuration, group assignment, and environment setup — reducing manual work and ensuring consistent, secure account management.

---

## 🎯 Objectives
- Automate the creation of Linux users
- Assign appropriate group memberships (e.g., `sudo`)
- Configure secure SSH key-based authentication
- Set proper file permissions and ownership
- Copy default shell configuration files for a smooth onboarding experience

---

## 🧠 Script Details

### File:
`scripts/create_user.sh`

### Description:
Creates a new Linux user and configures SSH key-based access.

### Usage:
```bash
sudo ./scripts/create_user.sh <username> <path_to_public_key>
```
