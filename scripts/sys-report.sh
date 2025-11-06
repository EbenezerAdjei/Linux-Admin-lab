```
#!/usr/bin/env sh
# Portable user creation script for Linux systems (works with sh, bash, zsh)

# Check if running under bash for pipefail support
if [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
else
  set -eu
fi


OUT="/var/log/sys-report-$(date +%F).log"

{
  echo "=========================================="
  echo " System Health Report - $(hostname)"
  echo "=========================================="
  echo "Date: $(date -Iseconds)"
  echo "Uptime: $(uptime -p)"
  echo

  echo "Disk Usage:"
  df -h
  echo

  echo "Top 10 Memory-Consuming Processes:"
  ps aux --sort=-%mem | head -n 10
  echo

  echo "Top 10 CPU-Consuming Processes:"
  ps aux --sort=-%cpu | head -n 10
  echo

  echo "Recent System Errors (journalctl):"
  journalctl -p err -n 20 --no-pager || true
  echo

  echo "=========================================="
  echo "End of Report"
  echo "=========================================="
} > "$OUT"

# Optional: email the report
# mail -s "Daily System Report - $(hostname)" admin@example.com < "$OUT"

echo "System report saved to $OUT"
```
