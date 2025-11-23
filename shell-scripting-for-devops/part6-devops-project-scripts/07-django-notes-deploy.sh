#!/bin/bash
# Clone the django-notes-app, build and run with docker-compose.
# Run on a target host that has Docker & docker-compose installed.

set -euo pipefail

REPO="https://github.com/LondheShubham153/django-notes-app.git"
APP_DIR="django-notes-app"

log(){ echo "$(date '+%F %T') - $*"; }

if [[ ! -d "$APP_DIR" ]]; then
  log "Cloning repository..."
  git clone "$REPO" "$APP_DIR" || { log "git clone failed"; exit 1; }
else
  log "Repo already exists, pulling latest..."
  (cd "$APP_DIR" && git pull) || true
fi

log "Building and starting app via docker-compose..."
cd "$APP_DIR"
docker build -t notes-app . || { log "docker build failed"; exit 1; }
docker-compose up -d || { log "docker-compose up failed"; exit 1; }

log "Django Notes app deployed successfully."
