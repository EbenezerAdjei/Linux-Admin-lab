
# System Monitoring & Reporting

## Overview
The script (`sys-report.sh`) automates the generation of daily system health reports.  
It collects performance and error data from key Linux utilities and logs the results in `/var/log/`.

The goal is to maintain visibility into system performance, disk usage, and process activity.

---

## Features
- Collects uptime, disk usage, and process statistics
- Logs recent system errors from the journal
- Supports optional email notifications to administrators
- Designed to run automatically via cron
- Easily extendable with tools like **Prometheus**, **Grafana**, or **Sysstat**

---

## Usage
### Run manually:
```bash
sudo /usr/local/bin/sys-report.sh
```
### view the latest report:
```
cat /var/log/sys-report-$(date +%F).log
```
### Schedule with cron:
```
sudo crontab -e
```
### Add:
```
0 7 * * * /usr/local/bin/sys-report.sh >> /var/log/sys-report-cron.log 2>&1
```
### Example Output:
```
==========================================
 System Health Report - linux-lab
==========================================
Date: 2025-11-01T07:00:00+01:00
Uptime: up 3 days, 4 hours, 11 minutes

Disk Usage:
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        30G   10G   20G  33% /

Top 10 Memory-Consuming Processes:
root      1012  5.2  0.8  11320  6204 ?  Ssl  07:00  0:10  /usr/bin/python3
...

Recent System Errors:
Nov 01 06:59:43 kernel: usb 1-1: device descriptor read/64, error -71
...

Report saved to: /var/log/sys-report-2025-11-01.log
```

## Extending to Prometheus & Grafana

You can integrate with modern monitoring stacks:

Prometheus Node Exporter: exposes system metrics on port 9100

Grafana: visualizes those metrics with dashboards

To install Node Exporter:
```
sudo apt install -y prometheus-node-exporter
sudo systemctl enable prometheus-node-exporter
sudo systemctl start prometheus-node-exporter
```
Then view metrics at:\
http://<server_ip>:9100/metrics

### Security Notes
Logs are stored in /var/log/ and should be readable only by administrators.\
Avoid emailing sensitive data (e.g., process lists) without encryption.\
Rotate or archive old reports periodically.

### Learning Outcomes
Through this task, I learned:  
How to collect and interpret system metrics  
How to automate monitoring via cron  
How to use Linux tools (ps, df, journalctl) for reporting  
How to integrate manual monitoring with Prometheus/Grafana

Author: Ebenezer Adjei<br>
Last Updated: November 2025
