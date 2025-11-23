#!/bin/bash
# Install Docker & Nginx, build the Docker image and run docker-compose.
# Intended to run on the provisioned server.

set -euo pipefail

log() { echo "$(date '+%F %T') - $*"; }

log "Installing Docker and prerequisites..."
sudo apt-get update -y
sudo apt-get install -y docker.io docker-compose nginx

log "Ensure current user can access docker socket..."
sudo chown "$USER" /var/run/docker.sock || true

# Build and bring up application (assumes Dockerfile and docker-compose.yml present)
log "Building Docker image..."
docker build -t myapp . || { log "Docker build failed"; exit 1; }

log "Starting containers with docker-compose..."
docker-compose up -d || { log "docker-compose up failed"; exit 1; }

log "Deployment finished."
