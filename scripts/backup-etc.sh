
#!/usr/bin/env sh

# Check if running under bash for pipefail support
if [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
else
  set -eu
fi

DST_DIR="/var/backups/etc"
mkdir -p "$DST_DIR"
TIMESTAMP=$(date +%F_%H%M)
ARCHIVE="$DST_DIR/etc_backup_$TIMESTAMP.tar.gz"

# exclude sensitive private files if needed
tar -czf "$ARCHIVE" \
  --exclude=/etc/ssl/private \
  --exclude=/etc/ssh/ssh_host_*_key \
  /etc

# keep latest 7 backups (delete older ones)
ls -1t "$DST_DIR"/etc_backup_*.tar.gz | tail -n +8 | xargs -r rm --

echo "$(date -Iseconds) Backup saved to $ARCHIVE"
