#!/bin/bash
set -euo pipefail

# Always run cleanup before exit
trap "rm -f /tmp/app*; echo 'Cleanup done.'" EXIT

log() {
    echo "$(date) — $1"
}

process_logs() {
    for log_file in *.log; do
        log "Processing $log_file"
        grep -i "error" "$log_file" >> combined_errors.txt
    done
}

main() {
    log "Started processing"
    process_logs
    log "Completed processing"
}

main "$@"
