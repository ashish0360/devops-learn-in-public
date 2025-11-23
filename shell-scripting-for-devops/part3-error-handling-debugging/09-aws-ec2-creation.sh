#!/bin/bash
# Safe AWS EC2 instance creation script

set -euo pipefail

AMI="ami-xxxxxx"
TYPE="t2.micro"
KEY="mykey"
SG="sg-xxxx"
SUBNET="subnet-xxxx"

instance_id=$(aws ec2 run-instances \
  --image-id "$AMI" \
  --instance-type "$TYPE" \
  --key-name "$KEY" \
  --security-group-ids "$SG" \
  --subnet-id "$SUBNET" \
  --query 'Instances[0].InstanceId' \
  --output text)

echo "EC2 instance created: $instance_id"
