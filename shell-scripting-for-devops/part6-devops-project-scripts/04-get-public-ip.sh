#!/bin/bash
# Get the public IP address for a given EC2 instance id.
# Usage: ./04-get-public-ip.sh <INSTANCE_ID>

set -euo pipefail

INSTANCE_ID="${1:-}"
if [[ -z "$INSTANCE_ID" ]]; then
  echo "Usage: $0 <INSTANCE_ID>"
  exit 2
fi

public_ip=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

echo "$public_ip"
