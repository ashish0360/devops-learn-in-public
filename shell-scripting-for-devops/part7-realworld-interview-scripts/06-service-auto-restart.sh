#!/bin/bash
# Auto-restart a systemd service if it is not active.
# Usage: ./06-service-auto-restart.sh nginx
set -euo pipefail

SERVICE="${1:-}"
if [[ -z "$SERVICE" ]]; then
  echo "Usage: $0 <service-name>"
  exit 2
fi

if systemctl is-active --quiet "$SERVICE"; then
  echo "$(date) — $SERVICE is running"
else
  echo "$(date) — $SERVICE is not running. Attempting restart..."
  sudo systemctl restart "$SERVICE"
  sleep 2
  if systemctl is-active --quiet "$SERVICE"; then
    echo "$(date) — $SERVICE restarted successfully"
  else
    echo "$(date) — Failed to restart $SERVICE"
  fi
fi
