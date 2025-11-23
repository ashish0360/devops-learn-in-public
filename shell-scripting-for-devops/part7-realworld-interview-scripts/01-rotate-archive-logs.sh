#!/bin/bash
# Rotate & archive logs: compress yesterday's logs and keep last 7 archives.
# Run from cron daily (e.g. 0 1 * * * /path/01-rotate-archive-logs.sh)
set -euo pipefail

LOG_DIR="/var/log/nginx"
ARCHIVE_DIR="/var/backups/nginx-logs"
mkdir -p "$ARCHIVE_DIR"

# timestamp for filename
ts=$(date +%F)
archive_name="$ARCHIVE_DIR/nginx-logs-$ts.tar.gz"

# create an archive of current logs
tar -czf "$archive_name" -C "$LOG_DIR" .
echo "Archived logs to $archive_name"

# keep only last 7 archives
ls -1t "$ARCHIVE_DIR"/*.tar.gz 2>/dev/null | tail -n +8 | xargs -r rm --
echo "Pruned older archives (kept last 7)"
