#!/bin/bash
# Install AWS CLI v2 if not present.
# Idempotent: will skip install if aws command exists.

set -euo pipefail

install_aws_cli() {
  echo "Installing AWS CLI v2..."
  curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  sudo apt-get update -y
  sudo apt-get install -y unzip
  unzip -q awscliv2.zip
  sudo ./aws/install
  rm -rf aws awscliv2.zip
  aws --version
  echo "AWS CLI installed."
}

if command -v aws &>/dev/null; then
  echo "AWS CLI already installed: $(aws --version 2>/dev/null | head -n1)"
else
  install_aws_cli
fi
