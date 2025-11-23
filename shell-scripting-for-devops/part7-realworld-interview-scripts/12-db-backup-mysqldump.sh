#!/bin/bash
# Simple MySQL backup script (use with low-privilege backup user)
# Usage: ./12-db-backup-mysqldump.sh dbname /backup/dir
set -euo pipefail

DB="${1:-}"
OUTDIR="${2:-/tmp/db-backups}"
mkdir -p "$OUTDIR"

if [[ -z "$DB" ]]; then
  echo "Usage: $0 <dbname> [outdir]"
  exit 2
fi

DATE=$(date +%F-%H%M)
OUTFILE="$OUTDIR/${DB}_backup_${DATE}.sql.gz"

# Use ~/.my.cnf with credentials or environment variables to avoid exposing password on cmdline
mysqldump "$DB" | gzip > "$OUTFILE"
echo "Backup written to $OUTFILE"
