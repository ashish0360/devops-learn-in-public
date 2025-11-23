#!/bin/bash
# Delete AWS EBS snapshots older than a given date (use a dedicated IAM user/role).
# WARNING: destructive. Test carefully in dev account.
# Usage: ./14-aws-delete-old-snapshots.sh 2024-01-01
set -euo pipefail

CUTOFF="${1:-}"
if [[ -z "$CUTOFF" ]]; then
  echo "Usage: $0 <YYYY-MM-DD>"
  exit 2
fi

# List snapshots owned by self and filter by StartTime < cutoff. Requires jq.
aws ec2 describe-snapshots --owner-ids self --query 'Snapshots[].{ID:SnapshotId,StartTime:StartTime}' --output json \
  | jq -r --arg cutoff "$CUTOFF" '.[] | select(.StartTime < $cutoff) | .ID' \
  | while read -r snap; do
      echo "Deleting snapshot $snap"
      aws ec2 delete-snapshot --snapshot-id "$snap"
    done
