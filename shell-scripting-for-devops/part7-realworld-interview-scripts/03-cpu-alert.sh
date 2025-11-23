#!/bin/bash
# Simple CPU usage alert: if average CPU usage > threshold, prints a message (or extend to send alert).
# Run via cron every 1 minute or used in monitoring.
set -euo pipefail

THRESHOLD=80  # percent
# get total CPU usage % for non-idle (100 - idle)
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{print $4}' | sed 's/ id//;s/ //g')
cpu_use=$(awk "BEGIN {printf \"%.0f\", 100 - $cpu_idle}")

if (( cpu_use > THRESHOLD )); then
  echo "$(date) — HIGH CPU: ${cpu_use}% (threshold ${THRESHOLD}%)"
  # Example place to send alert: mail, webhook, slack (implement as needed)
fi
