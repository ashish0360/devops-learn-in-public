#!/bin/bash
# Check deploy environment argument and respond accordingly
# Usage: ./01-if-else-env-check.sh prod

env="${1:-dev}"   # default to dev if no argument provided

# Use [[ ]] for bash safe testing
if [[ "$env" == "prod" ]]; then
  echo "Deploying to PRODUCTION - be careful!"
elif [[ "$env" == "stage" ]]; then
  echo "Deploying to STAGING - tests only"
else
  echo "Deploying to DEV"
fi
