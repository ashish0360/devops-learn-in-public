#!/bin/bash
# Create an EC2 instance and print the instance-id.
# Usage: ./02-create-ec2-instance.sh <AMI_ID> <INSTANCE_TYPE> <KEY_NAME> <SUBNET_ID> <SG_ID> <NAME_TAG>

set -euo pipefail

AMI="${1:-}"
TYPE="${2:-t2.micro}"
KEY="${3:-}"
SUBNET="${4:-}"
SG="${5:-}"
NAME="${6:-shell-ec2}"

if [[ -z "$AMI" || -z "$KEY" || -z "$SUBNET" || -z "$SG" ]]; then
  echo "Usage: $0 <AMI_ID> <INSTANCE_TYPE> <KEY_NAME> <SUBNET_ID> <SG_ID> <NAME_TAG>"
  exit 2
fi

instance_id=$(aws ec2 run-instances \
  --image-id "$AMI" \
  --instance-type "$TYPE" \
  --key-name "$KEY" \
  --subnet-id "$SUBNET" \
  --security-group-ids "$SG" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$NAME}]" \
  --query 'Instances[0].InstanceId' --output text)

echo "Created EC2 instance: $instance_id"
