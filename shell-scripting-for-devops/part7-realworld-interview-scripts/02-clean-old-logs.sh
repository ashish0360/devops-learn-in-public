#!/bin/bash
# Delete logs older than X days to avoid disk full errors.
# Usage: ./02-clean-old-logs.sh [days], default days=30
set -euo pipefail

DAYS="${1:-30}"
TARGET="/var/log"

# find files older than DAYS and delete
find "$TARGET" -type f -mtime +"$DAYS" -print -exec rm -f {} \;
echo "Deleted files older than $DAYS days in $TARGET"
