#!/bin/bash
# Retry wrapper to execute a command multiple times with delay.
# Usage: retry <max_attempts> <delay_seconds> -- command args...
# Example: retry 5 3 -- aws s3 ls s3://mybucket

set -euo pipefail

if [[ $# -lt 4 || "$3" != "--" ]]; then
  echo "Usage: $0 <max_attempts> <delay_seconds> -- <command...>"
  exit 2
fi

max="$1"; delay="$2"; shift 2; shift 1  # shift off max, delay and the '--'
n=1
until "$@"; do
  if (( n >= max )); then
    echo "Command failed after $n attempts."
    return 1
  fi
  echo "Attempt $n failed — retrying in $delay seconds..."
  ((n++))
  sleep "$delay"
done
