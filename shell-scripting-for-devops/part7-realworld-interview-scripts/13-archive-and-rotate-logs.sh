#!/bin/bash
# Archive a specific log directory, rotate compressed archives, and remove old archives.
# Usage: ./13-archive-and-rotate-logs.sh /var/log/myapp 14
set -euo pipefail

TARGET="${1:-/var/log/myapp}"
RETENTION_DAYS="${2:-14}"
ARCH_DIR="/var/backups/myapp-logs"
mkdir -p "$ARCH_DIR"

ts=$(date +%F-%H%M)
tar -czf "$ARCH_DIR/myapp-$ts.tar.gz" -C "$TARGET" .
echo "Created archive: $ARCH_DIR/myapp-$ts.tar.gz"

# Remove archives older than retention
find "$ARCH_DIR" -maxdepth 1 -name '*.tar.gz' -mtime +"$RETENTION_DAYS" -print -delete
echo "Removed archives older than $RETENTION_DAYS days"
