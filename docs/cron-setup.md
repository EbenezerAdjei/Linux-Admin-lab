
# 🕒 Cron Job Setup for Automated Backups

## Overview
This document explains how the automated backup script (`backup-etc.sh`) is scheduled and managed using `cron`.  
The script creates compressed archives of `/etc` daily and retains the latest 7 backups.

---

## Cron Configuration

To schedule the backup, edit the root user’s crontab:
```bash
sudo crontab -e
```
Add the following line:
```
15 3 * * * /usr/local/bin/backup-etc.sh >> /var/log/backup-etc.log 2>&1
```
The job runs daily at 03:15 AM, writing logs to /var/log/backup-etc.log.

### Testing the Script
To verify it works correctly:
```
sudo /usr/local/bin/backup-etc.sh
ls -lh /var/backups/etc
```

Expected result:

A new file /var/backups/etc/etc_backup_<timestamp>.tar.gz \
A log entry confirming the backup

### Security Notes
The script excludes sensitive private keys:
```
/etc/ssl/private
/etc/ssh/ssh_host_*_key
```
Store backups in a secure location (/var/backups is root-owned).\
Make sure log files (/var/log/backup-etc.log) are not world-readable.\
Consider syncing backups to a remote server using rsync or cloud storage for redundancy.

### Future Improvements
Add email notifications for backup success/failure.  
Encrypt backups before transfer using GPG.  
Integrate with centralized monitoring or backup systems.  

Author: Ebenezer Adjei<br>
Last Updated: November 2025

---
