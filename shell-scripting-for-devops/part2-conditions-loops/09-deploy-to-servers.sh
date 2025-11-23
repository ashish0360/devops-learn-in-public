#!/bin/bash
# Example: copy build to multiple servers & restart service.
# Fail-fast: stop on first error (recommended for careful deploys).
# For parallel/rolling deploys, remove fail-fast and track failures.

set -euo pipefail

servers=(web1.example.com web2.example.com web3.example.com)
artifact="./build/app.tar.gz"

for s in "${servers[@]}"; do
  echo "Deploying to $s..."
  scp "$artifact" "$s:/tmp/" || { echo "SCP failed to $s"; exit 1; }
  ssh "$s" "tar -xzf /tmp/app.tar.gz -C /opt/app && sudo systemctl restart app" || { echo "Remote deploy failed on $s"; exit 1; }
  echo "Deployed to $s successfully"
done
