#!/bin/bash
# Extract top N IPs from an access log (common for web servers)
# Usage: ./09-extract-top-ips.sh access.log 10
set -euo pipefail

LOGFILE="${1:-access.log}"
TOPN="${2:-10}"

if [[ ! -f "$LOGFILE" ]]; then
  echo "Log file $LOGFILE not found"
  exit 2
fi

awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -rn | head -n "$TOPN"
