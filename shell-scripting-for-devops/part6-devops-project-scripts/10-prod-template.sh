#!/bin/bash
# Production-ready template for cloud automation scripts.
# Includes strict mode, logging, trap cleanup and modular functions.

set -euo pipefail
trap 'echo "$(date) - Script exiting; running cleanup"; cleanup' EXIT

cleanup() {
  # remove temporary files or revert changes here
  rm -f /tmp/provision-*.tmp 2>/dev/null || true
  echo "$(date) - cleanup completed"
}

log() { echo "$(date '+%F %T') - $*"; }

main() {
  log "Starting main workflow"
  # example step: check AWS CLI
  if ! command -v aws &>/dev/null; then
    log "AWS CLI not found. Run 01-install-aws-cli.sh first."
    exit 1
  fi

  # Put provisioning steps here, or call other scripts in order:
  # ./02-create-ec2-instance.sh ...
  log "Main workflow completed successfully"
}

main "$@"
