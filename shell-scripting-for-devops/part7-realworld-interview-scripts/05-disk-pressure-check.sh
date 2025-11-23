#!/bin/bash
# Check filesystem usage and print filesystems > threshold
set -euo pipefail

THRESHOLD=85  # percent

df -h --output=pcent,target | tail -n +2 | while read pct mountpoint; do
  pct_num=${pct%\%}
  if (( pct_num >= THRESHOLD )); then
    echo "$(date) — High disk usage: ${pct} on ${mountpoint}"
  fi
done
