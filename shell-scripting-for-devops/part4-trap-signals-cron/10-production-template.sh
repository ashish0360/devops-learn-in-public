#!/bin/bash
# The safest script structure for DevOps

set -euo pipefail

trap "echo 'Unexpected exit — cleaning'; cleanup" EXIT SIGINT SIGTERM

cleanup() {
    echo "Cleaning temp files..."
    rm -f /tmp/app*
}

main() {
    echo "Running main workflow..."
}

main "$@"
