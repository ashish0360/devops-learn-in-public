#!/bin/bash
# Logging with timestamps

log() {
  echo "$(date '+%F %T') — $1"
}

log "Starting backup..."
sleep 1
log "Backup completed"
