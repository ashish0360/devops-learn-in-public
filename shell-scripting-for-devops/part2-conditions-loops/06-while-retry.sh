#!/bin/bash
# Retry a command up to max attempts with sleep between tries.
# Use for transient network calls.

max=5
count=0

while true; do
  if curl -sSf http://localhost:8080/health >/dev/null; then
    echo "Service healthy"
    break
  fi

  ((count++))
  if [[ $count -ge $max ]]; then
    echo "Service unhealthy after $count attempts"
    exit 1
  fi

  echo "Retrying in 5s... (attempt $count)"
  sleep 5
done
