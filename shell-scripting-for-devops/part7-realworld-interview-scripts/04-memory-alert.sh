#!/bin/bash
# Memory alert: if used memory percentage > threshold, log message.
set -euo pipefail

THRESHOLD=85  # percent

# free -m output: total used free buff/cache available
read total used free shared buff cache available < <(awk '/Mem:/ {print $2, $3, $4, $5, $6, $7, $7}' <(free -m))
# compute used percentage (approx)
used_percent=$(awk "BEGIN {printf \"%d\", ($used/$total)*100}")

if (( used_percent > THRESHOLD )); then
  echo "$(date) — HIGH MEMORY: ${used_percent}% (threshold ${THRESHOLD}%)"
fi
