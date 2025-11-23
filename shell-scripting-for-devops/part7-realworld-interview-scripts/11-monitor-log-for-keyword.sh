#!/bin/bash
# Tail a log and alert (prints to stdout). Use in tmux/daemon or extend to webhook.
# Usage: ./11-monitor-log-for-keyword.sh /var/log/app.log "ERROR"
set -euo pipefail

LOG="${1:-}"
KEY="${2:-ERROR}"

if [[ -z "$LOG" ]]; then
  echo "Usage: $0 <logfile> [keyword]"
  exit 2
fi

# tail -F follows even if file rotates
tail -F "$LOG" | while read -r line; do
  if grep -qi "$KEY" <<< "$line"; then
    echo "$(date) — KEYWORD FOUND: $line"
    # add alert action here (mail, webhook, etc.)
  fi
done
