#!/bin/bash
# Fetch basic EC2 metadata from the instance metadata service (IMDS).
# Run on EC2 instance.
set -euo pipefail

TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 60")
IMDS_BASE="http://169.254.169.254/latest"

echo "Instance ID: $(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" $IMDS_BASE/meta-data/instance-id)"
echo "Instance type: $(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" $IMDS_BASE/meta-data/instance-type)"
echo "Public IPv4: $(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" $IMDS_BASE/meta-data/public-ipv4)"
