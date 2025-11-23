#!/bin/bash
# Full EC2 provision flow: create -> wait -> fetch public IP
# Usage: ./05-ec2-full-provision.sh <AMI> <TYPE> <KEY> <SUBNET> <SG> <NAME>

set -euo pipefail

AMI="${1:-}"
TYPE="${2:-t2.micro}"
KEY="${3:-}"
SUBNET="${4:-}"
SG="${5:-}"
NAME="${6:-shell-ec2}"

if [[ -z "$AMI" || -z "$KEY" || -z "$SUBNET" || -z "$SG" ]]; then
  echo "Usage: $0 <AMI> <TYPE> <KEY> <SUBNET> <SG> <NAME>"
  exit 2
fi

# create
instance_id=$(./02-create-ec2-instance.sh "$AMI" "$TYPE" "$KEY" "$SUBNET" "$SG" "$NAME")
# wait
./03-wait-for-ec2.sh "$instance_id"
# get IP
ip=$(./04-get-public-ip.sh "$instance_id")
echo "Instance $instance_id public IP: $ip"
