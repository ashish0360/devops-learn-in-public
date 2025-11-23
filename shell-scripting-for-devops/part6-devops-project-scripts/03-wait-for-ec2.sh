#!/bin/bash
# Wait until an EC2 instance reaches the "running" state.
# Usage: ./03-wait-for-ec2.sh <INSTANCE_ID>

set -euo pipefail

INSTANCE_ID="${1:-}"
if [[ -z "$INSTANCE_ID" ]]; then
  echo "Usage: $0 <INSTANCE_ID>"
  exit 2
fi

echo "Waiting for instance $INSTANCE_ID to become 'running'..."
while true; do
  state=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" \
    --query 'Reservations[0].Instances[0].State.Name' --output text)
  echo "Current state: $state"
  if [[ "$state" == "running" ]]; then
    echo "Instance $INSTANCE_ID is running."
    break
  fi
  sleep 8
done
