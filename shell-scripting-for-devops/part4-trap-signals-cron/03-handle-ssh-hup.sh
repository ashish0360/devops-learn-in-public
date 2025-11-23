#!/bin/bash
# Handle SSH disconnects (SIGHUP)

trap "echo 'SSH disconnected — cleaning resources'; exit" SIGHUP

while true; do
  echo "Working even if SSH disconnects..."
  sleep 3
done
