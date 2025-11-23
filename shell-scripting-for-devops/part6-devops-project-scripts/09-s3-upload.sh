#!/bin/bash
# Upload a file to S3 using AWS CLI. Ensures bucket/credentials are present.
# Usage: ./09-s3-upload.sh <LOCAL_FILE> <S3_URI>

set -euo pipefail

FILE="${1:-}"
S3_URI="${2:-}"

if [[ -z "$FILE" || -z "$S3_URI" ]]; then
  echo "Usage: $0 <LOCAL_FILE> <S3_URI>"
  exit 2
fi

if [[ ! -f "$FILE" ]]; then
  echo "Local file $FILE not found"
  exit 3
fi

# Use retry wrapper if desired:
if command -v ./08-retry-wrapper.sh &>/dev/null; then
  ./08-retry-wrapper.sh 5 5 -- aws s3 cp "$FILE" "$S3_URI"
else
  aws s3 cp "$FILE" "$S3_URI"
fi

echo "Uploaded $FILE to $S3_URI"
