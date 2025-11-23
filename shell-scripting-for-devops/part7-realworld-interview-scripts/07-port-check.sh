#!/bin/bash
# Check if a TCP port is open on localhost. Uses nc (netcat).
# Usage: ./07-port-check.sh <port>
set -euo pipefail

PORT="${1:-}"
if [[ -z "$PORT" ]]; then
  echo "Usage: $0 <port>"
  exit 2
fi

if nc -zv -w3 127.0.0.1 "$PORT" 2>/dev/null; then
  echo "$(date) — Port $PORT is open"
else
  echo "$(date) — Port $PORT is closed or not responding"
fi
