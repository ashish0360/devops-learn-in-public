#!/bin/bash
# Cron-friendly script (no interactive commands)

set -euo pipefail
log="/var/log/health.log"

if ! systemctl is-active --quiet nginx; then
  echo "$(date) — Nginx DOWN" >> $log
  systemctl restart nginx
fi
