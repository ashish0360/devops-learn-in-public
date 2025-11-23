#!/bin/bash
# Clean & safe Docker deployment script for Django app

set -euo pipefail

repo="https://github.com/LondheShubham153/django-notes-app.git"

# Logging function
log() {
  echo "$(date '+%F %T') — $1"
}

code_clone() {
  if [[ -d django-notes-app ]]; then
    log "Repo exists — skipping clone."
  else
    git clone "$repo"
  fi
}

install_requirements() {
  log "Installing Docker & Nginx..."
  sudo apt-get update
  sudo apt-get install -y docker.io docker-compose nginx
}

deploy() {
  log "Deploying Django app..."
  docker build -t notes-app .
  docker-compose up -d
}

main() {
  log "START DEPLOYMENT"
  code_clone || cd django-notes-app
  install_requirements
  deploy
  log "DEPLOYMENT COMPLETE"
}

main
